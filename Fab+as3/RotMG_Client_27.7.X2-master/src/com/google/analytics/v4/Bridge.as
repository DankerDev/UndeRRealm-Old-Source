package com.google.analytics.v4
{
   import com.google.analytics.debug.DebugConfiguration;
   import com.google.analytics.external.JavascriptProxy;
   import com.google.analytics.core.EventTracker;
   import com.google.analytics.core.Utils;
   import com.google.analytics.core.ServerOperationMode;
   import com.google.analytics.debug.VisualDebugMode;
   
   public class Bridge implements GoogleAnalyticsAPI
   {
      
      private static var _linkTrackingObject_js:XML = <script>
            <![CDATA[
                function( container , target )
                {
                    var targets ;
                    var name ;
                    if( target.indexOf(".") > 0 )
                    {
                        targets = target.split(".");
                        name    = targets.pop();
                    }
                    else
                    {
                        targets = [];
                        name    = target;
                    }
                    var ref   = window;
                    var depth = targets.length;
                    for( var j = 0 ; j < depth ; j++ )
                    {
                        ref = ref[ targets[j] ] ;
                    }
                    window[container][target] = ref[name] ;
                }
            ]]>
        </script>;
      
      private static var _createTrackingObject_js:XML = <script>
            <![CDATA[
                function( acct )
                {
                    _GATracker[acct] = _gat._getTracker(acct);
                }
            ]]>
        </script>;
      
      private static var _injectTrackingObject_js:XML = <script>
            <![CDATA[
                function()
                {
                    try
                    {
                        _GATracker
                    }
                    catch(e)
                    {
                        _GATracker = {};
                    }
                }
            ]]>
        </script>;
      
      private static var _checkGAJS_js:XML = <script>
            <![CDATA[
                function()
                {
                    if( _gat && _gat._getTracker )
                    {
                        return true;
                    }
                    return false;
                }
            ]]>
        </script>;
      
      private static var _checkValidTrackingObject_js:XML = <script>
            <![CDATA[
                function(acct)
                {
                    if( _GATracker[acct] && (_GATracker[acct]._getAccount) )
                    {
                        return true ;
                    }
                    else
                    {
                        return false;
                    }
                }
            ]]>
        </script>;
       
      
      private var _debug:DebugConfiguration;
      
      private var _proxy:JavascriptProxy;
      
      private var _jsContainer:String = "_GATracker";
      
      private var _hasGATracker:Boolean = false;
      
      private var _account:String;
      
      public function Bridge(param1:String, param2:DebugConfiguration, param3:JavascriptProxy)
      {
         var _local4:* = null;
         var _local5:* = null;
         var _local6:* = null;
         super();
         this._account = param1;
         this._debug = param2;
         this._proxy = param3;
         if(!this._checkGAJS())
         {
            _local4 = "";
            _local4 = _local4 + "ga.js not found, be sure to check if\n";
            _local4 = _local4 + "<script src=\"http://www.google-analytics.com/ga.js\"></script>\n";
            _local4 = _local4 + "is included in the HTML.";
            this._debug.warning(_local4);
            throw new Error(_local4);
         }
         if(!this._hasGATracker)
         {
            if(Boolean(this._debug.javascript) && Boolean(this._debug.verbose))
            {
               _local5 = "";
               _local5 = _local5 + "The Google Analytics tracking code was not found on the container page\n";
               _local5 = _local5 + "we create it";
               this._debug.info(_local5,VisualDebugMode.advanced);
            }
            this._injectTrackingObject();
         }
         if(Utils.validateAccount(param1))
         {
            this._createTrackingObject(param1);
         }
         else if(this._checkTrackingObject(param1))
         {
            this._linkTrackingObject(param1);
         }
         else
         {
            _local6 = "";
            _local6 = _local6 + ("JS Object \"" + param1 + "\" doesn\'t exist in DOM\n");
            _local6 = _local6 + "Bridge object not created.";
            this._debug.warning(_local6);
            throw new Error(_local6);
         }
      }
      
      public function link(param1:String, param2:Boolean = false) : void
      {
         this._debug.info("link( " + param1 + ", " + param2 + " )");
         this._call("_link",param1,param2);
      }
      
      public function addOrganic(param1:String, param2:String) : void
      {
         this._debug.info("addOrganic( " + [param1,param2].join(", ") + " )");
         this._call("_addOrganic",param1);
      }
      
      public function setAllowLinker(param1:Boolean) : void
      {
         this._debug.info("setAllowLinker( " + param1 + " )");
         this._call("_setAllowLinker",param1);
      }
      
      public function getLinkerUrl(param1:String = "", param2:Boolean = false) : String
      {
         this._debug.info("getLinkerUrl(" + param1 + ", " + param2 + ")");
         return this._call("_getLinkerUrl",param1,param2);
      }
      
      private function _linkTrackingObject(param1:String) : void
      {
         this._proxy.call(_linkTrackingObject_js,this._jsContainer,param1);
      }
      
      public function setClientInfo(param1:Boolean) : void
      {
         this._debug.info("setClientInfo( " + param1 + " )");
         this._call("_setClientInfo",param1);
      }
      
      public function trackTrans() : void
      {
         this._debug.info("trackTrans()");
         this._call("_trackTrans");
      }
      
      public function trackEvent(param1:String, param2:String, param3:String = null, param4:Number = NaN) : Boolean
      {
         var _local5:int = 2;
         if(Boolean(param3) && param3 != "")
         {
            _local5 = 3;
         }
         if(_local5 == 3 && !isNaN(param4))
         {
            _local5 = 4;
         }
         switch(_local5)
         {
            case 4:
               this._debug.info("trackEvent( " + [param1,param2,param3,param4].join(", ") + " )");
               return this._call("_trackEvent",param1,param2,param3,param4);
            case 3:
               this._debug.info("trackEvent( " + [param1,param2,param3].join(", ") + " )");
               return this._call("_trackEvent",param1,param2,param3);
            case 2:
            default:
               this._debug.info("trackEvent( " + [param1,param2].join(", ") + " )");
               return this._call("_trackEvent",param1,param2);
         }
      }
      
      public function setCookieTimeout(param1:int) : void
      {
         this._debug.info("setCookieTimeout( " + param1 + " )");
         this._call("_setCookieTimeout",param1);
      }
      
      public function trackPageview(param1:String = "") : void
      {
         this._debug.info("trackPageview( " + param1 + " )");
         this._call("_trackPageview",param1);
      }
      
      private function _checkValidTrackingObject(param1:String) : Boolean
      {
         return this._proxy.call(_checkValidTrackingObject_js,param1);
      }
      
      private function _checkGAJS() : Boolean
      {
         return this._proxy.call(_checkGAJS_js);
      }
      
      public function linkByPost(param1:Object, param2:Boolean = false) : void
      {
         this._debug.warning("linkByPost( " + param1 + ", " + param2 + " ) not implemented");
      }
      
      public function getClientInfo() : Boolean
      {
         this._debug.info("getClientInfo()");
         return this._call("_getClientInfo");
      }
      
      private function _call(param1:String, ... rest) : *
      {
         rest.unshift("window." + this._jsContainer + "[\"" + this._account + "\"]." + param1);
         return this._proxy.call.apply(this._proxy,rest);
      }
      
      public function hasGAJS() : Boolean
      {
         return this._checkGAJS();
      }
      
      private function _checkTrackingObject(param1:String) : Boolean
      {
         var _local2:Boolean = this._proxy.hasProperty(param1);
         var _local3:Boolean = this._proxy.hasProperty(param1 + "._getAccount");
         return Boolean(_local2) && Boolean(_local3);
      }
      
      public function resetSession() : void
      {
         this._debug.warning("resetSession() not implemented");
      }
      
      public function getDetectTitle() : Boolean
      {
         this._debug.info("getDetectTitle()");
         return this._call("_getDetectTitle");
      }
      
      public function setCampNameKey(param1:String) : void
      {
         this._debug.info("setCampNameKey( " + param1 + " )");
         this._call("_setCampNameKey",param1);
      }
      
      public function setDetectFlash(param1:Boolean) : void
      {
         this._debug.info("setDetectFlash( " + param1 + " )");
         this._call("_setDetectFlash",param1);
      }
      
      public function createEventTracker(param1:String) : EventTracker
      {
         this._debug.info("createEventTracker( " + param1 + " )");
         return new EventTracker(param1,this);
      }
      
      public function addItem(param1:String, param2:String, param3:String, param4:String, param5:Number, param6:int) : void
      {
         this._debug.info("addItem( " + [param1,param2,param3,param4,param5,param6].join(", ") + " )");
         this._call("_addItem",param1,param2,param3,param4,param5,param6);
      }
      
      public function clearIgnoredOrganic() : void
      {
         this._debug.info("clearIgnoredOrganic()");
         this._call("_clearIgnoreOrganic");
      }
      
      public function setVar(param1:String) : void
      {
         this._debug.info("setVar( " + param1 + " )");
         this._call("_setVar",param1);
      }
      
      public function setDomainName(param1:String) : void
      {
         this._debug.info("setDomainName( " + param1 + " )");
         this._call("_setDomainName",param1);
      }
      
      public function hasTrackingAccount(param1:String) : Boolean
      {
         if(Utils.validateAccount(param1))
         {
            return this._checkValidTrackingObject(param1);
         }
         return this._checkTrackingObject(param1);
      }
      
      public function setCampSourceKey(param1:String) : void
      {
         this._debug.info("setCampSourceKey( " + param1 + " )");
         this._call("_setCampSourceKey",param1);
      }
      
      public function addTrans(param1:String, param2:String, param3:Number, param4:Number, param5:Number, param6:String, param7:String, param8:String) : void
      {
         this._debug.info("addTrans( " + [param1,param2,param3,param4,param5,param6,param7,param8].join(", ") + " )");
         this._call("_addTrans",param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      public function setCampContentKey(param1:String) : void
      {
         this._debug.info("setCampContentKey( " + param1 + " )");
         this._call("_setCampContentKey",param1);
      }
      
      public function setLocalServerMode() : void
      {
         this._debug.info("setLocalServerMode()");
         this._call("_setLocalServerMode");
      }
      
      public function getLocalGifPath() : String
      {
         this._debug.info("getLocalGifPath()");
         return this._call("_getLocalGifPath");
      }
      
      public function clearIgnoredRef() : void
      {
         this._debug.info("clearIgnoredRef()");
         this._call("_clearIgnoreRef");
      }
      
      public function setAllowAnchor(param1:Boolean) : void
      {
         this._debug.info("setAllowAnchor( " + param1 + " )");
         this._call("_setAllowAnchor",param1);
      }
      
      public function setLocalGifPath(param1:String) : void
      {
         this._debug.info("setLocalGifPath( " + param1 + " )");
         this._call("_setLocalGifPath",param1);
      }
      
      public function getVersion() : String
      {
         this._debug.info("getVersion()");
         return this._call("_getVersion");
      }
      
      private function _injectTrackingObject() : void
      {
         this._proxy.executeBlock(_injectTrackingObject_js);
         this._hasGATracker = true;
      }
      
      public function setCookiePath(param1:String) : void
      {
         this._debug.info("setCookiePath( " + param1 + " )");
         this._call("_setCookiePath",param1);
      }
      
      public function setSampleRate(param1:Number) : void
      {
         this._debug.info("setSampleRate( " + param1 + " )");
         this._call("_setSampleRate",param1);
      }
      
      public function setAllowHash(param1:Boolean) : void
      {
         this._debug.info("setAllowHash( " + param1 + " )");
         this._call("_setAllowHash",param1);
      }
      
      public function addIgnoredOrganic(param1:String) : void
      {
         this._debug.info("addIgnoredOrganic( " + param1 + " )");
         this._call("_addIgnoredOrganic",param1);
      }
      
      public function setCampNOKey(param1:String) : void
      {
         this._debug.info("setCampNOKey( " + param1 + " )");
         this._call("_setCampNOKey",param1);
      }
      
      public function cookiePathCopy(param1:String) : void
      {
         this._debug.info("cookiePathCopy( " + param1 + " )");
         this._call("_cookiePathCopy",param1);
      }
      
      public function setLocalRemoteServerMode() : void
      {
         this._debug.info("setLocalRemoteServerMode()");
         this._call("_setLocalRemoteServerMode");
      }
      
      public function getServiceMode() : ServerOperationMode
      {
         this._debug.info("getServiceMode()");
         return this._call("_getServiceMode");
      }
      
      public function setDetectTitle(param1:Boolean) : void
      {
         this._debug.info("setDetectTitle( " + param1 + " )");
         this._call("_setDetectTitle",param1);
      }
      
      private function _createTrackingObject(param1:String) : void
      {
         this._proxy.call(_createTrackingObject_js,param1);
      }
      
      public function setCampaignTrack(param1:Boolean) : void
      {
         this._debug.info("setCampaignTrack( " + param1 + " )");
         this._call("_setCampaignTrack",param1);
      }
      
      public function clearOrganic() : void
      {
         this._debug.info("clearOrganic()");
         this._call("_clearOrganic");
      }
      
      public function setCampTermKey(param1:String) : void
      {
         this._debug.info("setCampTermKey( " + param1 + " )");
         this._call("_setCampTermKey",param1);
      }
      
      public function getDetectFlash() : Boolean
      {
         this._debug.info("getDetectFlash()");
         return this._call("_getDetectFlash");
      }
      
      public function setCampMediumKey(param1:String) : void
      {
         this._debug.info("setCampMediumKey( " + param1 + " )");
         this._call("_setCampMediumKey",param1);
      }
      
      public function addIgnoredRef(param1:String) : void
      {
         this._debug.info("addIgnoredRef( " + param1 + " )");
         this._call("_addIgnoredRef",param1);
      }
      
      public function setSessionTimeout(param1:int) : void
      {
         this._debug.info("setSessionTimeout( " + param1 + " )");
         this._call("_setSessionTimeout",param1);
      }
      
      public function setRemoteServerMode() : void
      {
         this._debug.info("setRemoteServerMode()");
         this._call("_setRemoteServerMode");
      }
      
      public function getAccount() : String
      {
         this._debug.info("getAccount()");
         return this._call("_getAccount");
      }
   }
}
