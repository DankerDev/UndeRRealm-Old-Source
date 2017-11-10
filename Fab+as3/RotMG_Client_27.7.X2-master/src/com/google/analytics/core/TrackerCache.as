package com.google.analytics.core
{
   import com.google.analytics.v4.GoogleAnalyticsAPI;
   import flash.errors.IllegalOperationError;
   
   public class TrackerCache implements GoogleAnalyticsAPI
   {
      
      public static var CACHE_THROW_ERROR:Boolean;
       
      
      public var tracker:GoogleAnalyticsAPI;
      
      private var _ar:Array;
      
      public function TrackerCache(param1:GoogleAnalyticsAPI = null)
      {
         super();
         this.tracker = param1;
         this._ar = [];
      }
      
      public function size() : uint
      {
         return this._ar.length;
      }
      
      public function flush() : void
      {
         var _local1:Object = null;
         var _local2:String = null;
         var _local3:Array = null;
         var _local4:int = 0;
         var _local5:int = 0;
         if(this.tracker == null)
         {
            return;
         }
         if(this.size() > 0)
         {
            _local4 = this._ar.length;
            while(_local5 < _local4)
            {
               _local1 = this._ar.shift();
               _local2 = _local1.name as String;
               _local3 = _local1.args as Array;
               if(_local2 != null && _local2 in this.tracker)
               {
                  (this.tracker[_local2] as Function).apply(this.tracker,_local3);
               }
               _local5++;
            }
         }
      }
      
      public function enqueue(param1:String, ... rest) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         this._ar.push({
            "name":param1,
            "args":rest
         });
         return true;
      }
      
      public function link(param1:String, param2:Boolean = false) : void
      {
         this.enqueue("link",param1,param2);
      }
      
      public function addOrganic(param1:String, param2:String) : void
      {
         this.enqueue("addOrganic",param1,param2);
      }
      
      public function setAllowLinker(param1:Boolean) : void
      {
         this.enqueue("setAllowLinker",param1);
      }
      
      public function trackEvent(param1:String, param2:String, param3:String = null, param4:Number = NaN) : Boolean
      {
         this.enqueue("trackEvent",param1,param2,param3,param4);
         return true;
      }
      
      public function getLinkerUrl(param1:String = "", param2:Boolean = false) : String
      {
         if(CACHE_THROW_ERROR)
         {
            throw new IllegalOperationError("The tracker is not ready and you can use the \'getLinkerUrl\' method for the moment.");
         }
         return "";
      }
      
      public function getClientInfo() : Boolean
      {
         if(CACHE_THROW_ERROR)
         {
            throw new IllegalOperationError("The tracker is not ready and you can use the \'getClientInfo\' method for the moment.");
         }
         return false;
      }
      
      public function trackTrans() : void
      {
         this.enqueue("trackTrans");
      }
      
      public function trackPageview(param1:String = "") : void
      {
         this.enqueue("trackPageview",param1);
      }
      
      public function setClientInfo(param1:Boolean) : void
      {
         this.enqueue("setClientInfo",param1);
      }
      
      public function linkByPost(param1:Object, param2:Boolean = false) : void
      {
         this.enqueue("linkByPost",param1,param2);
      }
      
      public function setCookieTimeout(param1:int) : void
      {
         this.enqueue("setCookieTimeout",param1);
      }
      
      public function isEmpty() : Boolean
      {
         return this._ar.length == 0;
      }
      
      public function getDetectTitle() : Boolean
      {
         if(CACHE_THROW_ERROR)
         {
            throw new IllegalOperationError("The tracker is not ready and you can use the \'getDetectTitle\' method for the moment.");
         }
         return false;
      }
      
      public function resetSession() : void
      {
         this.enqueue("resetSession");
      }
      
      public function setDetectFlash(param1:Boolean) : void
      {
         this.enqueue("setDetectFlash",param1);
      }
      
      public function clear() : void
      {
         this._ar = [];
      }
      
      public function setCampNameKey(param1:String) : void
      {
         this.enqueue("setCampNameKey",param1);
      }
      
      public function addItem(param1:String, param2:String, param3:String, param4:String, param5:Number, param6:int) : void
      {
         this.enqueue("addItem",param1,param2,param3,param4,param5,param6);
      }
      
      public function createEventTracker(param1:String) : EventTracker
      {
         if(CACHE_THROW_ERROR)
         {
            throw new IllegalOperationError("The tracker is not ready and you can use the \'createEventTracker\' method for the moment.");
         }
         return null;
      }
      
      public function clearIgnoredOrganic() : void
      {
         this.enqueue("clearIgnoredOrganic");
      }
      
      public function setVar(param1:String) : void
      {
         this.enqueue("setVar",param1);
      }
      
      public function setDomainName(param1:String) : void
      {
         this.enqueue("setDomainName",param1);
      }
      
      public function setCampSourceKey(param1:String) : void
      {
         this.enqueue("setCampSourceKey",param1);
      }
      
      public function addTrans(param1:String, param2:String, param3:Number, param4:Number, param5:Number, param6:String, param7:String, param8:String) : void
      {
         if(CACHE_THROW_ERROR)
         {
            throw new IllegalOperationError("The tracker is not ready and you can use the \'addTrans\' method for the moment.");
         }
      }
      
      public function setCampContentKey(param1:String) : void
      {
         this.enqueue("setCampContentKey",param1);
      }
      
      public function setLocalServerMode() : void
      {
         this.enqueue("setLocalServerMode");
      }
      
      public function getLocalGifPath() : String
      {
         if(CACHE_THROW_ERROR)
         {
            throw new IllegalOperationError("The tracker is not ready and you can use the \'getLocalGifPath\' method for the moment.");
         }
         return "";
      }
      
      public function setAllowAnchor(param1:Boolean) : void
      {
         this.enqueue("setAllowAnchor",param1);
      }
      
      public function clearIgnoredRef() : void
      {
         this.enqueue("clearIgnoredRef");
      }
      
      public function setLocalGifPath(param1:String) : void
      {
         this.enqueue("setLocalGifPath",param1);
      }
      
      public function getVersion() : String
      {
         if(CACHE_THROW_ERROR)
         {
            throw new IllegalOperationError("The tracker is not ready and you can use the \'getVersion\' method for the moment.");
         }
         return "";
      }
      
      public function setCookiePath(param1:String) : void
      {
         this.enqueue("setCookiePath",param1);
      }
      
      public function setSampleRate(param1:Number) : void
      {
         this.enqueue("setSampleRate",param1);
      }
      
      public function setDetectTitle(param1:Boolean) : void
      {
         this.enqueue("setDetectTitle",param1);
      }
      
      public function setAllowHash(param1:Boolean) : void
      {
         this.enqueue("setAllowHash",param1);
      }
      
      public function addIgnoredOrganic(param1:String) : void
      {
         this.enqueue("addIgnoredOrganic",param1);
      }
      
      public function setCampNOKey(param1:String) : void
      {
         this.enqueue("setCampNOKey",param1);
      }
      
      public function getServiceMode() : ServerOperationMode
      {
         if(CACHE_THROW_ERROR)
         {
            throw new IllegalOperationError("The tracker is not ready and you can use the \'getServiceMode\' method for the moment.");
         }
         return null;
      }
      
      public function setLocalRemoteServerMode() : void
      {
         this.enqueue("setLocalRemoteServerMode");
      }
      
      public function cookiePathCopy(param1:String) : void
      {
         this.enqueue("cookiePathCopy",param1);
      }
      
      public function getDetectFlash() : Boolean
      {
         if(CACHE_THROW_ERROR)
         {
            throw new IllegalOperationError("The tracker is not ready and you can use the \'getDetectFlash\' method for the moment.");
         }
         return false;
      }
      
      public function setCampaignTrack(param1:Boolean) : void
      {
         this.enqueue("setCampaignTrack",param1);
      }
      
      public function clearOrganic() : void
      {
         this.enqueue("clearOrganic");
      }
      
      public function setCampTermKey(param1:String) : void
      {
         this.enqueue("setCampTermKey",param1);
      }
      
      public function addIgnoredRef(param1:String) : void
      {
         this.enqueue("addIgnoredRef",param1);
      }
      
      public function setCampMediumKey(param1:String) : void
      {
         this.enqueue("setCampMediumKey",param1);
      }
      
      public function setSessionTimeout(param1:int) : void
      {
         this.enqueue("setSessionTimeout",param1);
      }
      
      public function setRemoteServerMode() : void
      {
         this.enqueue("setRemoteServerMode");
      }
      
      public function element() : *
      {
         return this._ar[0];
      }
      
      public function getAccount() : String
      {
         if(CACHE_THROW_ERROR)
         {
            throw new IllegalOperationError("The tracker is not ready and you can use the \'getAccount\' method for the moment.");
         }
         return "";
      }
   }
}
