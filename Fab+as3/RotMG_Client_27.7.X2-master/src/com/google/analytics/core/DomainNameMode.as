package com.google.analytics.core
{
   public class DomainNameMode
   {
      
      public static const custom:com.google.analytics.core.DomainNameMode = new com.google.analytics.core.DomainNameMode(2,"custom");
      
      public static const none:com.google.analytics.core.DomainNameMode = new com.google.analytics.core.DomainNameMode(0,"none");
      
      public static const auto:com.google.analytics.core.DomainNameMode = new com.google.analytics.core.DomainNameMode(1,"auto");
       
      
      private var _value:int;
      
      private var _name:String;
      
      public function DomainNameMode(param1:int = 0, param2:String = "")
      {
         super();
         this._value = param1;
         this._name = param2;
      }
      
      public function valueOf() : int
      {
         return this._value;
      }
      
      public function toString() : String
      {
         return this._name;
      }
   }
}
