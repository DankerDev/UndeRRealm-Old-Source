package kabam.rotmg.game.view.components {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

import kabam.rotmg.game.view.components.TabConstants;

public class TabBackground extends Sprite {

    public function TabBackground(_arg1:Number = 28, _arg2:Number = 35) {
        graphics.beginFill(TabConstants.TAB_COLOR);
        graphics.drawRoundRect(0, 0, _arg1, _arg2, TabConstants.TAB_CORNER_RADIUS, TabConstants.TAB_CORNER_RADIUS);
        graphics.endFill();
    }

}
}
