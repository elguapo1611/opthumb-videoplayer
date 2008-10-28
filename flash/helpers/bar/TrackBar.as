package helpers.bar {
  //flash class dependencies
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.events.Event;
  import flash.geom.Rectangle;
  import flash.display.Stage;
  //project specific class dependencies
  import helpers.bar.Chapter;
  //library items
  import buffering;
  //lib classes

  public class TrackBar extends Sprite {
    //Class Constructor
    public function TrackBar(w:Number, h:Number){
      super();
      init(w, h);
    }
    //***********************************
    //Static Functions and Variables
    //***********************************
    public static var TIMELINE_CLICK:String = "timelineClick";

    //***********************************
    //public methods
    //***********************************

    public function addChapter(percent:Number):Sprite{
      var chapter:Chapter = new Chapter(5, 30);
      chapter.y = _h/2;
      chapter.x = _w*percent;
      chapter.percent = percent;
      _container.addChild(chapter);
      return chapter;
    }
    public function showBuffer():void{
      if(!_buffer){
        _buffer = new buffering();
        _buffer.y=_h/2 - _buffer.height/2;
        _container.addChild(_buffer); 
      }
    }
    public function hideBuffer():void{
      try{
        _container.removeChild(_buffer);
        _buffer = null;
      }catch(e:Error){
        
      }
      
      
    }
    //***********************************
    //getters and setters
    //***********************************
    public function set preloadPercent(i:Number):void{
      _preloadBar.width = i *_timeLineArea.width;
    }
    public function set playPercent(i:Number):void{
      _playBar.width = i *_timeLineArea.width;
    }
    public function get currentPercent():Number{
      return _currentPercent;
    }
    
    public function get _width():Number{
      return _w;
    }
    public function set _width(i:Number):void{
      _w = i;
      _timeLineArea.width = i;
      for(var j:int = 0; j<_arrChapters.length; j++){
        _arrChapters[j].x = _w * _arrChapters[j].percent;
      }
    }
    //***********************************
    //Eventhandlers
    //***********************************
    private function mouseHandler(e:MouseEvent):void{
      switch(e.type){
        case MouseEvent.CLICK:
        
          _currentPercent = this.mouseX / e.currentTarget.width;
          dispatchEvent(new Event(TIMELINE_CLICK, true));
        break;
        case MouseEvent.ROLL_OVER:
          showVertLine(true);
          _verticalLine.startDrag(true, new Rectangle(0,0,_w,0))
          stage.addEventListener(Event.MOUSE_LEAVE, stageHandler);
        break;
        case MouseEvent.ROLL_OUT:
          hideVertical();
        break;
      }
    }
    private function stageHandler():void{
      hideVertical();
    }
    //***********************************
    //private variables
    //***********************************
    private var _preloadBar:Sprite;
    private var _timeLineArea:Sprite;
    private var _playBar:Sprite;
    private var _container:Sprite;
    private var _verticalLine:Sprite;
    private var _currentPercent:Number;
    private var _w:Number;
    private var _h:Number;
    private var _buffer:buffering;
    private var _arrChapters:Array;
    
    //hacky variable for storing the original width of the bar.
    private var _wOriginal:Number;
    
    //***********************************
    //private methods
    //***********************************
    private function init(w:Number, h:Number):void{
      _arrChapters = new Array();
      _w = w;
      _h = h;
      _wOriginal = _w;
      createGraphics();
      createEvents();
      preloadPercent = 0;
      playPercent = 0;
      
      _arrChapters.push(addChapter(.1), addChapter(.15), addChapter(.4),addChapter(.7));
      //this.graphics.lineStyle(1,0xff0000);
      //this.graphics.drawRect(0,0,w,h)
      
    }
    private function createGraphics():void{
      _timeLineArea = new Sprite();
      //override hack to prevent vertical line from being drawn.  Really crazy
      
      this.graphics.lineStyle(1, 0xffffff, 0);
      this.graphics.drawRect(0,0, _w, _h)
      
      _preloadBar = new Sprite();
      _playBar = new Sprite();
      _container = new Sprite();
      _verticalLine = new Sprite();
      _verticalLine.graphics.lineStyle(1,0xffffff, .4);
      _verticalLine.graphics.lineTo(0,_h);
      
      _verticalLine.alpha = 0;
      _container.addChild(_verticalLine);
      _timeLineArea.graphics.beginFill(0xffffff,0);
      //_timeLineArea.graphics.lineStyle(1, 0xff0000);
      _timeLineArea.graphics.drawRect(0,0,_w, _h);
      
      createBar(_preloadBar, 0x999999, .2);
      createBar(_playBar, 0x999999, .4);
      addChild(_preloadBar);
      addChild(_playBar);
      addChild(_timeLineArea)
      addChild(_container);
      

    }
    private function createEvents():void{
      _timeLineArea.addEventListener(MouseEvent.ROLL_OVER, mouseHandler);
      _timeLineArea.addEventListener(MouseEvent.ROLL_OUT, mouseHandler);
      _timeLineArea.addEventListener(MouseEvent.CLICK, mouseHandler);
    }
    private function createBar(s:Sprite, color:int, a:Number){
      
      s.graphics.beginFill(color, a)
      s.graphics.drawRect(0,0, 100, _h)
    }
    private function showVertLine(b:Boolean):void{
      if(b){
        _verticalLine.alpha = 1
      }else{
        _verticalLine.alpha=0;
      }
    }
    private function hideVertical():void{
      stage.removeEventListener(Event.MOUSE_LEAVE, stageHandler);
      _verticalLine.stopDrag();
      showVertLine(false)
    }
  }

}

