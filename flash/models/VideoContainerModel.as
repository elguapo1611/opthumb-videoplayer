package models {
  //flash class dependencies

  //project specific class dependencies

  //library items
  
  //lib classes

  public class VideoContainerModel extends Object {
    //Class Constructor
    public function VideoContainerModel(){
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

    public function get totalTime():Number{
      return _totalTime
    }
    public function set totalTime(i:Number):void{
      _totalTime = i;
    }
    
    public function get title():String{
      return _title
    }
    public function set title(i:String):void{
      _title = i;
    }
    
    public function get percentLoaded():Number{
      return _percentLoaded
    }
    public function set percentLoaded(i:Number):void{
      _percentLoaded = i;
    }
    public function get percentPlay():Number{
      return _percentPlay
    }
    public function set percentPlay(i:Number):void{
      _percentPlay = i;
    }
    
    public function get width():Number{
      return _width
    }
    public function set width(i:Number):void{
      _width = i;
    }
    public function get height():Number{
      return _height
    }
    public function set height(i:Number):void{
      _height = i;
    }
    public function get seconds():Number{
      return _seconds
    }
    public function set seconds(i:Number):void{
      _seconds = i;
    }
    
    //***********************************
    //Eventhandlers
    //***********************************

    //***********************************
    //private variables
    //***********************************
    private var _totalTime:Number;
    private var _title:String;
    private var _percentLoaded:Number;
    private var _width:Number;
    private var _height:Number;
    private var _percentPlay:Number;
    private var _seconds:Number;
    //***********************************
    //private methods
    //***********************************
    private function init():void{
      _totalTime = new Number();
      _title = new String();
      _percentLoaded = new Number();
      _width = new Number();
      _height = new Number();
      _percentPlay = new Number();
      _seconds = new Number();
    }

  }

}

