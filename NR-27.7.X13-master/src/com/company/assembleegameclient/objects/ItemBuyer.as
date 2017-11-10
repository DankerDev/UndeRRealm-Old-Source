
package com.company.assembleegameclient.objects {

import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.ui.panels.SellItemPanel;
import com.company.assembleegameclient.ui.panels.Panel;

public class ItemBuyer extends GameObject implements IInteractiveObject{

    public function ItemBuyer(_arg1:XML) {
        super(_arg1);
        isInteractive_ = true;
    }

    public function getPanel(_arg1:GameSprite):Panel {
        return (new SellItemPanel(_arg1));
    }
}
}
