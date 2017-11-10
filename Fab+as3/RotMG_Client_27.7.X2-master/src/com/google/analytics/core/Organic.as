package com.google.analytics.core
{
   import com.google.analytics.utils.Variables;
   
   public class Organic
   {
      
      public static var throwErrors:Boolean = false;
       
      
      private var _sourcesCache:Array;
      
      private var _sourcesEngine:Array;
      
      private var _ignoredKeywords:Array;
      
      private var _ignoredReferralsCache:Object;
      
      private var _ignoredReferrals:Array;
      
      private var _ignoredKeywordsCache:Object;
      
      private var _sources:Array;
      
      public function Organic()
      {
         super();
         this._sources = [];
         this._sourcesCache = [];
         this._sourcesEngine = [];
         this._ignoredReferrals = [];
         this._ignoredReferralsCache = {};
         this._ignoredKeywords = [];
         this._ignoredKeywordsCache = {};
      }
      
      public static function getKeywordValueFromPath(param1:String, param2:String) : String
      {
         var _local3:String = null;
         var _local4:Variables = null;
         if(param2.indexOf(param1 + "=") > -1)
         {
            if(param2.charAt(0) == "?")
            {
               param2 = param2.substr(1);
            }
            param2 = param2.split("+").join("%20");
            _local4 = new Variables(param2);
            _local3 = _local4[param1];
         }
         return _local3;
      }
      
      public function isIgnoredKeyword(param1:String) : Boolean
      {
         if(this._ignoredKeywordsCache.hasOwnProperty(param1))
         {
            return true;
         }
         return false;
      }
      
      public function getKeywordValue(param1:OrganicReferrer, param2:String) : String
      {
         var _local3:String = param1.keyword;
         return getKeywordValueFromPath(_local3,param2);
      }
      
      public function isIgnoredReferral(param1:String) : Boolean
      {
         if(this._ignoredReferralsCache.hasOwnProperty(param1))
         {
            return true;
         }
         return false;
      }
      
      public function clear() : void
      {
         this.clearEngines();
         this.clearIgnoredReferrals();
         this.clearIgnoredKeywords();
      }
      
      public function get count() : int
      {
         return this._sources.length;
      }
      
      public function get ignoredKeywordsCount() : int
      {
         return this._ignoredKeywords.length;
      }
      
      public function match(param1:String) : Boolean
      {
         if(param1 == "")
         {
            return false;
         }
         param1 = param1.toLowerCase();
         if(this._sourcesEngine[param1] != undefined)
         {
            return true;
         }
         return false;
      }
      
      public function clearIgnoredKeywords() : void
      {
         this._ignoredKeywords = [];
         this._ignoredKeywordsCache = {};
      }
      
      public function addSource(param1:String, param2:String) : void
      {
         var _local3:OrganicReferrer = new OrganicReferrer(param1,param2);
         if(this._sourcesCache[_local3.toString()] == undefined)
         {
            this._sources.push(_local3);
            this._sourcesCache[_local3.toString()] = this._sources.length - 1;
            if(this._sourcesEngine[_local3.engine] == undefined)
            {
               this._sourcesEngine[_local3.engine] = [this._sources.length - 1];
            }
            else
            {
               this._sourcesEngine[_local3.engine].push(this._sources.length - 1);
            }
         }
         else if(throwErrors)
         {
            throw new Error(_local3.toString() + " already exists, we don\'t add it.");
         }
      }
      
      public function clearEngines() : void
      {
         this._sources = [];
         this._sourcesCache = [];
         this._sourcesEngine = [];
      }
      
      public function get ignoredReferralsCount() : int
      {
         return this._ignoredReferrals.length;
      }
      
      public function addIgnoredReferral(param1:String) : void
      {
         if(this._ignoredReferralsCache[param1] == undefined)
         {
            this._ignoredReferrals.push(param1);
            this._ignoredReferralsCache[param1] = this._ignoredReferrals.length - 1;
         }
         else if(throwErrors)
         {
            throw new Error("\"" + param1 + "\" already exists, we don\'t add it.");
         }
      }
      
      public function clearIgnoredReferrals() : void
      {
         this._ignoredReferrals = [];
         this._ignoredReferralsCache = {};
      }
      
      public function getReferrerByName(param1:String) : OrganicReferrer
      {
         var _local2:int = 0;
         if(this.match(param1))
         {
            _local2 = this._sourcesEngine[param1][0];
            return this._sources[_local2];
         }
         return null;
      }
      
      public function addIgnoredKeyword(param1:String) : void
      {
         if(this._ignoredKeywordsCache[param1] == undefined)
         {
            this._ignoredKeywords.push(param1);
            this._ignoredKeywordsCache[param1] = this._ignoredKeywords.length - 1;
         }
         else if(throwErrors)
         {
            throw new Error("\"" + param1 + "\" already exists, we don\'t add it.");
         }
      }
      
      public function get sources() : Array
      {
         return this._sources;
      }
   }
}
