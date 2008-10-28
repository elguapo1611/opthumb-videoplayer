package helpers.application {
  //flash class dependencies
  import flash.events.MouseEvent;
  import flash.display.Sprite;
  import flash.display.MovieClip;
  //project specific class dependencies

  //library items
  
  //lib classes

  public class Button extends Sprite {
    //Class Constructor
    public function Button(){
      super();
      init();
    }
    //***********************************
    //Static Functions and Variables
    //***********************************


    //***********************************
    //public methods
    //***********************************
    
    
    //***********************************
    //getters and setters
    //***********************************
    public function get libItem():Sprite{
      return _libItem;
    }
    public function set libItem(s:Sprite):void{
      _libItem = s;
    }

    //***********************************
    //Eventhandlers
    //***********************************
    private function mouseEvent(e:MouseEvent):void{
      switch (e.type){
        case MouseEvent.ROLL_OVER:
        _libItem.gotoAndStop(2);
          this.filters=[GlobalStyles.GLOW_FILTER]
        break;
        case MouseEvent.ROLL_OUT:
        _libItem.gotoAndStop(1);
          this.filters=[];
        break;
      }
    }
    //***********************************
    //private variables
    //***********************************
    private var _libItem;

    //***********************************
    //private methods
    //***********************************
    private function init():void{
      _libItem = new MovieClip();
      this.buttonMode = true;
      this.addEventListener(MouseEvent.ROLL_OVER, mouseEvent);
      this.addEventListener(MouseEvent.ROLL_OUT, mouseEvent);
    }

  }

}

