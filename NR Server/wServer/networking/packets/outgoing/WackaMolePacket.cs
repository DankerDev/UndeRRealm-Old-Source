using System;
using common;

namespace wServer.networking.packets.outgoing
{
    class WackaMolePacket : OutgoingMessage
    {
        public int Wave { get; set; }
        public int Difficulty { get; set; }

        public override PacketId ID => PacketId.WACKAMOLE_HANDLER;
       
        public override Packet CreateInstance()
        {
            return new WackaMolePacket();
        }

        protected override void Read(NReader rdr)
        {
            Wave = rdr.ReadInt32();
            Difficulty = rdr.ReadInt32();
        }

        protected override void Write(NWriter wtr)
        {
            wtr.Write(Wave);
            wtr.Write(Difficulty);
        }
    }
}
