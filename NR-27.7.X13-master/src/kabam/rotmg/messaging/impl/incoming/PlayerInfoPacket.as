/**
 * Created by MZT on 10/22/2017.
 */
package kabam.rotmg.messaging.impl.incoming {
import flash.utils.IDataInput;

public class PlayerInfoPacket extends IncomingMessage{
    public var accId_:int;
    public var rank_:int;

    public function PlayerInfoPacket(_arg1:uint, _arg2:Function) {
        super(_arg1, _arg2);
    }

    override public function parseFromInput(_arg1:IDataInput):void {
        this.accId_ = _arg1.readInt();
        this.rank_ = _arg1.readInt();
    }

    override public function toString():String {
        return (formatToString("PLAYERINFO", "accId_", "rank_"));
    }
}
}
