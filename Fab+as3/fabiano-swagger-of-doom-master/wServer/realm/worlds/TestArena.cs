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
    public class TestArena : World
    {
        private bool ready = true;
        private bool waiting;

        Random r = new Random();

        public TestArena()
        {
            Name = "Test Arena";
            ClientWorldName = "Test Arena";
            Dungeon = true;
            Background = 0;
            AllowTeleport = true;
        }

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.testarena.jm", MapType.Json);
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
            else
            {
                return false;
            }
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
                    waiting = true;
                    Timers.Add(new WorldTimer(5000, (world, t) =>
                    {
                        Spawn();                                                               
                        waiting = false;
                        ready = false;
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
           "Cube God", "Lord of the Lost Lands", "Skull Shrine" //add more
        };


        private void Spawn()
        {
            try
            {
                List<string> enems = new List<string>();              

                for (int i = 0; i < 1; i++)
                {
                    enems.Add(Events[r.Next(0, Events.Length)]);
                }
                Random r2 = new Random();
                foreach (string i in enems)
                {
                    ushort id = Manager.GameData.IdToObjectType[i];
                    int x = r2.Next(10, Map.Width) - 6;
                    int y = r2.Next(10, Map.Height) - 6;
                    Entity enemy = Entity.Resolve(Manager, id);
                    enemy.Move(x, y);
                    EnterWorld(enemy);
                    string name = i.ToString();
                    foreach (var p in Players.Values)
                    {
                        p.SendInfo(name + " has Appeared at x:" + x.ToString() + ",y:" + y.ToString());
                    }
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex);
            }
        }
    }
}