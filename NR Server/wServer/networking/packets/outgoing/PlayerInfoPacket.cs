using System;
using common;

namespace wServer.networking.packets.outgoing
{
    public class PlayerInfoPacket : OutgoingMessage
    {
        public int AccId { get; set; }
        public int Rank { get; set; } 

        public override PacketId ID => PacketId.PLAYER_INFO;
        public override Packet CreateInstance() { return new PlayerInfoPacket(); }

        protected override void Read(NReader rdr)
        {
            AccId = rdr.ReadInt32();
            Rank = rdr.ReadInt32();
        }

        protected override void Write(NWriter wtr)
        {
            wtr.Write(AccId);
            wtr.Write(Rank);
        }
    }
}
