package com.google.analytics.core
{
   import com.google.analytics.debug.DebugConfiguration;
   import com.google.analytics.debug.VisualDebugMode;
   
   public class Domain
   {
       
      
      private var _mode:com.google.analytics.core.DomainNameMode;
      
      private var _debug:DebugConfiguration;
      
      private var _name:String;
      
      public function Domain(param1:com.google.analytics.core.DomainNameMode = null, param2:String = "", param3:DebugConfiguration = null)
      {
         super();
         this._debug = param3;
         if(param1 == null)
         {
            param1 = DomainNameMode.auto;
         }
         this._mode = param1;
         if(param1 == DomainNameMode.custom)
         {
            this.name = param2;
         }
         else
         {
            this._name = param2;
         }
      }
      
      public function get mode() : com.google.analytics.core.DomainNameMode
      {
         return this._mode;
      }
      
      public function set mode(param1:com.google.analytics.core.DomainNameMode) : void
      {
         this._mode = param1;
         if(this._mode == DomainNameMode.none)
         {
            this._name = "";
         }
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         if(param1.charAt(0) != "." && Boolean(this._debug))
         {
            this._debug.warning("missing leading period \".\", cookie will only be accessible on " + param1,VisualDebugMode.geek);
         }
         this._name = param1;
      }
   }
}
