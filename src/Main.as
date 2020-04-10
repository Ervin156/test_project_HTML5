package
{
	import flash.display.ColorCorrection;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.display.StageDisplayState;
	import flash.display.StageAlign;
	
	
		/**
	 * ...
	 * @author Dmitriy_Listov
	 */
	
	public class Main extends Sprite 
	{
		public function Main() 
		{
			if (this.stage) 
			{
			
			this.init();
			}
			else 
			{
				this.addEventListener(Event.ADDED_TO_STAGE, this.init);
			}
			
		}

		private	var square:Sprite = new Sprite();
		
		private	var changeColorMouseDown:ColorTransform = new ColorTransform();
		private	var changeColorMouseUp:ColorTransform = new ColorTransform();
		
		private var soundChanelTouchDown:SoundChannel = new SoundChannel();
		private	var soundTouchDown:Sound = new Sound(new URLRequest("sounds/touchDown.mp3"));
		private var soundTouchUp:Sound = new Sound(new URLRequest("sounds/touchUp.mp3"));
		
		private function SoundBg():void {
			var chanel:SoundChannel;
			var transform:SoundTransform = new SoundTransform(0.1, 0);
			var bgMusic:Sound = new Sound(new URLRequest("sounds/music.mp3"));
            var channel:SoundChannel;
            channel = bgMusic.play();
            channel.soundTransform = transform;
        }
		
		private function createSquare():void{
			square.graphics.lineStyle(1, 0x0099CC, 1);
			square.graphics.beginFill(0x0099CC , 1.0);
			square.graphics.drawRect((stage.stageWidth / 2) - 50, (stage.stageHeight / 2) - 50, 100, 100 );
			addChild(square);
		}
		
		private function touchEvents():void{
			changeColorMouseDown.color = 0xFFE600;
			changeColorMouseUp.color = 0x0099CC;
			
			function onClick (e:MouseEvent):void {
			
				if (e.type == "mouseDown") {
					e.target.transform.colorTransform = changeColorMouseDown;
					soundChanelTouchDown = soundTouchDown.play();	

				};
				if(e.type == "mouseUp"){
					e.target.transform.colorTransform = changeColorMouseUp;
					soundChanelTouchDown.stop();
				    soundTouchUp.play();
				};
			}

			function dragAndDrop(e:MouseEvent):void {
				if (e.type == "mouseDown")	{
					square.startDrag();

				}
				if (e.type == "mouseUp") {	
					square.stopDrag();
				}
			}
			square.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
			square.addEventListener(MouseEvent.MOUSE_UP, onClick);
			square.addEventListener(MouseEvent.MOUSE_DOWN, dragAndDrop);
			square.addEventListener(MouseEvent.MOUSE_UP, dragAndDrop);
		
		}
		
		
		
		private function init(e:Event = null):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, this.init);
			// entry point			
			createSquare();
			SoundBg();
			touchEvents();		
			
		}
	}
		
}