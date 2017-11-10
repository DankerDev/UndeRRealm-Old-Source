package com.company.assembleegameclient.map.partyoverlay
{
   import flash.display.Sprite;
   import com.company.assembleegameclient.map.Map;
   import flash.events.Event;
   import com.company.assembleegameclient.map.Camera;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.objects.Party;
   
   public class PartyOverlay extends Sprite
   {
       
      
      public var map_:Map;
      
      public var partyMemberArrows_:Vector.<com.company.assembleegameclient.map.partyoverlay.PlayerArrow> = null;
      
      public var questArrow_:com.company.assembleegameclient.map.partyoverlay.QuestArrow;
      
      public function PartyOverlay(param1:Map)
      {
         var _local3:com.company.assembleegameclient.map.partyoverlay.PlayerArrow = null;
         super();
         this.map_ = param1;
         this.partyMemberArrows_ = new Vector.<PlayerArrow>(Party.NUM_MEMBERS,true);
         var _local2:int = 0;
         while(_local2 < Party.NUM_MEMBERS)
         {
            _local3 = new com.company.assembleegameclient.map.partyoverlay.PlayerArrow();
            this.partyMemberArrows_[_local2] = _local3;
            addChild(_local3);
            _local2++;
         }
         this.questArrow_ = new com.company.assembleegameclient.map.partyoverlay.QuestArrow(this.map_);
         addChild(this.questArrow_);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         GameObjectArrow.removeMenu();
      }
      
      public function draw(param1:Camera, param2:int) : void
      {
         var _local6:com.company.assembleegameclient.map.partyoverlay.PlayerArrow = null;
         var _local7:Player = null;
         var _local8:int = 0;
         var _local9:com.company.assembleegameclient.map.partyoverlay.PlayerArrow = null;
         var _local10:Number = NaN;
         var _local11:Number = NaN;
         if(this.map_.player_ == null)
         {
            return;
         }
         var _local3:Party = this.map_.party_;
         var _local4:Player = this.map_.player_;
         var _local5:int = 0;
         while(_local5 < Party.NUM_MEMBERS)
         {
            _local6 = this.partyMemberArrows_[_local5];
            if(!_local6.mouseOver_)
            {
               if(_local5 >= _local3.members_.length)
               {
                  _local6.setGameObject(null);
               }
               else
               {
                  _local7 = _local3.members_[_local5];
                  if(Boolean(_local7.drawn_) || _local7.map_ == null || Boolean(_local7.dead_))
                  {
                     _local6.setGameObject(null);
                  }
                  else
                  {
                     _local6.setGameObject(_local7);
                     _local8 = 0;
                     while(_local8 < _local5)
                     {
                        _local9 = this.partyMemberArrows_[_local8];
                        _local10 = _local6.x - _local9.x;
                        _local11 = _local6.y - _local9.y;
                        if(_local10 * _local10 + _local11 * _local11 < 64)
                        {
                           if(!_local9.mouseOver_)
                           {
                              _local9.addGameObject(_local7);
                           }
                           _local6.setGameObject(null);
                           break;
                        }
                        _local8++;
                     }
                     _local6.draw(param2,param1);
                  }
               }
            }
            _local5++;
         }
         if(!this.questArrow_.mouseOver_)
         {
            this.questArrow_.draw(param2,param1);
         }
      }
   }
}
