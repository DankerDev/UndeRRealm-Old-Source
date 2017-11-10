package com.google.analytics.utils
{
   public class Protocols
   {
      
      public static const none:com.google.analytics.utils.Protocols = new com.google.analytics.utils.Protocols(0,"none");
      
      public static const HTTPS:com.google.analytics.utils.Protocols = new com.google.analytics.utils.Protocols(3,"HTTPS");
      
      public static const file:com.google.analytics.utils.Protocols = new com.google.analytics.utils.Protocols(1,"file");
      
      public static const HTTP:com.google.analytics.utils.Protocols = new com.google.analytics.utils.Protocols(2,"HTTP");
       
      
      private var _value:int;
      
      private var _name:String;
      
      public function Protocols(param1:int = 0, param2:String = "")
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
