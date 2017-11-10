package com.company.assembleegameclient.map.mapoverlay
{
   import flash.display.Sprite;
   import kabam.rotmg.game.view.components.QueuedStatusText;
   import kabam.rotmg.game.view.components.QueuedStatusTextList;
   import com.company.assembleegameclient.map.Camera;
   
   public class MapOverlay extends Sprite
   {
       
      
      private const speechBalloons:Object = {};
      
      private const queuedText:Object = {};
      
      public function MapOverlay()
      {
         super();
         mouseEnabled = true;
         mouseChildren = true;
      }
      
      public function addSpeechBalloon(param1:SpeechBalloon) : void
      {
         var _local2:int = param1.go_.objectId_;
         var _local3:SpeechBalloon = this.speechBalloons[_local2];
         if(Boolean(_local3) && Boolean(contains(_local3)))
         {
            removeChild(_local3);
         }
         this.speechBalloons[_local2] = param1;
         addChild(param1);
      }
      
      public function addStatusText(param1:CharacterStatusText) : void
      {
         addChild(param1);
      }
      
      public function addQueuedText(param1:QueuedStatusText) : void
      {
         var _local2:int = param1.go_.objectId_;
         var _local3:QueuedStatusTextList = this.queuedText[_local2] = this.queuedText[_local2] || this.makeQueuedStatusTextList();
         _local3.append(param1);
      }
      
      private function makeQueuedStatusTextList() : QueuedStatusTextList
      {
         var _local1:QueuedStatusTextList = new QueuedStatusTextList();
         _local1.target = this;
         return _local1;
      }
      
      public function draw(param1:Camera, param2:int) : void
      {
         var _local4:IMapOverlayElement = null;
         var _local3:int = 0;
         while(_local3 < numChildren)
         {
            _local4 = getChildAt(_local3) as IMapOverlayElement;
            if(!_local4 || Boolean(_local4.draw(param1,param2)))
            {
               _local3++;
            }
            else
            {
               _local4.dispose();
            }
         }
      }
   }
}
