package com.company.assembleegameclient.map
{
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import com.company.assembleegameclient.game.AGameSprite;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.background.Background;
   import com.company.assembleegameclient.map.mapoverlay.MapOverlay;
   import com.company.assembleegameclient.map.partyoverlay.PartyOverlay;
   import com.company.assembleegameclient.objects.Party;
   import org.osflash.signals.Signal;
   import com.company.assembleegameclient.objects.BasicObject;
   import flash.geom.Point;
   
   public class AbstractMap extends Sprite
   {
       
      
      public var goDict_:Dictionary;
      
      public var gs_:AGameSprite;
      
      public var name_:String;
      
      public var player_:Player = null;
      
      public var showDisplays_:Boolean;
      
      public var width_:int;
      
      public var height_:int;
      
      public var back_:int;
      
      protected var allowPlayerTeleport_:Boolean;
      
      public var background_:Background = null;
      
      public var map_:Sprite;
      
      public var hurtOverlay_:com.company.assembleegameclient.map.HurtOverlay = null;
      
      public var mapOverlay_:MapOverlay = null;
      
      public var partyOverlay_:PartyOverlay = null;
      
      public var squareList_:Vector.<com.company.assembleegameclient.map.Square>;
      
      public var squares_:Vector.<com.company.assembleegameclient.map.Square>;
      
      public var boDict_:Dictionary;
      
      public var merchLookup_:Object;
      
      public var party_:Party = null;
      
      public var quest_:com.company.assembleegameclient.map.Quest = null;
      
      public var signalRenderSwitch:Signal;
      
      protected var wasLastFrameGpu:Boolean = false;
      
      public var isPetYard:Boolean = false;
      
      public function AbstractMap()
      {
         this.goDict_ = new Dictionary();
         this.map_ = new Sprite();
         this.squareList_ = new Vector.<Square>();
         this.squares_ = new Vector.<Square>();
         this.boDict_ = new Dictionary();
         this.merchLookup_ = new Object();
         this.signalRenderSwitch = new Signal(Boolean);
         super();
      }
      
      public function setProps(param1:int, param2:int, param3:String, param4:int, param5:Boolean, param6:Boolean) : void
      {
      }
      
      public function addObj(param1:BasicObject, param2:Number, param3:Number) : void
      {
      }
      
      public function setGroundTile(param1:int, param2:int, param3:uint) : void
      {
      }
      
      public function initialize() : void
      {
      }
      
      public function resetOverlays() : void
      {
      }
      
      public function dispose() : void
      {
      }
      
      public function update(param1:int, param2:int) : void
      {
      }
      
      public function pSTopW(param1:Number, param2:Number) : Point
      {
         return null;
      }
      
      public function removeObj(param1:int) : void
      {
      }
      
      public function draw(param1:Camera, param2:int) : void
      {
      }
      
      public function allowPlayerTeleport() : Boolean
      {
         return this.name_ != Map.NEXUS && Boolean(this.allowPlayerTeleport_);
      }
   }
}
