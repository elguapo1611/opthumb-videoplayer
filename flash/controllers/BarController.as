package controllers {
  //flash class dependencies
  import flash.display.Sprite;
  //project specific class dependencies
  import views.BarView;
  import helpers.bar.*;
  
  //library items
  
  //lib classes

  public class BarController extends Sprite {
    //Class Constructor
    public function BarController(w, h){
      super();
      init(w, h);
    }
    //***********************************
    //Static Functions and Variables
    //***********************************


    //***********************************
    //public methods
    //***********************************
    public function setSizeAndPosition(w:Number, h:Number):void{
      _view.setSizeAndPosition(w,h);
    }
    public function showBuffer():void{
      _tb.showBuffer();
    }
    public function hideBuffer():void{
      _tb.hideBuffer();
    }
    public function togglePausePlay():void{
      _pausePlay.togglePausePlay();
    }
    

    //***********************************
    //getters and setters
    //***********************************
    public function set preloadPercent(i:Number):void{
      _tb.preloadPercent = i;
    }
    public function set playPercent(i:Number):void{
      _tb.playPercent = i;
    }
    public function set currentTime(i:Number):void{
      _tc.currentTime = i;
    }
    public function get currentPercent():Number{
      return _tb.currentPercent;
    }
    public function set totalTime(i:Number):void{
      _tc.totalTime = i;
    }
    public function get volume():Number{
      return _vol.volume;
    }

    //***********************************
    //Eventhandlers
    //***********************************

    //***********************************
    //private variables
    //***********************************
    private var _view:BarView;
    private var _controls:Sprite;
    private var _vol:Volume;
    private var _pausePlay:TogglePausePlay;
    private var _tc:TimeCode;
    private var _tb:TrackBar;
    private var _maxBtn:MaximizeBtn;
    //***********************************
    //private methods
    //***********************************
    private function init(w, h):void{
      createView(w, h);
    }
    private function createView(w, h):void{
      _view = new BarView(w, h);
      addChild(_view)
      _controls = _view.createControls();
      _vol = _view.createVolume();
      _maxBtn = _view.createMaximizeBtn();
      _tc = _view.createTimeCode();
      _pausePlay = _view.createPausePlay();
      _tb = _view.createTrackBar();
    }

  }

}

