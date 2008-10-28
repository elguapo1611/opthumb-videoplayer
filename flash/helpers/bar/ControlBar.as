package helpers.bar {
  //flash class dependencies
  import flash.display.Sprite;
  //project specific class dependencies

  //library items
  import barBg_mc;
  //lib classes

  public class ControlBar extends Sprite {
    //Class Constructor
    public function ControlBar(w:Number, h:Number){
      super();
      init(w, h);
    }
    //***********************************
    //Static Functions and Variables
    //***********************************
    public static var MIN_WIDTH:Number = 320;
    public static var MAX_WIDTH:Number = 640;
    public static var PADDING:Number = 5;
    //***********************************
    //public methods
    //***********************************
    public function addChildAtLocation(s, options:Object):void{
      s.y=1;
      //options x, y, float: {left or right}
      if(options.y){
        s.y = options.y;
      }
      if(options.autosize == true){
        _resizeSprite = s;
      }
      if(options.float == "right"){
        s.x = - s.width - _rightContainer.width-PADDING;
        _rightContainer.addChild(s);
        _rightContainer.graphics.moveTo(options.x, 0);
        drawVertLine(_rightContainer, s.x-PADDING)
      }else{
        //add default padding unless the padding is set to 0
        s.x = _leftContainer.width+((options.padding==0)?options.padding : PADDING);
        _leftContainer.addChild(s);
        
        //Exclude a vertical line if the item being added is the last item
        if(remainingWidth > 0)
          drawVertLine(_leftContainer, s.x+s.width+PADDING)
      }
      
      
      
    }

    //***********************************
    //getters and setters
    //***********************************
    public function get remainingWidth():Number{
      return _w - _leftContainer.width - _rightContainer.width;
    }
    public function set _width(i:Number):void{
      i = setMaxMinWidth(i);
      _w = i;
      _bar.width = i;
      _rightContainer.x = i;
      //trace(this.remainingWidth+_resizeSprite.width)
      _resizeSprite._width = this.remainingWidth+_resizeSprite.width;
    }
    public function get _width():Number{
      return _w;
    }

    //***********************************
    //Eventhandlers
    //***********************************

    //***********************************
    //private variables
    //***********************************
    private var _w:Number;
    private var _h:Number;
    private var _bg:Sprite;
    private var _leftContainer:Sprite;
    private var _rightContainer:Sprite;
    private var _bar:barBg_mc;
    private var _resizeSprite;
    //***********************************
    //private methods
    //***********************************
    private function init(w:Number, h:Number):void{
      w = setMaxMinWidth(w);
      _w = w;
      _h = h;
      createGraphics(w, h);
    }
    private function createGraphics(w:Number, h:Number):void{
      _bar = new barBg_mc();
      _bar.width = w;
      _bar.height = h;
      addChild(_bar);
      
      _bg = new Sprite();
      addChild(_bg);
      
      _leftContainer = new Sprite();
      _rightContainer = new Sprite();
      _rightContainer.x = w-1;
      _leftContainer.graphics.lineStyle(1, 0xffffff, .4);
      _rightContainer.graphics.lineStyle(1, 0xffffff,.4);
      drawVertLine(_rightContainer, 0);
      drawVertLine(_leftContainer, 0);
      addChild(_leftContainer);
      addChild(_rightContainer);
    }
    private function drawVertLine(s:Sprite, xPos:Number):void{
      s.graphics.moveTo(xPos, 0);
      s.graphics.lineTo(xPos, _h);
    }
    private function setMaxMinWidth(i:Number):Number{
      if(i > MAX_WIDTH || i < MIN_WIDTH){
        i = (i < MAX_WIDTH)? MIN_WIDTH:MAX_WIDTH;
      }
      return i;
    }
  }

}

