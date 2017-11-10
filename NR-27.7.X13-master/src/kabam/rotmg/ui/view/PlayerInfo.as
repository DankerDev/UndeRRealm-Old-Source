package kabam.rotmg.ui.view {

import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.util.Currency;

import flash.display.Bitmap;
import flash.display.BitmapData;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.ui.Mouse;
import flash.utils.Timer;
import flash.geom.Matrix;
import flash.geom.Point;

import kabam.rotmg.messaging.impl.GameServerConnectionConcrete;

import kabam.rotmg.ui.model.HUDModel;

import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;

import org.osflash.signals.Signal;


public class PlayerInfo extends Sprite{

    public var backGround:Sprite;
    public var backbtn:Bitmap;
    public var _backsprite:Sprite;
    public var forwardBtn:Bitmap;
    public var _forwardBtn:Sprite;
    public var fadeTimer:Timer;
    public var inTimer:Timer;

    private var characterDetails:CharacterDetailsView;

    public function PlayerInfo() {
        DrawBackground();
        DrawCharDetail();
        addAssets();
        PositionAssets();
        DrawBackBtn();
        DrawForwardBtn();
        this.forwardBtn.visible = false;
        this._forwardBtn.visible = false;
    }

    private function PositionAssets():void {
        this.backGround.x = this.x;
        this.backGround.y = this.y;
        this.characterDetails.x = this.x + 2;
        this.characterDetails.y = this.y + 2;
    }

    private function addAssets():void {
        addChild(this.backGround);
        addChild(this.characterDetails);
    }

    private function DrawBackground():void {
        backGround = new Sprite();
        backGround.graphics.beginFill(0xA07126);
        backGround.graphics.lineStyle(1, 0xFFFFFF);
        backGround.graphics.drawRoundRectComplex(0, 0, 150, 70, 0, 15, 0, 15);
        backGround.graphics.endFill();
    }

    private function DrawBackBtn():void {
        this.backbtn = new Bitmap(new BackBtn());
        this.backbtn.scaleX = 0.07;
        this.backbtn.scaleY = 0.07;

        this._backsprite = new Sprite();
        _backsprite.x = this.backGround.x + 128;
        _backsprite.y = this.backGround.y + 25;
        _backsprite.addEventListener(MouseEvent.CLICK, onBack);

        _backsprite.addChild(this.backbtn);
        addChild(_backsprite);
    }

    private function DrawCharDetail(){
        this.characterDetails = new CharacterDetailsView();
    }

    private function onBack(_arg1:MouseEvent):void{
        this.fadeTimer = new Timer(20, 42);
        this.fadeTimer.addEventListener(TimerEvent.TIMER, onTimed);
        this.fadeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onDone);
        this.fadeTimer.start();
    }

    private function onTimed(_arg1:TimerEvent):void {
        this.x -= Math.round(3);

    }

    private function onDone(_arg1:TimerEvent):void {
        this.fadeTimer.stop();
        this.backbtn.visible = false;
        this._backsprite.visible = false;
        this.forwardBtn.visible = true;
        this._forwardBtn.visible = true;
    }

    private function DrawForwardBtn():void {
        this.forwardBtn = new Bitmap(new ForwardBtn());
        this.forwardBtn.scaleX = 0.07;
        this.forwardBtn.scaleY = 0.07;

        this._forwardBtn = new Sprite;
        this._forwardBtn.x = this._backsprite.x;
        this._forwardBtn.y = this._backsprite.y;
        this._forwardBtn.addEventListener(MouseEvent.CLICK, onForward);

        this._forwardBtn.addChild(this.forwardBtn);
        addChild(this._forwardBtn);
    }

    private function onForward(_arg1:MouseEvent):void {
        this.inTimer = new Timer(20, 42);
        this.inTimer.addEventListener(TimerEvent.TIMER, onForwardTimed);
        this.inTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onForwardDone);
        this.inTimer.start();
    }

    private function onForwardTimed(_arg1:TimerEvent):void {
        this.x += Math.round(3);
    }

    private function onForwardDone(_arg1:TimerEvent):void {
        this.inTimer.stop();
        this._forwardBtn.visible = false;
        this.forwardBtn.visible = false;
        this.backbtn.visible = true;
        this._backsprite.visible = true;
    }
}
}
