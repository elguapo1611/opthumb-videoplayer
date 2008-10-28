package helpers.bar {
  //flash class dependencies
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.events.Event;
  import flash.geom.Rectangle;
  //project specific class dependencies
  import helpers.bar.Dot;
  //Flash library items
  import volThumb;
  //lib classes

  public class LittleSlider extends Sprite {
      //Class Constructor
      public function LittleSlider(w, h){
       
        super();
        init(w, h);
      }
      //***********************************
      //Static Functions and Variables
      //***********************************
      public static var ON_VOLUME_CHANGE:String = "onVolumeChange";

      //***********************************
      //public methods
      //***********************************


      //***********************************
      //getters and setters
      //***********************************
      public function get percent():Number{
        return (_slider.x/_w)
      }
      public function set percent(i:Number):void{
        if (i>=0 && i<=1 ) 
          _slider.x = percent * _w
        else if(i<0)
          _slider.x = 0;
        else {
          _slider.x = _w;
        }
      }

      //***********************************
      //Eventhandlers
      //***********************************
      private function mouseHandler(e:MouseEvent):void{
        switch(e.type){
          case MouseEvent.MOUSE_DOWN:
            _slider.startDrag(true, new Rectangle(0,_h/2, _w,0));
            this.addEventListener(Event.ENTER_FRAME, update);
            stage.addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
          break;
          case MouseEvent.MOUSE_UP:
            stopDragging();
            stage.removeEventListener(MouseEvent.MOUSE_UP, mouseHandler);
          break; 
        }
      }

      //***********************************
      //private variables
      //***********************************

      private var _w:Number;
      private var _h:Number;
      private var _slider:Sprite;
      private var _line:Sprite;
      //***********************************
      //private methods
      //***********************************
     private function init(w, h):void{
       _w = w;
       _h = h;
       createGraphics();
       createHandlers();
     }
     private function createGraphics():void{
       createLine();
       createSlider();
     }
     private function createLine():void{
       _line = new Sprite();
       _line.graphics.beginFill(0xffffff,0);
       _line.graphics.drawRect(0,0, _w, _h);
       _line.graphics.moveTo(0, _h/2)
       _line.graphics.lineStyle(1, 0xffffff);
       _line.graphics.lineTo(_w, _h/2);
       addChild(_line);
     }
     private function createSlider():void{
        _slider = new Dot();
        _slider.buttonMode = true;
        _slider.y=_h/2;
        _slider.x=_w;
        addChild(_slider);
     }
     private function createHandlers():void{
       _line.addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
       _slider.addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
       
     }
     
     private function update(e:Event):void{
        dispatchEvent(new Event(ON_VOLUME_CHANGE));
     }
     private function stopDragging():void{
       _slider.stopDrag();
       this.removeEventListener(Event.ENTER_FRAME, update);
     }
    
  }

}


