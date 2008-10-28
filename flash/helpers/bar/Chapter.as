package helpers.bar {
  //flash class dependencies

  //project specific class dependencies
  import helpers.bar.Dot;
  //library items
  
  //lib classes

  public class Chapter extends Dot {
    //Class Constructor
    public function Chapter(w:Number, h:Number){
      super(w,h);
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
    public function get percent():Number{
      return _percent
    }
    public function set percent(i:Number):void{
      _percent = i;
    }

    //***********************************
    //Eventhandlers
    //***********************************

    //***********************************
    //private variables
    //***********************************

    private var _percent:Number;
    //***********************************
    //private methods
    //***********************************
    private function init():void{
      _percent = new Number();
    }

  }

}

