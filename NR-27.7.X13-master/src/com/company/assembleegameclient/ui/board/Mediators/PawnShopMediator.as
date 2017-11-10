/**
 * Created by MZT on 10/15/2017.
 */
package com.company.assembleegameclient.ui.board.Mediators {
import com.company.assembleegameclient.ui.board.PawnShop;
import com.company.assembleegameclient.util.Currency;

import kabam.rotmg.messaging.impl.GameServerConnectionConcrete;

import kabam.rotmg.messaging.impl.outgoing.SellItem;

import robotlegs.bender.bundles.mvcs.Mediator;
import kabam.lib.net.api.MessageProvider;
import kabam.lib.net.impl.SocketServer;
import kabam.rotmg.messaging.impl.GameServerConnection;

import org.swiftsuspenders.Injector;

public class PawnShopMediator extends Mediator{

    [Inject]
    public var pawn:PawnShop;
    [Inject]
    public var socket:SocketServer;
    [Inject]
    public var message:MessageProvider;

    override public function initialize():void {
        this.pawn.signal.add(onSell);
    }

    private function onSell(_arg1:int){
        if (_arg1 == Currency.GOLD)
        {
            Sell();
        }
    }

    private function Sell():void {
        var _local2:SellItem;
        _local2 = (this.message.require(GameServerConnection.SELLITEM)as SellItem);

        if (this.pawn.itemSlot.slotId != -1) {
            _local2.objSlot.slotId_ = this.pawn.itemSlot.slotId;
            this.pawn.itemSlot.clearItem();
        }
        if (this.pawn.itemSlot1.slotId != -1)
        {
            _local2.objSlot1.slotId_ = this.pawn.itemSlot1.slotId;
            this.pawn.itemSlot1.clearItem();
        }
        if (this.pawn.itemSlot2.slotId != -1)
        {
            _local2.objSlot2.slotId_ = this.pawn.itemSlot2.slotId;
            this.pawn.itemSlot2.clearItem();
        }
        if (this.pawn.itemSlot3.slotId != -1)
        {
            _local2.objSlot3.slotId_ = this.pawn.itemSlot3.slotId;
            this.pawn.itemSlot3.clearItem();
        }
        socket.queueMessage(_local2);
    }

}
}
