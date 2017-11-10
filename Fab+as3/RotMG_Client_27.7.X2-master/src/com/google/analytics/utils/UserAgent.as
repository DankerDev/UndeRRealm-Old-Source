package com.google.analytics.utils
{
   import flash.system.System;
   import com.google.analytics.core.Utils;
   import flash.system.Capabilities;
   
   public class UserAgent
   {
      
      public static var minimal:Boolean = false;
       
      
      private var _localInfo:com.google.analytics.utils.Environment;
      
      private var _applicationProduct:String;
      
      private var _version:com.google.analytics.utils.Version;
      
      public function UserAgent(param1:com.google.analytics.utils.Environment, param2:String = "", param3:String = "")
      {
         super();
         this._localInfo = param1;
         this.applicationProduct = param2;
         this._version = Version.fromString(param3);
      }
      
      public function get tamarinProductToken() : String
      {
         if(UserAgent.minimal)
         {
            return "";
         }
         if(System.vmVersion)
         {
            return "Tamarin/" + Utils.trim(System.vmVersion,true);
         }
         return "";
      }
      
      public function get applicationVersion() : String
      {
         return this._version.toString(2);
      }
      
      public function get vendorProductToken() : String
      {
         var _local1:* = "";
         if(this._localInfo.isAIR())
         {
            _local1 = _local1 + "AIR";
         }
         else
         {
            _local1 = _local1 + "FlashPlayer";
         }
         _local1 = _local1 + "/";
         _local1 = _local1 + this._version.toString(3);
         return _local1;
      }
      
      public function toString() : String
      {
         var _local1:String = "";
         _local1 = _local1 + this.applicationProductToken;
         if(this.applicationComment != "")
         {
            _local1 = _local1 + (" " + this.applicationComment);
         }
         if(this.tamarinProductToken != "")
         {
            _local1 = _local1 + (" " + this.tamarinProductToken);
         }
         if(this.vendorProductToken != "")
         {
            _local1 = _local1 + (" " + this.vendorProductToken);
         }
         return _local1;
      }
      
      public function get applicationComment() : String
      {
         var _local1:Array = [];
         _local1.push(this._localInfo.platform);
         _local1.push(this._localInfo.playerType);
         if(!UserAgent.minimal)
         {
            _local1.push(this._localInfo.operatingSystem);
            _local1.push(this._localInfo.language);
         }
         if(Capabilities.isDebugger)
         {
            _local1.push("DEBUG");
         }
         if(_local1.length > 0)
         {
            return "(" + _local1.join("; ") + ")";
         }
         return "";
      }
      
      public function set applicationVersion(param1:String) : void
      {
         this._version = Version.fromString(param1);
      }
      
      public function get applicationProductToken() : String
      {
         var _local1:String = this.applicationProduct;
         if(this.applicationVersion != "")
         {
            _local1 = _local1 + ("/" + this.applicationVersion);
         }
         return _local1;
      }
      
      public function set applicationProduct(param1:String) : void
      {
         this._applicationProduct = param1;
      }
      
      public function get applicationProduct() : String
      {
         return this._applicationProduct;
      }
   }
}
