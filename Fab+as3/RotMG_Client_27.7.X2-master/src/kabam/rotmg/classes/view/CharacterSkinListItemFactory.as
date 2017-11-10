package kabam.rotmg.classes.view
{
import kabam.rotmg.assets.services.CharacterFactory;
import flash.display.DisplayObject;
import kabam.rotmg.classes.model.CharacterSkins;
import kabam.rotmg.classes.model.CharacterSkin;
import com.company.util.AssetLibrary;
import kabam.rotmg.util.components.LegacyBuyButton;
import com.company.assembleegameclient.util.Currency;
import flash.display.Bitmap;
import flash.display.BitmapData;

public class CharacterSkinListItemFactory
{


    [Inject]
    public var characters:CharacterFactory;

    public function CharacterSkinListItemFactory()
    {
        super();
    }

    public function make(param1:CharacterSkins) : Vector.<DisplayObject>
    {
        var _local2:Vector.<CharacterSkin> = null;
        var _local3:int = 0;
        _local2 = param1.getListedSkins();
        _local3 = _local2.length;
        var _local4:Vector.<DisplayObject> = new Vector.<DisplayObject>(_local3,true);
        var _local5:int = 0;
        while(_local5 < _local3)
        {
            _local4[_local5] = this.makeCharacterSkinTile(_local2[_local5]);
            _local5++;
        }
        return _local4;
    }

    private function makeCharacterSkinTile(param1:CharacterSkin) : CharacterSkinListItem
    {
        var _local2:CharacterSkinListItem = new CharacterSkinListItem();
        _local2.setSkin(this.makeIcon(param1));
        _local2.setModel(param1);
        _local2.setLockIcon(AssetLibrary.getImageFromSet("lofiInterface2",5));
        _local2.setBuyButton(this.makeBuyButton());
        return _local2;
    }

    private function makeBuyButton() : LegacyBuyButton
    {
        return new LegacyBuyButton("",16,0,Currency.GOLD);
    }

    private function makeIcon(param1:CharacterSkin) : Bitmap
    {
        var _local2:BitmapData = this.characters.makeIcon(param1.template);
        return new Bitmap(_local2);
    }
}
}
