package com.google.analytics.core
{
   public class ServerOperationMode
   {
      
      public static const both:com.google.analytics.core.ServerOperationMode = new com.google.analytics.core.ServerOperationMode(2,"both");
      
      public static const remote:com.google.analytics.core.ServerOperationMode = new com.google.analytics.core.ServerOperationMode(1,"remote");
      
      public static const local:com.google.analytics.core.ServerOperationMode = new com.google.analytics.core.ServerOperationMode(0,"local");
       
      
      private var _value:int;
      
      private var _name:String;
      
      public function ServerOperationMode(param1:int = 0, param2:String = "")
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
