package kabam.rotmg.ui.view.components {
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.rotmg.graphics.ScreenGraphic;

import flash.display.Sprite;

public class MenuOptionsBar extends Sprite {

    private static const Y_POSITION:Number = 300;
    public static const CENTERBOTTON:String = "CENTER";
    public static const RIGHTER:String = "RIGHTER";
    public static const RIGHT:String = "RIGHT";
    public static const LEFT:String = "LEFT";
    public static const TOP:String = "TOP";
    public static const BOTTOM:String = "BOTTOM";
    public static const PLAYBOTTON:String = "PLAYBOTTON";
    public static const BACKBOTTON:String = "BACKBOTTON";
    public static const CLASSBOTTON:String = "CLASSBOTTON";

    private var screenGraphic:ScreenGraphic;

    public function MenuOptionsBar() {
        this.makeScreenGraphic();
    }

    private function makeScreenGraphic():void {
        this.screenGraphic = new ScreenGraphic();
        addChild(this.screenGraphic);
    }

    public function addButton(_arg_1:TitleMenuOption, _arg_2:String):void {
        this.screenGraphic.addChild(_arg_1);
        switch (_arg_2) {
            case CENTERBOTTON:
                _arg_1.x = 400;
                _arg_1.y = Y_POSITION;
                return;
            case LEFT:
                _arg_1.x = 400;
                _arg_1.y = 270;
                return;
            case TOP:
                _arg_1.x = 400;
                _arg_1.y = 250;
                return;
            case RIGHT:
                _arg_1.x = 400;
                _arg_1.y = 330;
                return;
            case BOTTOM:
                _arg_1.x = 400;
                _arg_1.y = 360;
                return;
            case RIGHTER:
                _arg_1.x = 500;
                _arg_1.y = 330;
                return;
            case PLAYBOTTON:
                _arg_1.x = (this.screenGraphic.width / 2);
                _arg_1.y = 550;
                return;
            case BACKBOTTON:
                _arg_1.x = 500;
                _arg_1.y = 550;
                return;
            case CLASSBOTTON:
                _arg_1.x = 270;
                _arg_1.y = 550;
                return;
        }
    }









}
}//package kabam.rotmg.ui.view.components
