package helpers.bar {

	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import helpers.application.GlobalStyles;
	
	public class TF extends Sprite {
		var _myTextArea:TextField;
		
		public function TF(maxW:Number = 0){
			super();
			init(maxW);
		}
		private function init(maxW:Number):void{
			
			_myTextArea = new TextField(); 
			_myTextArea.autoSize = "left";
			_myTextArea.embedFonts = true;
			_myTextArea.antiAliasType = "advanced"
			_myTextArea.multiline=true;
			_myTextArea.defaultTextFormat = GlobalStyles.TEXT_FORMAT;
			_myTextArea.styleSheet = GlobalStyles.CSS;
			_myTextArea.wordWrap = true;
			_myTextArea.htmlText = ""; 
			_myTextArea.width = maxW;
			
			//_myTextArea.border = true;
			addChild(_myTextArea);
		}
		public function set txt(str:String):void{
			_myTextArea.htmlText = str;
		}
		public function get txt():String{
			return _myTextArea.htmlText;
		}
		public function get tf():TextField{
			return _myTextArea;
		}
	}

}

