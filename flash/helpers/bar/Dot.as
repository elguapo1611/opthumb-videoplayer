package helpers.bar {
  //flash class dependencies

  //project specific class dependencies
  import helpers.application.Button;
  //library items
  import volThumb;
  //lib classes

  public class Dot extends Button {
    //Class Constructor
    public function Dot(w:Number = 7, h:Number = 7){
      super();
      init(w, h);
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

    //***********************************
    //private variables
    //***********************************


    //***********************************
    //private methods
    //***********************************
    private function init(w, h):void{
      createGraphics(w, h);
    }
    private function createGraphics(w, h):void{
      var dot:volThumb = new volThumb()
      dot.width = dot.height = w;
      addChild(dot);
      
      this.graphics.beginFill(0xff0000,0)
      this.graphics.drawRect(-w/2,-h/2, w,h)
    }

  }

}

