package views {
  //flash class dependencies
  import flash.display.Sprite;
  //project specific class dependencies
  import helpers.bar.*;
  import helpers.application.*;
  //library items
  
  //lib classes

  public class BarView extends Sprite {
    //Class Constructor
    public function BarView(w, h){
      super();
      init(w, h);
    }
    //***********************************
    //Static Functions and Variables
    //***********************************


    //***********************************
    //public methods
    //***********************************
    public function createControls():Sprite {
      
      _controlContainer = new ControlBar(_w, 31);
      //_arrParts.push(_controlContainer);
      addChild(_controlContainer)
      _controlContainer.x = (_w /2) - (_controlContainer.width / 2);
      _controlContainer.y = _h - _controlContainer.height;
      addChild(_controlContainer);
      return _controlContainer as Sprite;
    }
    public function createPausePlay():TogglePausePlay {
      var tpp:TogglePausePlay = new TogglePausePlay();
      _controlContainer.addChildAtLocation(tpp, {float:"left"});
      return tpp;
    }
    public function createPlayHead():Sprite {
      var ph:Sprite = new Sprite();
      _controlContainer.addChildAtLocation(ph, {float:"left"});
      return ph;
    }
    public function createVolume():Volume {
      var v:Volume = new Volume(60, 13);
      _controlContainer.addChildAtLocation(v, {float:"right", y:_controlContainer.height/2 - 6.5});
      return v;
    }
    public function createMaximizeBtn():MaximizeBtn {
      var maxBtn:MaximizeBtn = new MaximizeBtn();
      _controlContainer.addChildAtLocation(maxBtn, {float:"right"});
      return maxBtn;
    }
    public function createTimeCode():TimeCode{
      var tc:TimeCode = new TimeCode(48, 30);
      _controlContainer.addChildAtLocation(tc, {float:"right"});
      return tc;
    }
    
    public function createTrackBar():TrackBar{
      var tb:TrackBar = new TrackBar(_controlContainer.remainingWidth, 30);
      _controlContainer.addChildAtLocation(tb, {float:"left", padding:0, autosize:true});
      return tb;
    }
    

    public function setSizeAndPosition(stageW:Number,stageH:Number):void{
      _controlContainer._width = stageW;
      _controlContainer.x = stageW/2 - _controlContainer._width/2;
      this.y = stageH - _h;
      
    }

    //***********************************
    //getters and setters
    //***********************************


    //***********************************
    //Eventhandlers
    //***********************************

    //***********************************
    //private variables
    //***********************************
    private var _controlContainer:ControlBar;
    private var _w:Number;
    private var _h:Number;
    //***********************************
    //private methods
    //***********************************
    private function init(w:Number, h:Number):void{
      _w = w;
      _h = h;
    }

  }

}


