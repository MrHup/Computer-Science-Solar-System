--setting up some configurations
application:setOrientation(conf.orientation)
application:setLogicalDimensions(conf.width, conf.height)
application:setScaleMode(conf.scaleMode)
application:setFps(conf.fps)
application:setKeepAwake(conf.keepAwake)
application:setBackgroundColor(0x152235)

application:set("cursor","blank") 
if conf.debug == false then
	application:setFullScreen(true)
end
local bg = Bitmap.new(Texture.new("Art/bg.png"))
setSize(bg,application:getContentWidth(),application:getContentHeight())
stage:addChild(bg)

local function onEnterFrame()
	
end

--stage:addEventListener(Event.ENTER_FRAME, onEnterFrame) 


sceneManager = SceneManager.new({
	["game"] = game,
	["menu"] = menu,
	["zoomIn"] = zoomIn
})



stage:addChild(sceneManager)
sceneManager:changeScene("game", 1, conf.transition, conf.easing)
