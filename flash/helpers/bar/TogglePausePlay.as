package helpers.bar {
  //flash class dependencies
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  //project specific class dependencies
  import helpers.application.Button;
  //library items
  import toggle_mc;
  //lib classes

  public class TogglePausePlay extends Button {
    //Class Constructor
    public function TogglePausePlay(){
      super();
      init();
    }
    //***********************************
    //Static Functions and Variables
    //***********************************
    public static var ON_PAUSE:String = "onPause";
    public static var ON_PLAY:String = "onPlay";

    //***********************************
    //public methods
    //***********************************
    public function togglePausePlay():void{
      this.isPaused = !_isPaused;
    }

    //***********************************
    //getters and setters
    //***********************************
    public function set isPaused(b:Boolean):void{
      
      _isPaused = b;
      if(_isPaused){
        _btn.gotoAndStop(1);
        dispatchEvent(new MouseEvent(ON_PLAY, true));        
      }else{
        _btn.gotoAndStop(2);
        dispatchEvent(new MouseEvent(ON_PAUSE, true));

      }
    }
    public function get isPaused():Boolean{
      return _isPaused;
    }


    //***********************************
    //Eventhandlers
    //***********************************
    private function mouseHandler(e:MouseEvent):void{
      togglePausePlay();
    }
    //***********************************
    //private variables
    //***********************************
    private var _btn:toggle_mc;
    private var _isPaused:Boolean;
    //***********************************
    //private methods
    //***********************************
    private function init():void{
      _btn = new toggle_mc();
      _btn.buttonMode = true;
      addChild(_btn);
      _isPaused = false;
      _btn.gotoAndStop(2)
      _btn.addEventListener(MouseEvent.CLICK, mouseHandler);
      
    }

  }

}

