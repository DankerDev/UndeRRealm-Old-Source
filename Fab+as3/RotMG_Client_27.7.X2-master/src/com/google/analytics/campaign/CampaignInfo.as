package com.google.analytics.campaign
{
   import com.google.analytics.utils.Variables;
   
   public class CampaignInfo
   {
       
      
      private var _new:Boolean;
      
      private var _empty:Boolean;
      
      public function CampaignInfo(param1:Boolean = true, param2:Boolean = false)
      {
         super();
         this._empty = param1;
         this._new = param2;
      }
      
      public function toURLString() : String
      {
         var _local1:Variables = this.toVariables();
         return _local1.toString();
      }
      
      public function isNew() : Boolean
      {
         return this._new;
      }
      
      public function get utmcn() : String
      {
         return "1";
      }
      
      public function isEmpty() : Boolean
      {
         return this._empty;
      }
      
      public function toVariables() : Variables
      {
         var _local1:Variables = new Variables();
         _local1.URIencode = true;
         if(!this.isEmpty() && Boolean(this.isNew()))
         {
            _local1.utmcn = this.utmcn;
         }
         if(!this.isEmpty() && !this.isNew())
         {
            _local1.utmcr = this.utmcr;
         }
         return _local1;
      }
      
      public function get utmcr() : String
      {
         return "1";
      }
   }
}
