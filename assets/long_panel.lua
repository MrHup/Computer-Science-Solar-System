long_panel = Core.class(Sprite)

function long_panel:autoDestroy()
	self:getParent():removeChild(self)
	--EXPERIMENT=0.001
	self = nil
end
function long_panel:stopMovement()
	EXPERIMENT=0
end

function long_panel:init(titlu,mesaj, sateliti,poza,stars)
	local panou = Bitmap.new(Texture.new("Art/panel.png"))
	setSize(panou, 400, application:getContentHeight()-50)
	panou:setPosition(application:getContentWidth()-panou:getWidth()-50,10)
	--rotate = false
	local text = TextWrap.new(titlu, 390, "center")
	text:setFont(conf.smallFont)
	text:setPosition(panou:getX()+5,panou:getY()+25)
	text:setTextColor(0xFFFFFF)
	
	local long_desc = TextWrap.new(mesaj, 300, "center")
	long_desc:setFont(conf.vsmallFont)
	long_desc:setPosition(text:getX()+text:getWidth()/2-long_desc:getWidth()/2+5,text:getY()+text:getHeight()+50)
	long_desc:setTextColor(0xFFFFFF)
	
	local tit = TextWrap.new("Contacts", 300, "center")
	tit:setFont(conf.smallFont)
	tit:setScale(.6)
	tit:setPosition(text:getX()+text:getWidth()/2-tit:getWidth()/2+55,long_desc:getY()+long_desc:getHeight()+80)
	tit:setTextColor(0xFFFFFF)
	
	local k=1
	local last_y = tit:getY()
	local last_height = tit:getHeight()+20
	for i,v in pairs(sateliti) do
		local prof = TextWrap.new(v, 300, "center")
		prof:setFont(conf.vsmallFont)
		prof:setTextColor(0xFFFFFF)
		prof:setPosition(text:getX()+text:getWidth()/2-long_desc:getWidth()/2,last_y+last_height+5)
		self:addChild(prof)
		last_y = prof:getY()
		last_height = prof:getHeight()
		k+=1
	end
	
	local tit2
	local pz = nil
	if poza ~= nil and poza ~= "OPTIONALDESC" then
		pz = Bitmap.new(Texture.new(poza))
		setSize(pz, 200, 200)
		pz:setPosition(text:getX()+text:getWidth()/2-pz:getWidth()/2, last_y + 60)
	else
		-- add important refrences
		tit2 = TextWrap.new("Refrences", 300, "center")
		tit2:setFont(conf.smallFont)
		tit2:setScale(.6)
		tit2:setPosition(text:getX()+text:getWidth()/2-tit:getWidth()/2+55,last_y+80)
		tit2:setTextColor(0xFFFFFF)
		last_y = tit2:getY()
		
		k=1
		local last_height2=tit2:getHeight()+20
		for i,v in pairs(stars) do
			local prof = TextWrap.new(v, 300, "center")
			prof:setFont(conf.vsmallFont)
			prof:setTextColor(0xFFFFFF)
			prof:setPosition(text:getX()+text:getWidth()/2-long_desc:getWidth()/2,last_y+20*k+last_height)
			self:addChild(prof)
			last_y = prof:getY()
			last_height2=prof:getHeight()
			k+=1
		end
	end
	
	--GTween.new(panou,0.2,{x=panou:getX(),y=50},{ease = easing.inSine})
	--GTween.new(text,0.2,{x=rx,y=ry+ panou:getHeight()/2-text:getHeight()/2},{ease = easing.inSine})
	
	
	local exit_b = Button.new(Bitmap.new(Texture.new("Art/exit.png")),Bitmap.new(Texture.new("Art/exit.png")))
	setSize(exit_b, 100, 100)
	exit_b:setPosition(panou:getX()+panou:getWidth()-exit_b:getWidth()-20, panou:getY()+panou:getHeight()-exit_b:getHeight()-4)
	local function f_exit(target,event)
		if target:hitTestPoint(event.x, event.y) then
			self:autoDestroy()
		end
	end
	
	exit_b:addEventListener(Event.MOUSE_DOWN, f_exit,exit_b)
	
	self:addChild(panou)
	self:addChild(text)
	self:addChild(exit_b)
	self:addChild(long_desc)
	if k> 1 then self:addChild(tit) end
	if pz~=nil then
		self:addChild(pz)
	else
		self:addChild(tit2)
	end
	Timer.delayedCall(100, function() self:stopMovement() end)
	--Timer.delayedCall(conf.time_fade_notif, function() self:autoDestroy() end)
end
