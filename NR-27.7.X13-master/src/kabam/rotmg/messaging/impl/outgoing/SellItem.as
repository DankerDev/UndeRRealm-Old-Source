package kabam.rotmg.messaging.impl.outgoing {
import flash.utils.IDataOutput;

import kabam.rotmg.messaging.impl.data.SlotObjectData;

public class SellItem extends OutgoingMessage {

    public var objSlot:SlotObjectData;
    public var objSlot1:SlotObjectData;
    public var objSlot2:SlotObjectData;
    public var objSlot3:SlotObjectData;

    public function SellItem(_arg1:uint, _arg2:Function) {
        this.objSlot = new SlotObjectData();
        this.objSlot1 = new SlotObjectData();
        this.objSlot2 = new SlotObjectData();
        this.objSlot3 = new SlotObjectData();
        super(_arg1, _arg2);
    }

    override public function writeToOutput(_arg1:IDataOutput):void {
        this.objSlot.writeToOutput(_arg1);
        this.objSlot1.writeToOutput(_arg1);
        this.objSlot2.writeToOutput(_arg1);
        this.objSlot3.writeToOutput(_arg1);
    }

    override public function toString():String {
        return (formatToString("SELLITEM"));
    }
}
}
