package com.company.assembleegameclient.ui.panels {

import com.company.assembleegameclient.account.ui.Frame;
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.board.PawnShop;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;

import kabam.rotmg.text.model.TextKey;

public class SellItemPanel extends ButtonPanel{

    public var player:Player;
    public var opened:Boolean = false;

    public function SellItemPanel(_arg1:GameSprite) {
        super(_arg1,"Pawn Shop", "Open");
        addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
        addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
    }

    override protected function onButtonClick(_arg1:MouseEvent):void {
        this.openWindow();
    }

    private function openWindow():void {
        if (this.opened == false){
            this.gs_.addChild(new PawnShop(300, 300));
            this.opened = true;
        }
    }

    private function onAddedToStage(_arg1:Event):void {
        stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    private function onRemovedFromStage(_arg1:Event):void {
        stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    private function onKeyDown(_arg1:KeyboardEvent):void {
        if ((((_arg1.keyCode == Parameters.data_.interact)) && ((stage.focus == null)))) {
            this.openWindow();
        }
    }
}
}
