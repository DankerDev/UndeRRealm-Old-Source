package com.google.analytics.data
{
   public class X10
   {
       
      
      private var _delimEnd:String = ")";
      
      private var _minimum:int;
      
      private var _delimSet:String = "*";
      
      private var _escapeChar:String = "\'";
      
      private var _delimBegin:String = "(";
      
      private var _delimNumValue:String = "!";
      
      private var _key:String = "k";
      
      private var _set:Array;
      
      private var _hasData:int;
      
      private var _escapeCharMap:Object;
      
      private var _projectData:Object;
      
      private var _value:String = "v";
      
      public function X10()
      {
         this._set = [this._key,this._value];
         super();
         this._projectData = {};
         this._escapeCharMap = {};
         this._escapeCharMap[this._escapeChar] = "\'0";
         this._escapeCharMap[this._delimEnd] = "\'1";
         this._escapeCharMap[this._delimSet] = "\'2";
         this._escapeCharMap[this._delimNumValue] = "\'3";
         this._minimum = 1;
      }
      
      private function _setInternal(param1:Number, param2:String, param3:Number, param4:String) : void
      {
         if(!this.hasProject(param1))
         {
            this._projectData[param1] = {};
         }
         if(this._projectData[param1][param2] == undefined)
         {
            this._projectData[param1][param2] = [];
         }
         this._projectData[param1][param2][param3] = param4;
         this._hasData = this._hasData + 1;
      }
      
      private function _renderProject(param1:Object) : String
      {
         var _local4:int = 0;
         var _local5:Array = null;
         var _local2:String = "";
         var _local3:Boolean = false;
         var _local6:int = this._set.length;
         _local4 = 0;
         while(_local4 < _local6)
         {
            _local5 = param1[this._set[_local4]];
            if(_local5)
            {
               if(_local3)
               {
                  _local2 = _local2 + this._set[_local4];
               }
               _local2 = _local2 + this._renderDataType(_local5);
               _local3 = false;
            }
            else
            {
               _local3 = true;
            }
            _local4++;
         }
         return _local2;
      }
      
      public function hasProject(param1:Number) : Boolean
      {
         return this._projectData[param1];
      }
      
      public function clearKey(param1:Number) : void
      {
         this._clearInternal(param1,this._key);
      }
      
      private function _renderDataType(param1:Array) : String
      {
         var _local3:String = null;
         var _local4:int = 0;
         var _local2:Array = [];
         _local4 = 0;
         while(_local4 < param1.length)
         {
            if(param1[_local4] != undefined)
            {
               _local3 = "";
               if(_local4 != this._minimum && param1[_local4 - 1] == undefined)
               {
                  _local3 = _local3 + _local4.toString();
                  _local3 = _local3 + this._delimNumValue;
               }
               _local3 = _local3 + this._escapeExtensibleValue(param1[_local4]);
               _local2.push(_local3);
            }
            _local4++;
         }
         return this._delimBegin + _local2.join(this._delimSet) + this._delimEnd;
      }
      
      public function getKey(param1:Number, param2:Number) : String
      {
         return this._getInternal(param1,this._key,param2) as String;
      }
      
      public function hasData() : Boolean
      {
         return this._hasData > 0;
      }
      
      public function renderMergedUrlString(param1:X10 = null) : String
      {
         var _local3:* = null;
         if(!param1)
         {
            return this.renderUrlString();
         }
         var _local2:Array = [param1.renderUrlString()];
         for(_local3 in this._projectData)
         {
            if(Boolean(this.hasProject(Number(_local3))) && !param1.hasProject(Number(_local3)))
            {
               _local2.push(_local3 + this._renderProject(this._projectData[_local3]));
            }
         }
         return _local2.join("");
      }
      
      public function setValue(param1:Number, param2:Number, param3:Number) : Boolean
      {
         if(Math.round(param3) != param3 || Boolean(isNaN(param3)) || param3 == Infinity)
         {
            return false;
         }
         this._setInternal(param1,this._value,param2,param3.toString());
         return true;
      }
      
      public function renderUrlString() : String
      {
         var _local2:* = null;
         var _local1:Array = [];
         for(_local2 in this._projectData)
         {
            if(this.hasProject(Number(_local2)))
            {
               _local1.push(_local2 + this._renderProject(this._projectData[_local2]));
            }
         }
         return _local1.join("");
      }
      
      private function _getInternal(param1:Number, param2:String, param3:Number) : Object
      {
         if(Boolean(this.hasProject(param1)) && this._projectData[param1][param2] != undefined)
         {
            return this._projectData[param1][param2][param3];
         }
         return undefined;
      }
      
      public function setKey(param1:Number, param2:Number, param3:String) : Boolean
      {
         this._setInternal(param1,this._key,param2,param3);
         return true;
      }
      
      public function clearValue(param1:Number) : void
      {
         this._clearInternal(param1,this._value);
      }
      
      private function _clearInternal(param1:Number, param2:String) : void
      {
         var _local3:Boolean = false;
         var _local4:int = 0;
         var _local5:int = 0;
         if(Boolean(this.hasProject(param1)) && this._projectData[param1][param2] != undefined)
         {
            this._projectData[param1][param2] = undefined;
            _local3 = true;
            _local5 = this._set.length;
            _local4 = 0;
            while(_local4 < _local5)
            {
               if(this._projectData[param1][this._set[_local4]] != undefined)
               {
                  _local3 = false;
                  break;
               }
               _local4++;
            }
            if(_local3)
            {
               this._projectData[param1] = undefined;
               this._hasData = this._hasData - 1;
            }
         }
      }
      
      public function getValue(param1:Number, param2:Number) : *
      {
         var _local3:* = this._getInternal(param1,this._value,param2);
         if(_local3 == null)
         {
            return null;
         }
         return Number(_local3);
      }
      
      private function _escapeExtensibleValue(param1:String) : String
      {
         var _local3:int = 0;
         var _local4:String = null;
         var _local5:String = null;
         var _local2:String = "";
         _local3 = 0;
         while(_local3 < param1.length)
         {
            _local4 = param1.charAt(_local3);
            _local5 = this._escapeCharMap[_local4];
            if(_local5)
            {
               _local2 = _local2 + _local5;
            }
            else
            {
               _local2 = _local2 + _local4;
            }
            _local3++;
         }
         return _local2;
      }
   }
}
