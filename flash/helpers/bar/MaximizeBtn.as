package helpers.bar {
  //flash class dependencies
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  //project specific class dependencies
  import helpers.application.Button;
  import helpers.bar.BarEvent;
  //library items
  import fullscreen_mc;
  //lib classes

  public class MaximizeBtn extends Button {
    //Class Constructor
    public function MaximizeBtn(){
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


    //***********************************
    //Eventhandlers
    //***********************************
    private function mouseHandler(e:MouseEvent):void{

      dispatchEvent(new Event(BarEvent.ON_MAXIMIZE_TOGGLE, true));
    }
    //***********************************
    //private variables
    //***********************************


    //***********************************
    //private methods
    //***********************************
    private function init():void{
      createGraphics();
    }
    private function createGraphics():void{
      this.buttonMode = true;
      addChild(new fullscreen_mc());
      
      this.addEventListener(MouseEvent.CLICK, mouseHandler);
    }

  }

}

