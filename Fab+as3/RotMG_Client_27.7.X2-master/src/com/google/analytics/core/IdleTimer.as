package com.google.analytics.core
{
   import flash.display.Stage;
   import flash.utils.Timer;
   import com.google.analytics.debug.DebugConfiguration;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import com.google.analytics.debug.VisualDebugMode;
   import flash.events.TimerEvent;
   import com.google.analytics.v4.Configuration;
   import flash.display.DisplayObject;
   
   public class IdleTimer
   {
       
      
      private var _stage:Stage;
      
      private var _loop:Timer;
      
      private var _lastMove:int;
      
      private var _inactivity:Number;
      
      private var _debug:DebugConfiguration;
      
      private var _session:Timer;
      
      private var _buffer:com.google.analytics.core.Buffer;
      
      public function IdleTimer(param1:Configuration, param2:DebugConfiguration, param3:DisplayObject, param4:com.google.analytics.core.Buffer)
      {
         super();
         var _local5:Number = param1.idleLoop;
         var _local6:Number = param1.idleTimeout;
         var _local7:Number = param1.sessionTimeout;
         this._loop = new Timer(_local5 * 1000);
         this._session = new Timer(_local7 * 1000,1);
         this._debug = param2;
         this._stage = param3.stage;
         this._buffer = param4;
         this._lastMove = getTimer();
         this._inactivity = _local6 * 1000;
         this._loop.addEventListener(TimerEvent.TIMER,this.checkForIdle);
         this._session.addEventListener(TimerEvent.TIMER_COMPLETE,this.endSession);
         this._stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this._debug.info("delay: " + _local5 + "sec , inactivity: " + _local6 + "sec, sessionTimeout: " + _local7,VisualDebugMode.geek);
         this._loop.start();
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         this._lastMove = getTimer();
         if(this._session.running)
         {
            this._debug.info("session timer reset",VisualDebugMode.geek);
            this._session.reset();
         }
      }
      
      public function endSession(param1:TimerEvent) : void
      {
         this._session.removeEventListener(TimerEvent.TIMER_COMPLETE,this.endSession);
         this._debug.info("session timer end session",VisualDebugMode.geek);
         this._session.reset();
         this._buffer.resetCurrentSession();
         this._debug.info(this._buffer.utmb.toString(),VisualDebugMode.geek);
         this._debug.info(this._buffer.utmc.toString(),VisualDebugMode.geek);
         this._session.addEventListener(TimerEvent.TIMER_COMPLETE,this.endSession);
      }
      
      public function checkForIdle(param1:TimerEvent) : void
      {
         var _local2:int = getTimer();
         if(_local2 - this._lastMove >= this._inactivity)
         {
            if(!this._session.running)
            {
               this._debug.info("session timer start",VisualDebugMode.geek);
               this._session.start();
            }
         }
      }
   }
}
