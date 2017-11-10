package kabam.rotmg.ui.view {
import flash.display.Sprite;

public class CharacterWindowBackground extends Sprite {

    public function CharacterWindowBackground() {
        var _local_1:Sprite = new Sprite();
        _local_1.graphics.beginFill(0xF7F7F7);
        _local_1.graphics.drawRect(1, 0, 130, 130);
        addChild(_local_1);
    }

}
}//package kabam.rotmg.ui.view
