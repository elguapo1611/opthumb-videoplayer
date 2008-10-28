package helpers.application {
  //flash class dependencies
  import flash.display.Sprite;
  import flash.text.*;
  import flash.filters.DropShadowFilter;
  import flash.filters.GlowFilter;
  //project specific class dependencies

  //library items
  
  //lib classes

  public class GlobalStyles extends Object {
    //Class Constructor
    public function GlobalStyles(){
      super();
      init();
    }
    //***********************************
    //Static Functions and Variables
    //***********************************
		public static const DROP_SHADOW:DropShadowFilter = new DropShadowFilter(1, 45, 0x000000, 1, 3, 3, 1, 1, false, false, false);
		public static const GLOW_FILTER:GlowFilter = new GlowFilter(BOX_FILL_COLOR, .9, 6, 6, 1, 1, false)
		public static const STROKE_COLOR:int = 0xb4b4b4;
	  public static const BOX_FILL_COLOR:int = 0xb4b4b4;
		public static var STYLE:StyleSheet = new StyleSheet();
	  public static var FONT_FACE:String = "Helvetica";
		public static var TF:TextFormat = new TextFormat(FONT_FACE, 10, 0xFFFFFF);
		public static var BAR_TF:TextFormat = new TextFormat(FONT_FACE, 20, 0x211913, true);
		public static var ERROR_TF:TextFormat = new TextFormat(FONT_FACE, 10, 0x211913, false, true);
		public static var CANDIDATE_TF:TextFormat = new TextFormat(FONT_FACE, 14, 0x211913, true, null, null, null, null, "right");
		public static var SRC_TF:TextFormat = new TextFormat(FONT_FACE, 10, 0x211913, false, true, null, null, null, "right");
		
		//font:String = null, size:Object = null, color:Object = null, bold:Object = null, italic:Object = null, underline:Object = null, url:String = null, target:String = null, align:String = null, leftMargin:Object = null, rightMargin:Object = null, indent:Object = null, leading:Object = nul
		
		public static function get TEXT_FORMAT():TextFormat{
			//set the default styles once
			if(TF.kerning == null){
				TF.kerning = true;
			}
			return TF;
		}
		public static function get CSS():StyleSheet{
			if(STYLE.getStyle("h2").color == undefined){
				setStyles();
			}
			return STYLE;
		}
		private static function setStyles():void{
			var titleStyle:Object = new Object();
			titleStyle.fontSize = 20;
			titleStyle.color = "#333333";

			titleStyle.fontWeight = "bold";
			
			var heading:Object = new Object();
			heading.fontSize = 14;
			
			var dateStyle:Object = new Object();
			dateStyle.fontSize = 10;
			dateStyle.color = "#666666";
			
			var linkStyle:Object = new Object();
			linkStyle.color = "#33b4dd";
			
			
			STYLE.setStyle(".title", titleStyle);
			STYLE.setStyle("a", linkStyle);
			STYLE.setStyle("h2", heading);
			STYLE.setStyle(".date", dateStyle);
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
    private function init():void{

    }

  }

}

