package views {
  //flash class dependencies
  import flash.display.Sprite;
  import flash.events.Event;
  //project specific class dependencies
  import helpers.application.*
  import controllers.BarController;

  //Library items
  
  //lib classes
  
  public class VideoView extends Sprite {
    
    //Class Constructor
      public function VideoView(){
        super();
        init();
      }
      //***********************************
      //Class constants 
      //***********************************
      public static var ON_RESIZE:String = "onResize";
      //***********************************
      //public methods
      //***********************************
      public function createStageProperties():void{
        stage.scaleMode = "noScale";
        stage.align = "topLeft";
        var s:Sprite = new Sprite();
        stage.addChild(s)
        s.addEventListener(Event.RESIZE, stageHandler);
        //s.graphics.lineStyle(1,0xff0000)
        //s.graphics.drawRect(0,0, stage.stageWidth, stage.stageHeight);
      }
      public function createVideo():VideoContainer {
        var s:VideoContainer = new VideoContainer(stage.stageWidth, stage.stageHeight);
        _arrParts.push(s);
        addChild(s);
        return s;
      }
      public function createBigPlayButton():Sprite {
        var pb:BigPlayButton = new BigPlayButton();
        _arrParts.push(pb);
        pb.x = (stage.stageWidth / 2) - (pb.width / 2)
        pb.y = (stage.stageHeight/2 ) - (pb.height / 2);
        addChild(pb);
        return pb as Sprite;
      }
      public function createInterface(w:Number, h:Number):BarController{
        var bc:BarController = new BarController(w, h);
        addChild(bc)
        return bc;
      }
      //creates player control container.  Later on we should add the ability to dynamically specify the controls.
      
      
      public function clearView():void{
        var numChildren:int = _arrParts.length;
        var curChild;
        for (var i:int = 0; i < numChildren; i++){
          curChild = _arrParts[i];
          removeChild(curChild);
          curChild = null;
        }
        
      }
      public function toggleFullScreen():void{
        //var screenRectangle:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight); 
        //ExternalInterface.call("console.log", stage.displayState);
          switch(stage.displayState) {
            case "normal":
                stage.displayState = "fullScreen";

                break;
            case "fullScreen":
            default:
                stage.displayState = "normal";
                //ExternalInterface.call("console.log", stage.stageWidth);
                break;
          }
          
      }

      //***********************************
      //getters and setters
      //***********************************
    
    
      //***********************************
      //Eventhandlers
      //***********************************
      private function stageHandler(e:Event):void{
        dispatchEvent(new Event(ON_RESIZE));
      }
      //***********************************
      //private variables
      //***********************************
      
      private var _arrParts:Array;
      //***********************************
    //private methods
    //***********************************
    private function init():void{

      _arrParts = new Array();
    }
    
  }

}

