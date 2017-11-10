#region

using System;
using System.Collections.Generic;
using wServer.networking.svrPackets;
using wServer.networking;
using wServer.realm.entities;
using wServer.realm.entities.player;

#endregion

namespace wServer.realm.worlds
{
    public class XpRoom : World
    {
        public int wave = 1;
        private bool ready = true;
        private bool waiting;
        public XpRoom()
        {
            Name = "Xp Room";
            ClientWorldName = "Xp Room";
            Dungeon = true;
            Background = 0;
            AllowTeleport = false;
        }

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.XpRoom.jm", MapType.Json);
        }


        public override World GetInstance(Client psr)
        {
            return Manager.AddWorld(new TestArena());
        }

        public bool OutOfBounds(float x, float y)
        {
            if (Map.Height >= y && Map.Width >= x && x > -1 && y > 0)
                return (Map[(int)x, (int)y].TileId == 0xff);
            else
                return true;
        }

        private bool CheckPopulation()
        {
            if (Enemies.Count == 0)
            {
                return true;
            }
            if (Enemies.Count == 8)
            {
                return false;
            }
            return false;
        }

        public override void Tick(RealmTime time)
        {
            base.Tick(time);
            CheckOutOfBounds();

            if (CheckPopulation())
            {
                if (ready)
                {
                    if (waiting) return;
                    ready = false;
                    wave++;
                    foreach (KeyValuePair<int, Player> i in Players)
                    {
                        i.Value.Client.SendPacket(new ArenaNextWavePacket
                        {
                            Type = wave
                        });
                    }
                    waiting = true;
                    Timers.Add(new WorldTimer(5000, (world, t) =>
                    {
                        ready = false;
                        Spawn();
                        waiting = false;
                    }));
                }
                ready = true;
            }
        }

        private void CheckOutOfBounds()
        {
            foreach (KeyValuePair<int, Enemy> i in Enemies)
            {
                if (OutOfBounds(i.Value.X, i.Value.Y))
                {
                    LeaveWorld(i.Value);
                }
            }
        }

        private readonly string[] Events =
        {
           "Xp Gift A"
        };


        private void Spawn()
        {
            try
            {
                List<string> enems = new List<string>();
                Random r = new Random();

                for (int i = 0; i < 4; i++)
                {
                    enems.Add(Events[r.Next(0, Events.Length)]);
                }
                Random r2 = new Random();
                foreach (string i in enems)
                {
                    ushort id = Manager.GameData.IdToObjectType[i];
                    int xloc = r2.Next(10, Map.Width) - 6;
                    int yloc = r2.Next(10, Map.Height) - 6;
                    Entity enemy = Entity.Resolve(Manager, id);
                    enemy.Move(xloc, yloc);
                    EnterWorld(enemy);
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex);
            }
        }
    }
}