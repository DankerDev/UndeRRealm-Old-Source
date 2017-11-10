package com.company.assembleegameclient.screens {
import flash.display.Sprite;

public class IntroTextBackground extends Sprite{

    public function IntroTextBackground() {
        var local_1 = new Sprite();
        local_1.graphics.beginFill(0x363636);
        local_1.graphics.lineStyle(2, 0xFFFFFF);
        local_1.graphics.drawRect(0 , 0, 500, 400);
        addChild(local_1);
    }
}
}
