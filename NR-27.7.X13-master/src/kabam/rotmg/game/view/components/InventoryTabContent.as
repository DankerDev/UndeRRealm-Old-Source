package kabam.rotmg.game.view.components {
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;

import flash.display.Sprite;

import kabam.rotmg.ui.model.TabStripModel;

public class InventoryTabContent extends Sprite {

    public var storageContent:Sprite;
    public var storage:InventoryGrid;

    public function InventoryTabContent(_arg1:Player) {
        this.storageContent = new Sprite();
        super();
        this.init(_arg1);
        this.addChildren();
        this.positionChildren();
    }

    private function init(_arg1:Player):void {
        this.storage = new InventoryGrid(_arg1, _arg1, 4);
        this.storageContent.name = TabStripModel.MAIN_INVENTORY;
    }

    private function addChildren():void {
        this.storageContent.addChild(this.storage);
        addChild(this.storageContent);
    }

    private function positionChildren():void {
        this.storageContent.x = 7;
        this.storageContent.y = 7;
    }


}
}