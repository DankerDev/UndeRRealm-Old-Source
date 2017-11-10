using common.resources;
using wServer.networking;
using wServer.networking.packets.outgoing;
using wServer.realm.entities;
using wServer.realm.terrain;
using System.Linq;
using System;
using System.Collections.Generic;

namespace wServer.realm.worlds.logic
{
    public class WackaMole : Tower
    {
        int count;

        public WackaMole(ProtoWorld pw, Client client = null) : base(pw)
        {
            Boss = "Oryx the Mad God 1";
            count = 1;
        }

        protected override void Init()
        {
            base.Init();
        }

        public override void Tick(RealmTime time)
        {
            base.Tick(time);

            if (count == 1)
            {
                SpawnBoss(2f, 2f);
                count++;
            }

            if (CheckPopulation())
            {
                foreach (var i in Players.Values)
                {
                    i.SendInfo("Floor Cleared!");
                    Timers.Add(new WorldTimer(3000, (w, t) =>
                    {
                        i.Client.SendPacket(new NextFloorPacket
                        {
                            Floor = Floors
                        });
                    }));
                    return;
                }
            }                      
        }
    }
}
