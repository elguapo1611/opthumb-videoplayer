package models {
  //flash class dependencies
  import flash.display.LoaderInfo;
  import flash.external.ExternalInterface;
  //project specific class dependencies
  
  //library items
  
  //lib classes

  public class VideoModel extends Object {
    //Class Constructor
    public function VideoModel(root:Object){
      super();
      init(root);
    }
    //***********************************
    //Static Functions and Variables
    //***********************************
    
    
    /*    
        * file=[URL] defines which video to show
        * &autoStart lets the video start immediately
        * &bufferTime=[number] changes the buffer time (default is 3 seconds)
        * &clickTag=[URL] defines a target to call after video ended
        * &credit=[(URL encoded) text] to show a credit like your company name in the context menu
        * &link=[URL] defines a website to open when user clicks into the video
        * &linkTarget=[blank,parent,self,top] defines the target of the website above (default: blank)
        * &loop=true lets your video replay itself instead of ending (default: false)
        * &previewImage=[URL] sets an backgroundimage as preview before playback starts
        * &scrubbing=false use that, if you’re webserver has no enabled module for fake streaming (default: true)
        * &seeking=false disallows the user to seek inside the video (default: true)
        * &secondsToHide=[number] defines amount of seconds that the controlbar waits before hiding (0 means never, default is 5)
        * &startAt=[number] defines the the second where the playback will start (default:0)
    */
    //define default values 
    public static var DISPLAY_HOURS:Boolean = true;
    public static var FILE:String = "default.flv"
    public static var AUTO_START:Boolean = false;
    public static var AUTO_BUFFER:Boolean = false;
    public static var BUFFER_TIME:Number = 5;
    public static var CLICK_TAG:String = "#";
    public static var CREDIT:String = "";
    public static var LINK:String = "";
    public static var LINK_TARGET:String = "self";
    public static var LOOP:Boolean = false;
    public static var PREVIEW_IMAGE:String = "";
    public static var SCRUBBING:Boolean = true;
    public static var SEEKING:Boolean = true;
    public static var SECONDS_TO_HIDE:Number = 5;
    public static var START_AT:Number = 0;
    public static var IS_KEYFRAMED:Boolean = false;
    public static var TIMES:Object;
    public static var POSITIONS:Object;
    //acceptable values: expand, none, stretch
    public static var VIDEO_FILL_TYPE:String = "expand";
    
    public static function videoTimeConvert(myTime:Number):String {
    	var tempNum = myTime;
    	
      var hours:Number = (DISPLAY_HOURS) ? Math.floor(tempNum / (60*60)): undefined;
      tempNum = tempNum - hours * 60 * 60;
      var minutes:Number = Math.floor((tempNum) / 60);
      var seconds:Number = Math.floor(tempNum - (minutes * 60));
      
      var strHours = "";
      if(DISPLAY_HOURS){
        strHours = addLeadingZero(hours);
      }
    	var currentTimeConverted:String = strHours + ":" + addLeadingZero(minutes) + ":"+addLeadingZero(seconds);
    	return currentTimeConverted;
    }
    public static function getNearestKeyframeIndex(second:Number) {
    		var index1 = 0;
    		var index2 = 0;
    		// Iterate through array to find keyframes before and after scrubber second
    		for(var i=0; i<TIMES.length; i++) {
    			if(TIMES[i] < second) {
    				index1 = i;
    			} else {
    				index2 = i;
    				break;
    			}
    		}
    		// Calculate nearest keyframe
    		if((second - POSITIONS[index1]) < (POSITIONS[index2] - second)) {
    			return index1;
    		} else {
    			return index2;
    		}
    	}
    

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
    private function init(root:Object):void{
      createFlashVars(root)
    }
    private function createFlashVars(root:Object):void{
      var flashVars:Object = LoaderInfo(root.loaderInfo).parameters;
      //figure out if any of the flash vars should override the default player settings
      DISPLAY_HOURS   = (flashVars.displayHours) ? flashVars.displayHours : DISPLAY_HOURS;
      FILE            = (flashVars.file) ? flashVars.file: FILE;
      AUTO_START      = (flashVars.autoStart) ? flashVars.autoStart: AUTO_START;
      AUTO_BUFFER     = (flashVars.autoBuffer) ? flashVars.autoBuffer: AUTO_BUFFER;
      BUFFER_TIME     = (flashVars.bufferTime) ? flashVars.bufferTime: BUFFER_TIME;
      CLICK_TAG       = (flashVars.clickTag) ? flashVars.clickTag: CLICK_TAG;
      CREDIT          = (flashVars.credit) ? flashVars.credit: CREDIT;
      LINK            = (flashVars.link) ? flashVars.link: LINK;
      LINK_TARGET     = (flashVars.linkTarget) ? flashVars.linkTarget: LINK_TARGET;
      LOOP            = (flashVars.loop) ? flashVars.loop: LOOP;
      PREVIEW_IMAGE   = (flashVars.previewImage) ? flashVars.previewImage: PREVIEW_IMAGE;
      SCRUBBING       = (flashVars.scrubbing) ? flashVars.scrubbing: SCRUBBING;
      SEEKING         = (flashVars.seeking) ? flashVars.seeking: SEEKING;
      SECONDS_TO_HIDE = (flashVars.secondsToHide) ? flashVars.secondsToHide: SECONDS_TO_HIDE;
      START_AT        = (flashVars.startAt) ? flashVars.startAt: START_AT;
      VIDEO_FILL_TYPE = (flashVars.videoFillType) ? flashVars.videoFillType : VIDEO_FILL_TYPE;
    }
    private static function addLeadingZero(i:Number):String {
      return (i<10)?"0"+i.toString() : i.toString();
    }


  }
  

}

