
package com.company.assembleegameclient.ui.panels {

import com.company.assembleegameclient.game.AGameSprite;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.objects.WackaMole;
import com.company.assembleegameclient.util.Currency;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;

import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.StaticTextDisplay;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.util.components.LegacyBuyButton;

import org.osflash.signals.Signal;


public class WackamolePanel extends Panel {

    public const purchase:Signal = new Signal(int);

    private var owner_:WackaMole;
    private var openContainer:Sprite;
    private var nameText_:StaticTextDisplay;
    private var goldButton:LegacyBuyButton;
    private var closeContainer:Sprite;
    private var closeNameText:TextFieldDisplayConcrete;
    private var closedText:StaticTextDisplay;

    public function WackamolePanel(_arg_1:AGameSprite, _arg_2:WackaMole) {
        this.openContainer = new Sprite();
        this.closeContainer = new Sprite();
        super(_arg_1);
        this.owner_ = _arg_2;
        addChild(this.openContainer);
        addChild(this.closeContainer);
        if ((((gs_.map == null)) || ((gs_.map.player_ == null)))) {
            return;
        }
        var _local_3:Player = gs_.map.player_;
        this.nameText_ = this.makeTitle();
        this.openContainer.addChild(this.nameText_);
        this.goldButton = new LegacyBuyButton("", 20, 51, Currency.GOLD);
        this.goldButton.addEventListener(MouseEvent.CLICK, this.onCoinClick);
        this.openContainer.addChild(this.goldButton);
        this.closedText = new StaticTextDisplay();
        this.closedText.setSize(18).setColor(0xFF0000).setTextWidth(WIDTH).setWordWrap(true).setMultiLine(true).setAutoSize(TextFieldAutoSize.CENTER).setBold(true).setHTML(true);
        this.closedText.setStringBuilder(new LineBuilder().setParams(TextKey.PORTAL_PANEL_FULL).setPrefix('<p align="center">').setPostfix("</p>"));
        this.closedText.filters = [new DropShadowFilter(0, 0, 0)];
        this.closedText.y = (HEIGHT - 45);
        this.closeContainer.addChild(this.closedText);
        this.closeNameText = this.makeTitle();
        this.closeContainer.addChild(this.closeNameText);
    }

    private function alignUI():void {
        this.goldButton.x = ((WIDTH * 0.25) - (this.goldButton.width / 2));
        this.goldButton.y = ((HEIGHT - this.goldButton.height) - 4);
    }

    private function onCoinClick(_arg_1:MouseEvent):void {
        this.purchase.dispatch(Currency.GOLD);
    }


    override public function draw():void {
        this.openContainer.visible = this.owner_.active_;
        this.closeContainer.visible = !(this.owner_.active_);
    }

    private function makeTitle():StaticTextDisplay {
        var _local_1:StaticTextDisplay;
        _local_1 = new StaticTextDisplay();
        _local_1.setSize(18).setColor(0xFFFFFF).setTextWidth(WIDTH).setWordWrap(true).setMultiLine(true).setAutoSize(TextFieldAutoSize.CENTER).setBold(true).setHTML(true);
        _local_1.setStringBuilder(new LineBuilder().setParams(TextKey.WACKAMOLE_PORTAL_TITLE).setPrefix('<p align="center">').setPostfix("</p>"));
        _local_1.filters = [new DropShadowFilter(0, 0, 0)];
        _local_1.y = 6;
        return (_local_1);
    }






}
}
