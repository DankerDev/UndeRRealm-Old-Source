using System;
using common;

namespace wServer.networking.packets.outgoing
{
    public class NextFloorPacket : OutgoingMessage
    {
        public int Floor { get; set; }

        public override PacketId ID => PacketId.FLOOR_PCK;

        public override Packet CreateInstance()
        {
            return new NextFloorPacket();
        }

        protected override void Read(NReader rdr)
        {
            Floor = rdr.ReadInt32();
        }

        protected override void Write(NWriter wtr)
        {
            wtr.Write(Floor);
        }

    }
}
