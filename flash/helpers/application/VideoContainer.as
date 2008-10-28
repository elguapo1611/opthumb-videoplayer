package helpers.application {
  //flash class dependencies
  import flash.display.Sprite;
  import flash.net.NetConnection;
  import flash.net.NetStream;
  import flash.media.Video;
  import flash.media.SoundTransform;
  import flash.events.Event;
  import flash.events.NetStatusEvent;
  
  import flash.external.ExternalInterface;
  //project specific class dependencies
  import models.VideoContainerModel;
  import models.VideoModel;
  //library items
  
  //lib classes

  public class VideoContainer extends Sprite {
    //Class Constructor
    public function VideoContainer(w:Number, h:Number){
      trace('created video')
      super();
      init(w, h);
    }
    //***********************************
    //Static Functions and Variables
    //***********************************
    public static var ON_BUFFER_UPDATE:String = "onBufferUpdate";
    public static var ON_META:String = "onMeta";
    public static var ON_PROGRESS:String = "onProgress";
    public static var SHOW_PRELOADER:String = "showPreloader";
    public static var HIDE_PRELOADER:String = "hidePreloader";
    //***********************************
    //public methods
    //***********************************
    public function clear():void{
      this.removeEventListener(Event.ENTER_FRAME, frameHandler);
    }
    public function setWidthHeight(w:Number, h:Number):void{
      ExternalInterface.call("console.log", "setting video stage properties");
      setVideoStage(w, h);
    }
    public function load(url:String, startBuffering:Boolean=false):void{
      _url = url;
      if(startBuffering){
        _stream.play(url);
        _hasLoaded = true;
        pause();
        
      }
      this.addEventListener(Event.ENTER_FRAME, frameHandler);
    }
    public function play():void{
      if(!_hasLoaded){
        load(_url, true) 
      }
      _stream.resume();
    }
    public function pause():void{
      _stream.pause();
      
    }
    public function seekPercent(i:Number):void{
      seek(i*_model.totalTime);
    }
    public function seek(second:Number):void{
      dispatchEvent(new Event(SHOW_PRELOADER));
      //calculate number of seconds that have been preloaded
      var cachedSeconds:Number = Math.floor((_model.totalTime - VideoModel.START_AT) * (_stream.bytesLoaded / _stream.bytesTotal)) - 1;
  		//If target already cached, seek to the position	
  		if((second >= VideoModel.START_AT) && (second < (VideoModel.START_AT + cachedSeconds))) {
  			_stream.seek(second);
  		//If FLV contains keyframes inside the onMetaData-Tag, jump to keyframe
  		} else if(VideoModel.IS_KEYFRAMED) {
  			var index = VideoModel.getNearestKeyframeIndex(second);
  			second = VideoModel.TIMES[index];
  			//bufferClip._visible = true;
  			//if(_debugFlag) trace("Info: Get new segment of FLV-file starting at byteposition " + positions[index]);
  			VideoModel.START_AT = second;
  			_stream.play(VideoModel.FILE+'?start='+VideoModel.POSITIONS[index]);
  			
  		//If there are no keyframes and position is not yet cached, just continue playing
  		} else {
  			_stream.seek(_stream.time);
  		}
    }
    //***********************************
    //getters and setters
    //***********************************
    public function get data():VideoContainerModel{
      return _model;
    }
    public function set volume(i:Number):void{
      _st.volume = i
      _stream.soundTransform = _st;
    }
    
    //***********************************
    //Eventhandlers
    //***********************************
    private function frameHandler(e:Event):void{
    	if(_stream.time > 0)
    	{
    		_model.percentPlay = _stream.time / _model.totalTime;
    		_model.percentLoaded = _stream.bytesLoaded / _stream.bytesTotal;
    		_model.seconds = _stream.time
    		dispatchEvent(new Event(ON_PROGRESS));
    	}
    }
    // Streamevent onStatus
  	private function netStatusHandler(e:NetStatusEvent) {
  	  var info:Object = e.info;
  		switch(info.code) {
  			// Buffer is full
  			case 'NetStream.Buffer.Full' :
  			  dispatchEvent(new Event(HIDE_PRELOADER));
  				/*bufferClip._visible = false;
  				          _videoEndFlag = false;
  				          clearInterval(statusID);
  				          statusID = setInterval(videoStatus, 500);*/
  			break;
  			// Buffer is empty
  			case 'NetStream.Buffer.Empty' :
  			  dispatchEvent(new Event(SHOW_PRELOADER));
  			  
  				/*// Show bufferClip if Buffer is empty and end is not reached 
  				          if(!_videoEndFlag) bufferClip._visible = true;
  				          // Move scrubber to the very end of loadbar (otherwise it might be ~1px left of it)
  				          loader.scrub._x = loader.loadbar._width;
  				          // Stop triggering videoStatus
  				          clearInterval(statusID);*/
  			break;
  			// Playback stopped
  			case 'NetStream.Play.Stop' :
  				//bufferClip._visible = false;
  			break;
  			// Playbay started
  			case 'NetStream.Play.Start' :
  			trace('started stream')
  				//_videoEndFlag = false;
  			break;
  			// Video was not found
  			case 'NetStream.Play.StreamNotFound' :
  			  dispatchEvent(new Event(SHOW_PRELOADER));
  				//bufferClip._visible = false;
  				//fileNotFoundClip._visible = true;
  			break;
  			// Buffer flushed	
  			case 'NetStream.Buffer.Flush' :
  				//_videoEndFlag = true;
  			break;
  		}
  	};
    
    
    
    //***********************************
    //private variables
    //***********************************
    private var _model:VideoContainerModel;
    private var _conn:NetConnection;
    private var _stream:NetStream;
    private var _st:SoundTransform;
    private var _video:Video;
    private var _totalLength:Number;
    private var _w:Number;
    private var _h:Number;
    private var _url:String;
    private var _hasLoaded:Boolean;
    //***********************************
    //private methods
    //***********************************
    private function init(w:Number, h:Number):void{
      _url = new String();
      _w = w;
      _h = h;
      _hasLoaded = false;
      createConnection();
      //this is kind of a hack
      var metaListener:Object = new Object();
      metaListener.onMetaData = onMeta;
      _stream.client = metaListener;
      createData();
      createGraphics();
      createListeners();
    }
    private function createData():void{
      _model = new VideoContainerModel();
    }
    private function createGraphics():void{
      _video = new Video();
      _video.alpha=0;
      _video.attachNetStream(_stream);
      //_video.x = 70;
      //_video.y = 0;
      addChild(_video);
      
    }
    private function createListeners():void{
      _stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
    }
    
    //on meta is called in a hack tacular way.  Why not add an event broadcaster to this?
    private function onMeta(info:Object):void {
      _model.width = info.width;
      _model.height = info.height;
      _model.totalTime = info.duration;
      //position the video
      setVideoStage(_w, _h);
      
      //figure out if the meta data contains keyframe info:
      var times:Object = info.keyframes.times;
      var positions:Object = info.keyframes.filepositions;
      // Check if FLV contains keyframes and metadata (needed to scrub through video)
      if(times && positions){
        VideoModel.IS_KEYFRAMED = true;
        VideoModel.TIMES = times;
        VideoModel.POSITIONS = positions;
        //validate start position here
      }
      _video.alpha=1;
      dispatchEvent(new Event(ON_META));
    }
    private function setVideoStage(w:Number, h:Number):void{
      _w = w;
      _h = h;
      switch (VideoModel.VIDEO_FILL_TYPE){
        case "none":
          setVideoPlayerWidth(_model.width, _model.height);
        break;
        case "stretch":
          setVideoPlayerWidth(_w, _h);
        break;
        case "expand":
          var wRatio = _w / _model.width ;
          var hRatio:Number = _h / _model.height;
          if(wRatio > hRatio){
            setVideoPlayerWidth(_model.width*hRatio, _model.height*hRatio);
          }else{
            setVideoPlayerWidth(_model.width*wRatio, _model.height*wRatio);
            
            
          }
        break;
      }
    }
    private function setVideoPlayerWidth(w:Number, h:Number):void{
      _video.width = w;
      _video.height = h;
      _video.x = _w/2 - w/2;
      _video.y = _h/2 - h/2;
    }
    private function createConnection():void{
      _conn = new NetConnection();
      _conn.connect(null);
      _stream = new NetStream(_conn);
      _stream.bufferTime = VideoModel.BUFFER_TIME
      //_stream.addEventListener("onMetaData", onMetaData)
      _st = new SoundTransform();
      _stream.soundTransform = _st;
    }
  }

}

