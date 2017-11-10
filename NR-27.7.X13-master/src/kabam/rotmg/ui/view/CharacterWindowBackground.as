package kabam.rotmg.ui.view {
import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.display.Sprite;

public class CharacterWindowBackground extends Sprite {

    public function CharacterWindowBackground() {

        var whiteTransparent:BitmapData = new BitmapData(130, 110, true, 0x363636);
        var canvas:Bitmap = new Bitmap(whiteTransparent);

        addChild(canvas);
    }

}
}
