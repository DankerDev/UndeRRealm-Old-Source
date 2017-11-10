using common;
using common.resources;

namespace wServer.networking.packets.incoming
{
    class SellItem : IncomingMessage
    {
        public ObjectSlot ObjSlot { get; set; }
        public ObjectSlot ObjSlot1 { get; set; }
        public ObjectSlot ObjSlot2 { get; set; }
        public ObjectSlot ObjSlot3 { get; set; }

        public override PacketId ID => PacketId.SELLITEM;

        public override Packet CreateInstance() { return new SellItem(); }

        protected override void Read(NReader rdr)
        {
            ObjSlot = ObjectSlot.Read(rdr);
            ObjSlot1 = ObjectSlot.Read(rdr);
            ObjSlot2 = ObjectSlot.Read(rdr);
            ObjSlot3 = ObjectSlot.Read(rdr);
        }
		
        protected override void Write(NWriter wtr)
        {
            ObjSlot.Write(wtr);
            ObjSlot1.Write(wtr);
            ObjSlot2.Write(wtr);
            ObjSlot3.Write(wtr);
        }
    }
}
