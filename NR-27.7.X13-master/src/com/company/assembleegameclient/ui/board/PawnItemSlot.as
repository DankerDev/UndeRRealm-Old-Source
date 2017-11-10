package com.company.assembleegameclient.ui.board {
import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.utils.getTimer;

import kabam.rotmg.constants.ItemConstants;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.fortune.components.TimerCallback;
import kabam.rotmg.messaging.impl.data.SlotObjectData;
import kabam.rotmg.pets.data.PetSlotsState;
import kabam.rotmg.pets.util.PetsViewAssetFactory;
import kabam.rotmg.pets.view.components.slot.FoodFeedFuseSlot;
import kabam.rotmg.text.model.FontModel;
import kabam.rotmg.util.components.LegacyBuyButton;

public class PawnItemSlot extends FoodFeedFuseSlot {

    public var interactable:Boolean = false;
    private var usageText:TextField;
    private var actionButton:LegacyBuyButton = null;
    public var embeddedImage_:Bitmap;
    public var embeddedSprite_:Sprite;
    public var embeddedSpriteCopy_:Sprite;
    private var dir:Number = 0.018;
    private var hovering:Boolean = false;
    public var xml:XML = null;

    public function PawnItemSlot(_arg1:Boolean = false, _arg2:Boolean = false) {
        var _local3:Shape;
        var _local4:int;
        super();
        if (_arg1) {
            this.interactable = _arg1;
            addEventListener(MouseEvent.ROLL_OVER, this.onMouseOverGoalSlot);
        }
        if (_arg2) {
            addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        }
    }

    override public function updateTitle():void {
        if (!empty) {
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            if (this.actionButton) {
                this.actionButton.setOutLineColor(196098);
                this.actionButton.draw();
            }
            if (((!((this.embeddedSprite_ == null))) && (!((this.embeddedSprite_.parent == null))))) {
                this.embeddedSpriteCopy_.visible = false;
                this.embeddedSpriteCopy_.alpha = 0;
                this.embeddedSprite_.alpha = 1;
            }
        }
        else {
            if (((!((this.embeddedSprite_ == null))) && (!((this.embeddedSprite_.parent == null))))) {
                this.embeddedSpriteCopy_.visible = true;
            }
            if (this.actionButton) {
                this.actionButton.setOutLineColor(0x545454);
                this.actionButton.draw();
            }
        }
    }

    private function onMouseOverGoalSlot(_arg1:Event):void {
        if (empty) {
            this.hovering = true;
            if (((!((this.usageText == null))) && ((this.usageText.parent == null)))) {
                addChild(this.usageText);
            }
            removeEventListener(MouseEvent.ROLL_OVER, this.onMouseOverGoalSlot);
            addEventListener(MouseEvent.ROLL_OUT, this.onMouseOutsideGoalSlot);
        }
    }

    private function onMouseOutsideGoalSlot(_arg1:Event):void {
        if (empty) {
            this.hovering = false;
            new TimerCallback(0.5, this.removeIfStillOutside);
            addEventListener(MouseEvent.ROLL_OVER, this.onMouseOverGoalSlot);
            removeEventListener(MouseEvent.ROLL_OUT, this.onMouseOutsideGoalSlot);
        }
    }

    private function removeIfStillOutside():void {
        if ((((((this.hovering == false)) && (!((this.usageText == null))))) && (!((this.usageText.parent == null))))) {
            removeChild(this.usageText);
        }
    }

    private function onEnterFrame(_arg1:Event):void {
        if (this.embeddedImage_) {
            if ((((this.embeddedSprite_.alpha == 1)) || ((this.embeddedSprite_.alpha == 0)))) {
                this.dir = (this.dir * -1);
            }
            this.embeddedSprite_.alpha = (this.embeddedSprite_.alpha + this.dir);
            this.embeddedSpriteCopy_.alpha = (this.embeddedSpriteCopy_.alpha - this.dir);
            if (this.embeddedSprite_.alpha >= 1) {
                this.embeddedSprite_.alpha = 1;
                this.embeddedSpriteCopy_.alpha = 0;
            }
            else {
                if (this.embeddedSprite_.alpha <= 0) {
                    this.embeddedSprite_.alpha = 0;
                    this.embeddedSpriteCopy_.alpha = 1;
                }
            }
        }
    }
}
}
