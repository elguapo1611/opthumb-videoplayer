package helpers.bar {
  //flash class dependencies
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  //project specific class dependencies
  import helpers.bar.LittleSlider;
  //Library items
  import speaker;
  //lib classes

  public class Volume extends Sprite {
    
  //Class Constructor
    public function Volume(w , h){
      super();
      init(w, h);
    }
    //***********************************
    //Global variables
    //***********************************
    public static var ON_CHANGE:String = "onChange";
    //***********************************
    //public methods
    //***********************************
    
    public function toggleMute():void{
      this.mute = !this.mute;
      dispatchEvent(new Event(ON_CHANGE, true));
      
    }
    //***********************************
    //getters and setters
    //***********************************
    public function get volume():Number{
      if(_isMuted)
        return 0;
      else
        return _slider.percent;
    }
    public function set volume(i:Number):void{
      _slider.percent = i;
      dispatchEvent(new Event(ON_CHANGE, true));
    }
    
    public function set mute(b:Boolean):void{
      
      _isMuted = b;
      setVolumeGraphics();
      if(_isMuted){
        _sp.gotoAndStop(4);
      }
      
    }
    public function get mute():Boolean{
      return _isMuted;
    }
    
    //**********************************************************************************
    //private methods and variables 
    //**********************************************************************************
    
    //***********************************
    //Eventhandlers
    //***********************************
    private function volumeHandler(e:Event):void{
      setVolumeGraphics();
      dispatchEvent(new Event(ON_CHANGE, true));
      this.mute = false;
    }
    private function speakerHandler(e:MouseEvent):void{
      toggleMute();
      
    }
    //***********************************
    //private variables
    //***********************************
    var _sp:speaker;
    var _slider:LittleSlider;
    var _isMuted:Boolean;
    //***********************************
    //private methods
    //***********************************
    private function init(w, h):void{
      
      //this.graphics.lineStyle(1,0xffff00)
      //this.graphics.drawRect(0,0,w,h)
      
      createVisuals(w, h);
      createHandlers();
      setVolumeGraphics();
    }
    private function createVisuals(w, h):void{
      createSpeaker();
      createSlider(w, h);
    }
    private function createSpeaker():void{
      _sp = new speaker();
      _sp.buttonMode = true;
      addChild(_sp);
    }
    private function createSlider(w, h):void{
      _slider = new LittleSlider(w-(_sp.width)+10, h);
      _slider.x= _sp.width-10;
      _slider.addEventListener(LittleSlider.ON_VOLUME_CHANGE, volumeHandler);
      addChild(_slider);
    }
    
    
    private function createHandlers():void{
      _sp.addEventListener(MouseEvent.CLICK, speakerHandler);
    }
    private function setVolumeGraphics():void{
      var v:Number = _slider.percent;
      if(v==0){
        _sp.gotoAndStop(4);
      }else{
        _sp.gotoAndStop(Math.ceil(v*3));
      }
      
    }
    
  }

}

