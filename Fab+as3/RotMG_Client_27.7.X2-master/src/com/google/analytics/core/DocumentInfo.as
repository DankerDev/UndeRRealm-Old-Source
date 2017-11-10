package com.google.analytics.core
{
   import com.google.analytics.v4.Configuration;
   import com.google.analytics.external.AdSenseGlobals;
   import com.google.analytics.utils.Environment;
   import com.google.analytics.utils.Variables;
   
   public class DocumentInfo
   {
       
      
      private var _pageURL:String;
      
      private var _utmr:String;
      
      private var _config:Configuration;
      
      private var _adSense:AdSenseGlobals;
      
      private var _info:Environment;
      
      public function DocumentInfo(param1:Configuration, param2:Environment, param3:String, param4:String = null, param5:AdSenseGlobals = null)
      {
         super();
         this._config = param1;
         this._info = param2;
         this._utmr = param3;
         this._pageURL = param4;
         this._adSense = param5;
      }
      
      public function get utmr() : String
      {
         if(!this._utmr)
         {
            return "-";
         }
         return this._utmr;
      }
      
      public function toURLString() : String
      {
         var _local1:Variables = this.toVariables();
         return _local1.toString();
      }
      
      private function _renderPageURL(param1:String = "") : String
      {
         var _local2:String = this._info.locationPath;
         var _local3:String = this._info.locationSearch;
         if(!param1 || param1 == "")
         {
            param1 = _local2 + unescape(_local3);
            if(param1 == "")
            {
               param1 = "/";
            }
         }
         return param1;
      }
      
      public function get utmp() : String
      {
         return this._renderPageURL(this._pageURL);
      }
      
      public function get utmhid() : String
      {
         return String(this._generateHitId());
      }
      
      private function _generateHitId() : Number
      {
         var _local1:Number = NaN;
         if(Boolean(this._adSense.hid) && this._adSense.hid != "")
         {
            _local1 = Number(this._adSense.hid);
         }
         else
         {
            _local1 = Math.round(Math.random() * 2147483647);
            this._adSense.hid = String(_local1);
         }
         return _local1;
      }
      
      public function toVariables() : Variables
      {
         var _local1:Variables = new Variables();
         _local1.URIencode = true;
         if(Boolean(this._config.detectTitle) && this.utmdt != "")
         {
            _local1.utmdt = this.utmdt;
         }
         _local1.utmhid = this.utmhid;
         _local1.utmr = this.utmr;
         _local1.utmp = this.utmp;
         return _local1;
      }
      
      public function get utmdt() : String
      {
         return this._info.documentTitle;
      }
   }
}
