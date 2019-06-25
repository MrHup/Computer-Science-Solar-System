character = Core.class(Sprite)

local speedX = 0
local speedY = 0

function character:init(i,j) -- to be added other shit as params
	local char = Bitmap.new(Texture.new("Art/char.png"))
	
	--char:setAnchorPoint(.5)
	
	
	
	local body = lume:createBody{type = b2.DYNAMIC_BODY}
	body:setPosition(char:getX(), char:getY())
	body:setAngle(char:getRotation() * math.pi/180)
	local poly = b2.PolygonShape.new()
	poly:setAsBox(char:getWidth()/2, char:getHeight()/2)
	local fixture = body:createFixture{shape = poly, density = 1.0, 
	friction = 0.1, restitution = 0}
	
	body:setAngularVelocity(0)
	body:setFixedRotation(true)
	body:setSleepingAllowed(true)
	
	char.body = body
	char.body.type = "character"	
	
	self.corp = body
	
	
	self:setPosition(i,j)
	self:addChild(char)
	
	--- controls for char
	
	self:addEventListener(Event.MOUSE_WHEEL, function(e)
		if e.wheel > 0 then
			zooming = true
			unzooming = false
			--print("Zoom in")
		elseif e.wheel < 0 then
			unzooming = true
			zooming = false
			--print("Zoom out")
		else
			print("Woof")
			zooming = false
			unzooming=  false
		end
	end)
	
	self:addEventListener(Event.KEY_DOWN, function(event)
		if event.keyCode == CONTROLS.left then
			--char:play()
			speedX = speedX - conf.viteza
		elseif event.keyCode == CONTROLS.forward then
			speedY = speedY + conf.viteza
			--char:gotoAndPlay(21)
			--char:setGotoAction(40, 21)
		elseif event.keyCode == CONTROLS.right then
			speedX = speedX + conf.viteza
			--char:play()
		elseif event.keyCode == CONTROLS.backwards then
			speedY = speedY - conf.viteza
			--char:gotoAndPlay(1)
			--char:setGotoAction(20, 1)
		elseif event.keyCode == CONTROLS.plus then
			zooming = true
		elseif event.keyCode == CONTROLS.minus then
			unzooming = true
		elseif event.keyCode == CONTROLS.reset then
			reset = true
		elseif event.keyCode == CONTROLS.exper then
			--EXPERIMENT -=.001
			conf.EXP2+=1
			print(EXPERIMENT)
		end
		end)
		
		self:addEventListener(Event.KEY_UP, function(event)
			if event.keyCode == CONTROLS.left then
				speedX = speedX + conf.viteza
			elseif event.keyCode == CONTROLS.forward then
				speedY = speedY - conf.viteza
			elseif event.keyCode == CONTROLS.right then
				speedX = speedX - conf.viteza
			elseif event.keyCode == CONTROLS.backwards then
				speedY = speedY + conf.viteza
			elseif event.keyCode == CONTROLS.plus then
				print("+")
				zooming = false
			elseif event.keyCode == CONTROLS.minus then
				unzooming = false
				--conf.EXP2+=0.1
				print("-")
			end
			--if speedX ==0 and speedY == 0 then char:stop() end
	end)
	
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

function character:onEnterFrame()
	local heroX,heroY = self:getPosition()
	self.corp:setPosition(heroX+speedX,heroY-speedY)
	self:setPosition(heroX+speedX,heroY-speedY)
	
	--print(application:getContentWidth()/2 .. "    " .. application:getContentHeight()/2 )
end

