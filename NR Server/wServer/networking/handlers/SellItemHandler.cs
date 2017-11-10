using common.resources;
using wServer.networking.packets;
using wServer.networking.packets.incoming;
using wServer.networking.packets.outgoing;
using wServer.realm.worlds.logic;
using wServer.realm.entities;
using System;
using System.Collections.Generic;


namespace wServer.networking.handlers
{
    class SellItemHandler : PacketHandlerBase<SellItem>
    {
        public override PacketId ID => PacketId.SELLITEM;

        public int price = 0;

        protected override void HandlePacket(Client client,  SellItem packet)
        {
            Handle(client, packet);
        }

        private void Handle(Client client, SellItem packet)
        {
            var slotone = packet.ObjSlot.SlotId;
            var slottwo = packet.ObjSlot1.SlotId;
            var slotthree = packet.ObjSlot2.SlotId;
            var slotfour = packet.ObjSlot3.SlotId;

            int price = 0;

            if (client.Player.Inventory[slotone] != null && slotone != 0 && slotone != 1 && slotone != 2 && slotone != 3)
            {
                price += client.Player.Inventory[slotone].Price;
                client.Player.Inventory[slotone] = null;
            }
            if (client.Player.Inventory[slottwo] != null && slottwo != 0 && slottwo != 1 && slottwo != 2 && slottwo != 3)
            {
                price += client.Player.Inventory[slottwo].Price;
                client.Player.Inventory[slottwo] = null;
            }
            if (client.Player.Inventory[slotthree] != null && slotthree != 0 && slotthree != 1 && slotthree != 2 && slotthree != 3)
            {
                price += client.Player.Inventory[slotthree].Price;
                client.Player.Inventory[slotthree] = null;
            }
            if (client.Player.Inventory[slotfour] != null && slotfour != 0 && slotfour != 1 && slotfour != 2 && slotfour != 3)
            {
                price += client.Player.Inventory[slotfour].Price;
                client.Player.Inventory[slotfour] = null;
            }
            client.Player.Credits += price;
            client.Player.SendInfo("You've recieved "+ price + " Gold!");
            client.Account.FlushAsync();
        }
       
        private void ConvertId(Client client, SellItem packet)
        {
            client.SendPacket(new BuyShopPacket
            {
                ObjId = packet.ObjSlot.ObjectId,
                ObjId1 = packet.ObjSlot1.ObjectId,
                ObjId2 = packet.ObjSlot2.ObjectId,
                ObjId3 = packet.ObjSlot3.ObjectId,
                Price = price,
            });
        }
    }
}
