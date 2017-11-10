package com.google.analytics.utils
{
   public class URL
   {
       
      
      private var _url:String;
      
      public function URL(param1:String = "")
      {
         super();
         this._url = param1.toLowerCase();
      }
      
      public function get domain() : String
      {
         var _local1:Array = null;
         if(this.hostName != "" && this.hostName.indexOf(".") > -1)
         {
            _local1 = this.hostName.split(".");
            switch(_local1.length)
            {
               case 2:
                  return this.hostName;
               case 3:
                  if(_local1[1] == "co")
                  {
                     return this.hostName;
                  }
                  _local1.shift();
                  return _local1.join(".");
               case 4:
                  _local1.shift();
                  return _local1.join(".");
            }
         }
         return "";
      }
      
      public function get path() : String
      {
         var _local1:String = this._url;
         if(_local1.indexOf("://") > -1)
         {
            _local1 = _local1.split("://")[1];
         }
         if(_local1.indexOf(this.hostName) == 0)
         {
            _local1 = _local1.substr(this.hostName.length);
         }
         if(_local1.indexOf("?") > -1)
         {
            _local1 = _local1.split("?")[0];
         }
         if(_local1.charAt(0) != "/")
         {
            _local1 = "/" + _local1;
         }
         return _local1;
      }
      
      public function get protocol() : Protocols
      {
         var _local1:String = this._url.split("://")[0];
         switch(_local1)
         {
            case "file":
               return Protocols.file;
            case "http":
               return Protocols.HTTP;
            case "https":
               return Protocols.HTTPS;
            default:
               return Protocols.none;
         }
      }
      
      public function get hostName() : String
      {
         var _local1:String = this._url;
         if(_local1.indexOf("://") > -1)
         {
            _local1 = _local1.split("://")[1];
         }
         if(_local1.indexOf("/") > -1)
         {
            _local1 = _local1.split("/")[0];
         }
         if(_local1.indexOf("?") > -1)
         {
            _local1 = _local1.split("?")[0];
         }
         if(this.protocol == Protocols.file || this.protocol == Protocols.none)
         {
            return "";
         }
         return _local1;
      }
      
      public function get subDomain() : String
      {
         if(this.domain != "" && this.domain != this.hostName)
         {
            return this.hostName.split("." + this.domain).join("");
         }
         return "";
      }
      
      public function get search() : String
      {
         var _local1:String = this._url;
         if(_local1.indexOf("://") > -1)
         {
            _local1 = _local1.split("://")[1];
         }
         if(_local1.indexOf(this.hostName) == 0)
         {
            _local1 = _local1.substr(this.hostName.length);
         }
         if(_local1.indexOf("?") > -1)
         {
            _local1 = _local1.split("?")[1];
         }
         else
         {
            _local1 = "";
         }
         return _local1;
      }
   }
}
