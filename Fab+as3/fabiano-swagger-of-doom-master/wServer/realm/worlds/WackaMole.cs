#region

using System;
using System.Linq;
using System.Collections.Generic;
using wServer.realm.entities.player;
using wServer.networking.svrPackets;
using wServer.networking;

#endregion

namespace wServer.realm.worlds
{
    public class WackaMole : World
    {
        public bool ready = true;
        private bool wait;
        public int wave = 0;
        public bool playercounted = false;

        public WackaMole()
        {
            Name = "WackaMole";
            ClientWorldName = "WackaMole";
            Dungeon = true;
            Background = 0;
            AllowTeleport = false;
        }

        protected override void Init()
        {
            LoadMap("wServer.realm.worlds.maps.wackamole.jm", MapType.Json);
        }


        public override World GetInstance(Client psr)
        {
            return Manager.AddWorld(new WackaMole());
        }

        private void CheckOutOfBounds()
        {
            foreach (var i in Enemies.Values)
            {
                var x = (int)i.X;
                var y = (int)i.Y;
                if (Map[x, y].TileId == 0x00)
                {
                    LeaveWorld(i);
                }
            }
        }

        private bool CheckPopulation()
        {
            if (Enemies.Count <= 3)
            {
                return true;
            }
            return false;
        }

        public override void Tick(RealmTime time)
        {
            base.Tick(time);
            CheckOutOfBounds();

            if (playercounted == true)
            {
                foreach (var i in Players.Values)
                {
                    if (i.Owner.Players.Count == 0)
                    {
                        Manager.RemoveWorld(this);
                        Dispose();
                    }
                }
            }

            Timers.Add(new WorldTimer(61000, (w, t) => {
                foreach (var i in Enemies.Values)
                {
                    LeaveWorld(i);
                }
                ready = false;
                Disconnect();
            }));

            if (CheckPopulation())
            {
                if (ready)
                {                    
                    if (wait) return;
                    wave++;
                    playercounted = true;
                    ready = false;
                    foreach (KeyValuePair<int, Player> i in Players)
                    {
                        i.Value.Client.SendPacket(new ArenaNextWavePacket
                        {
                            Type = wave
                        });
                    }
                    wait = true;
                    Timers.Add(new WorldTimer(50, (w, t) =>
                    {
                        ready = false;
                        Spawn();
                        wait = false;
                    }));
                }
                ready = true;
            }
        }

        private void Disconnect()
        {
            foreach (KeyValuePair<int, Player> i in Players)
            {
                i.Value.Client.Player.SendInfo("Times Up!");
            }

            Timers.Add(new WorldTimer(5000, (world, t) =>
            {
                foreach (var i in world.Players.Values)
                {
                    i.Client.SendPacket(new ReconnectPacket
                    {
                        Host = "",
                        Port = Program.Settings.GetValue<int>("port"),
                        GameId = World.NEXUS_ID,
                        Name = "nexus.Nexus",
                        Key = Empty<byte>.Array,
                    });
                }
                Manager.RemoveWorld(this);
                Dispose();
            }));
        }


        private readonly string[] Black =
        {
           "Black Wack", "Normal Wack", "Golden Wack"
        };



        private void Spawn()
        {
            try
            {
                List<string> enems = new List<string>();
                Random r = new Random();

                for (int i = 0; i < 1; i++)
                {
                    enems.Add(Black[r.Next(0, 3)]);
                }
                foreach (string i in enems)
                {
                    ushort id = Manager.GameData.IdToObjectType[i];
                    Entity enemy = Entity.Resolve(Manager, id);

                    int wave1 = wave / wave + 1;

                    if (new int[] { 1, 5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61, 65, 69, 73, 77, 81, 85, 89, 93, 97, 101, 105, 109, 113, 117 }.Contains(wave))
                    {
                        enemy.Move(1.5f, 2.5f);
                    }
                    if (new int[] { 2, 6, 10, 14, 18, 22, 26, 30, 34, 38, 42, 46, 50, 54, 58, 62, 66, 70, 74, 78, 82, 86, 90, 94, 98, 102, 106, 110, 114, 118 }.Contains(wave))
                    {
                        enemy.Move(3.5f, 1.5f);
                    }

                    if (new int[] { 3, 7, 11, 15, 19, 23, 27, 31, 35, 39, 43, 47, 51, 55, 59, 63, 67, 71, 75, 79, 83, 87, 91, 95, 99, 103, 107, 111, 115, 119}.Contains(wave))
                    {
                        enemy.Move(5.5f, 1.5f);
                    }
                    if (new int[]{ 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80, 84, 88, 92, 96, 100, 104, 108, 112, 116, 120 }.Contains(wave))
                    {
                        enemy.Move(7.5f, 2.5f);
                    }

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