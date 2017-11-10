using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Threading;
using common;
using common.resources;
using log4net;
using wServer.logic.loot;
using wServer.networking;
using wServer.networking.packets;
using wServer.networking.packets.outgoing;
using wServer.realm.entities;
using wServer.realm.entities.vendors;
using wServer.realm.terrain;
using wServer.realm.worlds.logic;

namespace wServer.realm.worlds
{
    public class Tower : World
    {
        public string Boss { get; set; }
        public string[] MiniBoss { get; set; }
        public string[] Monsters { get; set;}
        public int Floors { get; set; }

        public Tower(ProtoWorld proto) : base (proto)
        {

        }

        public bool CheckPopulation()
        {
            if (Enemies.Count == 0) return true;
            else return false;
        }

        public void SpawnBoss(float x, float y)
        {
            ushort id = Manager.Resources.GameData.IdToObjectType[Boss];
            Entity enem = Entity.Resolve(Manager, id);

            enem.Move(x, y);
            EnterWorld(enem);
        }

        public void SpawnMini(int amount, float x, float y)
        {
            List<string> enems = new List<string>();

            for (int i = amount; i <= amount; i++)
            {
                enems.Add(MiniBoss[i]);
            }
            foreach(string i in enems)
            {
                ushort id = Manager.Resources.GameData.IdToObjectType[i];
                Entity enem = Entity.Resolve(Manager, id);

                enem.Move(x, y);
                EnterWorld(enem);
            }
        }

        public void SpawnMonsters(int amount, int x1, int x2, int y1, int y2)
        {
            List<string> enems = new List<string>();

            for (int i = amount; i <= amount; i++)
            {
                enems.Add(Monsters[i]);
            }
            foreach (string i in enems)
            {
                ushort id = Manager.Resources.GameData.IdToObjectType[i];
                Random x = new Random();
                Random y = new Random();
                Entity enem = Entity.Resolve(Manager, id);

                x.Next(x1, x2);
                y.Next(y1, y2);

                enem.Move(Convert.ToInt32(x), Convert.ToInt32(y));
                EnterWorld(enem);
            }
        }
    }
}
