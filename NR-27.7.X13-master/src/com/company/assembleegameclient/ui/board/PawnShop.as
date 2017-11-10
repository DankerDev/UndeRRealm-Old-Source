
package com.company.assembleegameclient.ui.board {

import com.adobe.utils.XMLUtil;
import com.company.assembleegameclient.game.AGameSprite;
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.SellItemPanel;
import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
import com.company.assembleegameclient.util.Currency;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;

import flash.events.MouseEvent
import flash.display.Sprite;
import flash.geom.ColorTransform;
import flash.text.TextFieldAutoSize;
import flash.ui.Mouse;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import com.company.assembleegameclient.ui.board.PawnItemSlot;

import org.osflash.signals.Signal;

import spark.primitives.Line;

public class PawnShop extends Sprite{

    public var signal:Signal = new Signal(int);

    private var sellBox:Sprite;
    private var confBox:Sprite;

    private var buybackg:Sprite;
    private var sellbackg:Sprite;

    public var amount:int;


    private var sellpanel:SellItemPanel;
    public var itemSlot:PawnItemSlot;
    public var itemSlot1:PawnItemSlot;
    public var itemSlot2:PawnItemSlot;
    public var itemSlot3:PawnItemSlot;


    private var title:TextFieldDisplayConcrete;
    private var close:TextFieldDisplayConcrete;
    private var sell:TextFieldDisplayConcrete;
    private var displayPrice:TextFieldDisplayConcrete;
    private var confClose:TextFieldDisplayConcrete;
    private var confConfirm:TextFieldDisplayConcrete;

    private var buyseltxt:TextFieldDisplayConcrete;
    private var sellseltxt:TextFieldDisplayConcrete;

    public function PawnShop(_arg1:int, _arg2:int) {
        drawBackground(_arg1, _arg2);
        drawTitle();
        closebutton();
        drawItemSlot();
        drawsellbutton();
        drawBuySelect();
        drawSellSelect();
    }

    private function drawBuySelect():void {
        this.buybackg = new Sprite();
        this.buybackg.graphics.beginFill(0x464646);
        this.buybackg.graphics.drawRoundRectComplex(0, 0, 148, 50, 0, 0, 0, 6);
        this.buybackg.graphics.endFill();
        //text
        this.buyseltxt = new TextFieldDisplayConcrete().setSize(28).setColor(0xB3B3B3);
        this.buyseltxt.setBold(true);
        this.buyseltxt.setStringBuilder(new LineBuilder().setParams("BUY"));

        this.buyseltxt.x = this.sellBox.x + 200;
        this.buyseltxt.y = this.sellBox.y + 258;
        this.buybackg.x = this.sellBox.x + 150;
        this.buybackg.y = this.sellBox.y + 248;

        this.buybackg.addEventListener(MouseEvent.CLICK, onBuyBackClick);

        this.addChild(this.buybackg);
        this.addChild(this.buyseltxt);
    }

    private function onBuyBackClick(_arg1:MouseEvent):void {
        this.transformColor(this.buybackg, 0x262626);
        this.transformColor(this.sellbackg, 0x464646);
        this.HideSellStuff(true);
    }

    private function drawSellSelect():void{
        this.sellbackg = new Sprite();
        this.sellbackg.graphics.beginFill(0x262626);
        this.sellbackg.graphics.drawRoundRectComplex(0, 0, 148, 50, 0, 0, 6, 0);
        this.sellbackg.graphics.endFill();

        this.sellseltxt = new TextFieldDisplayConcrete().setSize(28).setColor(0xB3B3B3);
        this.sellseltxt.setBold(true);
        this.sellseltxt.setStringBuilder(new LineBuilder().setParams("SELL"));

        this.sellseltxt.x = this.sellBox.x + 50;
        this.sellseltxt.y = this.sellBox.y + 258;
        this.sellbackg.x = this.sellBox.x + 2;
        this.sellbackg.y = this.sellBox.y + 248;

        this.sellbackg.addEventListener(MouseEvent.CLICK, onSellBackClick);

        addChild(this.sellbackg);
        addChild(this.sellseltxt);
    }

    private function onSellBackClick(_arg1:MouseEvent):void {
        this.transformColor(this.sellbackg, 0x262626);
        this.transformColor(this.buybackg, 0x464646);
        this.HideSellStuff(false);
    }

    function transformColor(target:DisplayObject, color:uint):void {
        var colortran:ColorTransform = new ColorTransform();
        colortran.color = color;
        target.transform.colorTransform = colortran;
    }

    private function HideSellStuff(_arg1:Boolean):void {

        if (_arg1 == true)
        {
            this.itemSlot.visible = false;
            this.itemSlot1.visible = false;
            this.itemSlot2.visible = false;
            this.itemSlot3.visible = false;
            this.sell.visible = false;
        }else {
            this.itemSlot.visible = true;
            this.itemSlot1.visible = true;
            this.itemSlot2.visible = true;
            this.itemSlot3.visible = true;
            this.sell.visible = true;
        }
    }

    private function drawBackground(_arg1:int, _arg2:int):void {
        sellBox = new Sprite();
        sellBox.graphics.beginFill(0x363636);
        sellBox.graphics.lineStyle(2, 0xFFFFFF);
        sellBox.graphics.drawRoundRect(0,0, _arg1, _arg2, 15, 15);
        sellBox.graphics.moveTo(sellBox.x, sellBox.y + 35);
        sellBox.graphics.lineTo(sellBox.x + sellBox.width - 3, sellBox.y + 35)
        sellBox.graphics.endFill();
        sellBox.x = 800/2 - sellBox.width/2;
        sellBox.y = 600/2 - sellBox.height/2;

        addChild(sellBox);
    }

    private function drawTitle(): void {
        this.title = new TextFieldDisplayConcrete().setSize(20).setColor(0xB3B3B3);
        this.title.setBold(true);
        this.title.setStringBuilder(new LineBuilder().setParams("Pawn Shop"));
        this.title.x = (sellBox.x) + sellBox.width/3;
        this.title.y = (sellBox.y) + 7;
        addChild(this.title);
    }

    private function closebutton():void {
        this.close = new TextFieldDisplayConcrete().setSize(20).setColor(0xB3B3B3);
        this.close.setBold(true);
        this.close.setStringBuilder(new LineBuilder().setParams("[X]"));
        this.close.x = this.sellBox.x + this.sellBox.width - 35;
        this.close.y = (sellBox.y) + 5;
        this.close.addEventListener(MouseEvent.CLICK, onClose);
        this.close.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
        this.close.addEventListener(MouseEvent.MOUSE_OUT, defaultcolor);
        addChild(this.close);
    }

    private function onMouseOver(_arg1:MouseEvent): void {this.close.setColor(0x121212);}

    private function defaultcolor(arg1:MouseEvent):void {this.close.setColor(0xB3B3B3);}

    private function onClose(_arg1:MouseEvent):void {
        this.visible = false;
        this.sellpanel.opened = false;
    }

    private function drawItemSlot():void {
        //0
        var _local1:int = this.sellBox.x;
        this.itemSlot = new PawnItemSlot(true, true);
        this.itemSlot.x = _local1;
        this.itemSlot.y = this.sellBox.y + 50;
        _local1 = _local1 + this.itemSlot.width - 5;
        //1
        this.itemSlot1 = new PawnItemSlot(true, true);
        this.itemSlot1.x = _local1;
        this.itemSlot1.y = this.sellBox.y + 50;
        _local1 = _local1 + this.itemSlot1.width - 5;
        //2
        this.itemSlot2 = new PawnItemSlot(true, true);
        this.itemSlot2.x = _local1;
        this.itemSlot2.y = this.sellBox.y + 50;
        _local1 = _local1 + this.itemSlot2.width - 5;
        //3
        this.itemSlot3 = new PawnItemSlot(true, true);
        this.itemSlot3.x = _local1;
        this.itemSlot3.y = this.sellBox.y + 50;

        addChild(this.itemSlot);
        addChild(this.itemSlot1);
        addChild(this.itemSlot2);
        addChild(this.itemSlot3);
    }

    private function drawsellbutton(): void {
        this.sell = new TextFieldDisplayConcrete().setSize(28).setColor(0xB3B3B3);
        this.sell.setBold(true);
        this.sell.setStringBuilder(new LineBuilder().setParams("SELL"));
        this.sell.x = this.sellBox.x + 120;
        this.sell.y = this.sellBox.y + 150;

        this.sell.addEventListener(MouseEvent.CLICK, onSell);
        this.sell.addEventListener(MouseEvent.MOUSE_OVER, onSellOver);
        this.sell.addEventListener(MouseEvent.MOUSE_OUT, OnSellOut);

        addChild(this.sell);
    }

    private function onSellOver(_arg1:MouseEvent): void {this.sell.setColor(0x121212);}

    private function OnSellOut(arg1:MouseEvent):void {this.sell.setColor(0xB3B3B3);}

    private function onSell(_arg1:MouseEvent):void {
        if ((itemSlot.itemId != -1) || (itemSlot1.itemId != -1) || (itemSlot2.itemId != -1) || (itemSlot3.itemId != -1)){
            confirmBox();
        }
    }

    private function getPrice():void{
        var _local1:XML;
        var _local2:XML;
        var _local3:XML;
        var _local4:XML;

        if ((itemSlot.itemId != -1) || (itemSlot1.itemId != -1) || (itemSlot2.itemId != -1) || (itemSlot3.itemId != -1)){
            if (itemSlot.itemId != -1){
                _local1 = ObjectLibrary.getXMLfromId(ObjectLibrary.getIdFromType(itemSlot.itemId));
                var price:int = _local1.Price;
                this.amount = this.amount + price;
            }
            if (itemSlot1.itemId != -1) {
                _local2 = ObjectLibrary.getXMLfromId(ObjectLibrary.getIdFromType(itemSlot1.itemId));
                var price:int = _local2.Price;
                this.amount = this.amount + price;
            }
            if (itemSlot2.itemId != -1){
                _local3 = ObjectLibrary.getXMLfromId(ObjectLibrary.getIdFromType(itemSlot2.itemId));
                var price:int = _local3.Price;
                this.amount = this.amount + price;
            }
            if (itemSlot3.itemId != -1){
                _local4 = ObjectLibrary.getXMLfromId(ObjectLibrary.getIdFromType(itemSlot3.itemId));
                var price:int = _local4.Price;
                this.amount = this.amount + price;
            }
        }
    }

    private function confirmBox():void {
        this.getPrice();
        //Box
        this.confBox = new Sprite();
        this.confBox.graphics.beginFill(0x474747);
        this.confBox.graphics.lineStyle(2, 0xFFFFFF);
        this.confBox.graphics.drawRect(0, 0, this.sellBox.width - 20, this.sellBox.height -20);
        this.confBox.graphics.endFill();
        this.confBox.x = this.sellBox.x + 10;
        this.confBox.y = this.sellBox.y + 10;
        //CloseBtn
        this.confClose = new TextFieldDisplayConcrete().setSize(18).setBold(true).setColor(0xB3B3B3).setStringBuilder(new LineBuilder().setParams("Close"));
        this.confClose.x = this.confBox.x + 100;
        this.confClose.y = this.confBox.y + 80;
        this.confClose.addEventListener(MouseEvent.CLICK, onconfClose);
        this.confClose.addEventListener(MouseEvent.MOUSE_OVER, onCloseOver);
        this.confClose.addEventListener(MouseEvent.MOUSE_OUT, onCloseOut);
        //displayprice
        this.displayPrice = new TextFieldDisplayConcrete().setSize(20).setColor(0xB3B3B3);
        this.displayPrice.x = this.confBox.x + 100;
        this.displayPrice.y = this.confBox.y + 20;
        this.displayPrice.setStringBuilder(new LineBuilder().setParams("Price:" + this.amount));
        //confirmtxt
        this.confConfirm = new TextFieldDisplayConcrete().setSize(20).setColor(0xB3B3B3).setBold(true);
        this.confConfirm.setStringBuilder(new LineBuilder().setParams("Confirm"));
        this.confConfirm.x = this.confBox.x + 100;
        this.confConfirm.y = this.confBox.y + 40;
        this.confConfirm.addEventListener(MouseEvent.CLICK, onConfirm);
        this.confConfirm.addEventListener(MouseEvent.MOUSE_OVER, onConfirmOver);
        this.confConfirm.addEventListener(MouseEvent.MOUSE_OUT, onConfirmOut);

        this.addChild(this.confBox);
        this.addChild(confConfirm);
        this.addChild(this.displayPrice);
        this.addChild(this.confClose);
    }

    private function onconfClose(_arg1:MouseEvent):void {
        this.removeChild(this.confClose);
        this.removeChild(confConfirm);
        this.removeChild(this.displayPrice);
        this.removeChild(this.confBox);
        this.amount = 0;
    }

    private function onCloseOver(_arg1:MouseEvent):void {this.confClose.setColor(0x121212);}

    private function onCloseOut(_arg1:MouseEvent):void {this.confClose.setColor(0xB3B3B3);}

    private function onConfirmOver(_arg1:MouseEvent):void {this.confConfirm.setColor(0x121212);}

    private function onConfirmOut(_arg1:MouseEvent):void {this.confConfirm.setColor(0xB3B3B3);}

    private function onConfirm(_arg1:MouseEvent):void {
        this.signal.dispatch(Currency.GOLD);
        this.removeChild(this.confClose);
        this.removeChild(confConfirm);
        this.removeChild(this.displayPrice);
        this.removeChild(this.confBox);

        this.amount = 0;
    }
}
}
