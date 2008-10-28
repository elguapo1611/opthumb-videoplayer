package helpers.application {
  //flash class dependencies
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.display.MovieClip;
  //project specific class dependencies
  import helpers.application.GlobalStyles
  import helpers.application.Button;
  //library items
  import bigPlay;
  //lib classes

  public class BigPlayButton extends Button {
    //Class Constructor
    public function BigPlayButton(){
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

    //***********************************
    //private variables
    //***********************************
    private var _btn:bigPlay;

    //***********************************
    //private methods
    //***********************************
    private function init():void{
      createGraphics();
    }
    private function createGraphics():void{
      var bg:Sprite = new Sprite();
      bg.graphics.beginFill(0xff0000, .2);
      addChild(bg);
      
      _btn = new bigPlay();
      this.libItem = _btn as MovieClip;
      addChild(_btn)
    }


  }

}

