package helpers.bar {
  //flash class dependencies
  import flash.display.Sprite;
  import flash.text.TextField;
  //project specific class dependencies
  import models.VideoModel;
  import helpers.bar.TF;
  //library items
  
  //lib classes

  public class TimeCode extends Sprite {
    //Class Constructor
    public function TimeCode(w:Number, h:Number){
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
    public function set currentTime(seconds:Number):void{
     _tf.text = VideoModel.videoTimeConvert(seconds);
    }
    public function set totalTime(seconds:Number):void{
      _totalTime.text = VideoModel.videoTimeConvert(seconds);
    }

    //***********************************
    //Eventhandlers
    //***********************************

    //***********************************
    //private variables
    //***********************************

    private var _tf:TextField;
    private var _totalTime:TextField;
    //***********************************
    //private methods
    //***********************************
    private function init(w:Number, h:Number):void{
      createGraphics(w,h);
    }
    private function createGraphics(w, h):void{
      var tf:TF = new TF(w);
      _tf = tf.tf;
      _tf.text = "00:00:00"
      tf.y= h/2 - tf.tf.textHeight/2-2;
      addChild(tf)
      var temp:TF = new TF(5);
      temp.tf.htmlText = "/"
      temp.x = _tf.width-1;
      addChild(temp)
      var ttf:TF = new TF(w);
      _totalTime = ttf.tf;
      _totalTime.text = "00:00:00"
      temp.y= h/2 - ttf.tf.textHeight/2-2;
      ttf.y= h/2 - ttf.tf.textHeight/2-2;
      ttf.x=temp.width+temp.x+1;
      addChild(ttf)
    }

  }

}

