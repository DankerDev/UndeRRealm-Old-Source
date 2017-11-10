package com.company.assembleegameclient.map
{
   import robotlegs.bender.bundles.mvcs.Mediator;
   import kabam.rotmg.game.view.components.QueuedStatusText;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class MapMediator extends Mediator
   {
       
      
      [Inject]
      public var view:com.company.assembleegameclient.map.Map;
      
      [Inject]
      public var queueStatusText:com.company.assembleegameclient.map.QueueStatusTextSignal;
      
      public function MapMediator()
      {
         super();
      }
      
      override public function initialize() : void
      {
         this.queueStatusText.add(this.onQueuedStatusText);
      }
      
      override public function destroy() : void
      {
         this.queueStatusText.remove(this.onQueuedStatusText);
      }
      
      private function onQueuedStatusText(param1:String, param2:uint) : void
      {
         this.view.player_ && this.queueText(param1,param2);
      }
      
      private function queueText(param1:String, param2:uint) : void
      {
         var _local3:QueuedStatusText = new QueuedStatusText(this.view.player_,new LineBuilder().setParams(param1),param2,2000,0);
         this.view.mapOverlay_.addQueuedText(_local3);
      }
   }
}
