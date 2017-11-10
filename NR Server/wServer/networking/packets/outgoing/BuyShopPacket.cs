using System;
using common;

namespace wServer.networking.packets.outgoing
{
    public class BuyShopPacket : OutgoingMessage
    {
        public int ObjId { get; set; }
        public int ObjId1 { get; set; }
        public int ObjId2 { get; set; }
        public int ObjId3 { get; set; }
        public int Price { get; set; }
    
        public override PacketId ID => PacketId.BUYITEM;
        public override Packet CreateInstance() { return new BuyShopPacket(); }

        protected override void Read(NReader rdr)
        {
            ObjId = rdr.ReadInt32();
            ObjId1 = rdr.ReadInt32();
            ObjId2 = rdr.ReadInt32();
            ObjId3 = rdr.ReadInt32();
            Price = rdr.ReadInt32();
        }

        protected override void Write(NWriter wtr)
        {
            wtr.Write(ObjId);
            wtr.Write(ObjId1);
            wtr.Write(ObjId2);
            wtr.Write(ObjId3);
            wtr.Write(Price);
        }
    }
}
