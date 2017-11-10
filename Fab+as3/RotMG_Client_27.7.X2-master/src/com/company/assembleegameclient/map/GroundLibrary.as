package com.company.assembleegameclient.map
{
   import flash.utils.Dictionary;
   import com.company.assembleegameclient.objects.TextureDataConcrete;
   import flash.display.BitmapData;
   import com.company.util.BitmapUtil;
   
   public class GroundLibrary
   {
      
      public static const propsLibrary_:Dictionary = new Dictionary();
      
      public static const xmlLibrary_:Dictionary = new Dictionary();
      
      private static var tileTypeColorDict_:Dictionary = new Dictionary();
      
      public static const typeToTextureData_:Dictionary = new Dictionary();
      
      public static var idToType_:Dictionary = new Dictionary();
      
      public static var defaultProps_:com.company.assembleegameclient.map.GroundProperties;
       
      
      public function GroundLibrary()
      {
         super();
      }
      
      public static function parseFromXML(param1:XML) : void
      {
         var _local2:XML = null;
         var _local3:int = 0;
         for each(_local2 in param1.Ground)
         {
            _local3 = int(_local2.@type);
            propsLibrary_[_local3] = new com.company.assembleegameclient.map.GroundProperties(_local2);
            xmlLibrary_[_local3] = _local2;
            typeToTextureData_[_local3] = new TextureDataConcrete(_local2);
            idToType_[String(_local2.@id)] = _local3;
         }
         defaultProps_ = propsLibrary_[255];
      }
      
      public static function getIdFromType(param1:int) : String
      {
         var _local2:com.company.assembleegameclient.map.GroundProperties = propsLibrary_[param1];
         if(_local2 == null)
         {
            return null;
         }
         return _local2.id_;
      }
      
      public static function getBitmapData(param1:int, param2:int = 0) : BitmapData
      {
         return typeToTextureData_[param1].getTexture(param2);
      }
      
      public static function getColor(param1:int) : uint
      {
         var _local2:XML = null;
         var _local3:uint = 0;
         var _local4:BitmapData = null;
         if(!tileTypeColorDict_.hasOwnProperty(param1))
         {
            _local2 = xmlLibrary_[param1];
            if(_local2.hasOwnProperty("Color"))
            {
               _local3 = uint(_local2.Color);
            }
            else
            {
               _local4 = getBitmapData(param1);
               _local3 = BitmapUtil.mostCommonColor(_local4);
            }
            tileTypeColorDict_[param1] = _local3;
         }
         return tileTypeColorDict_[param1];
      }
   }
}
