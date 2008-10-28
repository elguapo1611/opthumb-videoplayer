package controllers {
  //flash class dependencies
  import flash.display.Sprite;
  import flash.display.MovieClip;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.external.ExternalInterface;
  import flash.display.Stage;
  
  import flash.geom.Rectangle;
  //project specific class dependencies
  import models.VideoModel;
  import helpers.bar.BarEvent;
  import views.VideoView;
  import helpers.application.*;
  //import controllers.BarController;
  
  public class Application extends MovieClip {
    
    public function Application(){
      
      stage.addEventListener(Event.RESIZE, activateHandler);
      init();
      
    }
    
    //******************************
    //Event handlers
    //******************************

    private function playHandler(e:MouseEvent):void{
      _controlInterface.showBuffer();
      if(e.type == BarEvent.ON_PAUSE){
        _video.pause();
        _controlInterface.hideBuffer();
      }else{
        try { _bigPlayButton.parent.removeChild(_bigPlayButton); }catch (e:Error){}
        _video.play();
      }
      
    }
    private function bigPlayHandler(e:MouseEvent):void{
      //toggle the playpause button
      _controlInterface.togglePausePlay();
      try { _bigPlayButton.parent.removeChild(_bigPlayButton); }catch (e:Error){}
      
    }
    private function progressHandler(e:Event):void{
      _controlInterface.preloadPercent = (_video.data.percentLoaded * (1-VideoModel.START_AT/_video.data.totalTime)) + VideoModel.START_AT/_video.data.totalTime;
      _controlInterface.playPercent = _video.data.percentPlay;
      _controlInterface.currentTime = _video.data.seconds;
    }
    private function preloadHandler(e:Event):void{
      switch (e.type){
        case VideoContainer.SHOW_PRELOADER:
          _controlInterface.showBuffer();
        break;
        case VideoContainer.HIDE_PRELOADER:
          _controlInterface.hideBuffer();
        break;
      }
    }
    private function timelineHandler(e:Event):void{
      _video.seekPercent(_controlInterface.currentPercent);
    }
    
    private function volumeHandler(e:Event):void{
      _video.volume = _controlInterface.volume;
    }
    private function metaHandler(e:Event):void{
      //once the video's meta data is loaded we can enabled the timeline click/scrubbing and also set the total time of the video
      _controlInterface.addEventListener(BarEvent.TIMELINE_CLICK, timelineHandler);
      _controlInterface.totalTime = _video.data.totalTime;
    }
    private function activateHandler(e:Event){
      //resize all components
      _video.setWidthHeight(stage.stageWidth, stage.stageHeight);
      try{
        _bigPlayButton.x = stage.stageWidth/2-_bigPlayButton.width/2;
        _bigPlayButton.y = stage.stageHeight/2-_bigPlayButton.height/2;
      }catch(e:Error){

      }
      ExternalInterface.call("console.log", "w: "+stage.stageWidth+"    h: "+stage.stageHeight);
      _controlInterface.setSizeAndPosition(stage.stageWidth, stage.stageHeight);
      ExternalInterface.call("console.log", "activation called");
    }
    private function toggleFullScreen(event:Event):void {
      _view.toggleFullScreen();
    }
    
    //*****************************************************************************************
    //******************************
    //private variables
    //******************************
    private var _model:VideoModel;
    private var _view:VideoView;
    private var _video:VideoContainer;
    private var _preloader;
    private var _bigPlayButton:Sprite;
    private var _controlInterface:BarController;
    //******************************
    //private functions
    //******************************
    private function init():void{
      createModel();
      createView();
      createHandlers();
      
      //set the init video
      
      _video.load(VideoModel.FILE, VideoModel.AUTO_BUFFER);
      activateHandler(new Event(""));
    }
    private function createModel():void{
      _model = new VideoModel(root);
      
    }
    private function createView():void{
      _view = new VideoView();
      addChild(_view);
      _view.createStageProperties();
      _video = _view.createVideo();
      _bigPlayButton = _view.createBigPlayButton();
      _controlInterface = _view.createInterface(stage.stageWidth, stage.stageHeight);
    }
    private function createHandlers():void{
      //stage events
      //_view.addEventListener(VideoView.ON_RESIZE, stageHandler);
      
      
      //video stream events
      _video.addEventListener(VideoContainer.ON_META, metaHandler);
      _video.addEventListener(VideoContainer.ON_PROGRESS, progressHandler);
      _video.addEventListener(VideoContainer.SHOW_PRELOADER, preloadHandler);
      _video.addEventListener(VideoContainer.HIDE_PRELOADER, preloadHandler);
      
      //interface events
      _bigPlayButton.addEventListener(MouseEvent.CLICK, bigPlayHandler);
      _controlInterface.addEventListener(BarEvent.ON_PLAY, playHandler);
      _controlInterface.addEventListener(BarEvent.ON_PAUSE, playHandler);
      _controlInterface.addEventListener(BarEvent.ON_CHANGE, volumeHandler);
      _controlInterface.addEventListener(BarEvent.ON_MAXIMIZE_TOGGLE, toggleFullScreen);
    }
    private function removeAllContent():void{
      _view.clearView();
    }
    private function removeThis(s):void{
      s.parent.removeChild(s);
      s = null;
    }
    
  }
}