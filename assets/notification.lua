notification = Core.class(Sprite)

function notification:autoDestroy()
	self:getParent():removeChild(self)
	self = nil
	rotate = true
end

function notification:stopMovement()
	EXPERIMENT=0
end

function notification:init(mesaj)
	local panou = Bitmap.new(Texture.new("Art/panel.png"))
	panou:setScale(2,2)
	--rotate = false
	local text = TextWrap.new(mesaj, 250, "center")
	text:setFont(conf.vsmallFont)
	setSize(panou, text:getWidth()+80, text:getHeight()+10)
	text:setPosition(panou:getX()+panou:getWidth()/2-text:getWidth()/2, -200)
	text:setTextColor(0xFFFFFF)
	
	local rx = panou:getX()+panou:getWidth()/2-text:getWidth()/2
	local ry = 50
	
	GTween.new(panou,0.2,{x=panou:getX(),y=50},{ease = easing.inSine})
	GTween.new(text,0.2,{x=rx,y=ry+ panou:getHeight()/2-text:getHeight()/2},{ease = easing.inSine})
	
	
	
	self:addChild(panou)
	self:addChild(text)
	Timer.delayedCall(100, function() self:stopMovement() end)
	Timer.delayedCall(conf.time_fade_notif, function() self:autoDestroy() end)
end
