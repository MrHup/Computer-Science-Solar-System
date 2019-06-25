game = gideros.class(Sprite)
require "box2d"

application:setOrientation(conf.orientation)
-------------------------------
local MX = application:getContentWidth()
local MY = application:getContentHeight()
function setSize(imagine,newWidth, newHeight)
  imagine:setScale(1, 1)
  local originalWidth = imagine:getWidth()
  local originalHeight = imagine:getHeight()
  imagine:setScale(newWidth / originalWidth, newHeight / originalHeight)
end
function round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

-------------------------------------------------------
---------------------EFFECTS---------------------------
-------------------------------------------------------

function game:shakeScreen()
	local screenW = application:getContentWidth()
	local screenH = application:getContentHeight()
	local offsetX = 0;
	local offsetY = 0;
	self:setPosition(offsetX-10,offsetY-10)
	GTween.new(self, 0.25, {x = offsetX,y = offsetY}, {delay = 0, ease = easing.outBounce })
end

-------------------------------------------------------
---------------------OBJECTS---------------------------
-------------------------------------------------------

function game:wall(x, y, width, height)
	local wall = Shape.new()
	wall:beginPath()
	wall:moveTo(-width/2,-height/2)
	wall:lineTo(width/2, -height/2)
	wall:lineTo(width/2, height/2)
	wall:lineTo(-width/2, height/2)
	wall:closePath()
	wall:endPath()
	wall:setPosition(x,y)
	
	--create box2d physical object
	local body = self.world:createBody{type = b2.STATIC_BODY}
	body:setPosition(wall:getX(), wall:getY())
	body:setAngle(wall:getRotation() * math.pi/180)
	local poly = b2.PolygonShape.new()
	poly:setAsBox(wall:getWidth()/2, wall:getHeight()/2)
	local fixture = body:createFixture{shape = poly, density = 1.0, 
	friction = 0.1, restitution = 0.25}
	wall.body = body
	wall.body.type = "wall"
	
	self:addChild(wall)
	return wall
end

-------------------------------------------------------------
---------------------------INIT------------------------------
-------------------------------------------------------------
function game:init()
	-- initializari
	application:setBackgroundColor(0x152235)
	
	self.world = nil
	self.world = b2.World.new(0, 10, true)
	self.world:setGravity(0, conf.gravity)
	self:setAnchorPoint(.5,.5)
	local debugDraw = b2.DebugDraw.new()
	self.world:setDebugDraw(debugDraw)
	self:addChild(debugDraw)    ------------------------- DEBUG !!!!!!
	self.worldW = application:getContentWidth()
	self.worldH = application:getContentHeight()
	
	self:addChild(line_layer)
	
	--
	lume = self.world
	lume_mare = self
	-- create world
	char = character.new(application:getContentWidth()/2,application:getContentHeight()/2)
	stage:addChild(char)
	char:setPosition(application:getContentWidth()/2,application:getContentHeight()/2)
	char.corp:setPosition(application:getContentWidth()/2,application:getContentHeight()/2)
	local solar_system = MainCorp.new()
	self:addChild(solar_system)
	
	self.worldW = application:getContentWidth()*2
	self.worldH = application:getContentHeight()*2
	
	local buttons = Sprite.new()
	stage:addChild(buttons)
	
	local b1 = Bitmap.new(Texture.new("Art/speedDown.png"))
	b1:setAnchorPoint(.5)
	local b11 = b1:setScale(1.1)
	local b2 = Bitmap.new(Texture.new("Art/pause.png"))
	b2:setAnchorPoint(.5)
	local b22 = b2:setScale(1.1)
	local b3 = Bitmap.new(Texture.new("Art/speedUp.png"))
	local b33 = b3:setScale(1.1)
	b3:setAnchorPoint(.5)
	local speedDown_b = Button.new(b1,b11)
	local speedUp_b = Button.new(b3,b33)
	local pause_b = Button.new(b2,b22)
	buttons:addChild(speedDown_b)
	buttons:addChild(speedUp_b)
	buttons:addChild(pause_b)
	pause_b:setPosition(speedDown_b:getWidth()+200,pause_b:getY())
	speedUp_b:setPosition(speedDown_b:getWidth()*2+400,pause_b:getY())
	buttons:setScale(.1)
	buttons:setPosition(buttons:getWidth()/2,buttons:getHeight())
	
	stage:addChild(line_layer)
	
	local cursor = cursor.new()
	stage:addChild(cursor)
	
	
	local function f_speedDown_b(target,event)
		if target:hitTestPoint(event.x, event.y) then
			print("speedDown")
			EXPERIMENT-=0.001
		end
	end
	local function f_speedUp_b(target,event)
		if target:hitTestPoint(event.x, event.y) then
			print("speedUp")
			EXPERIMENT+=0.001
			
		end
	end
	local function f_pause_b(target,event)
		if target:hitTestPoint(event.x, event.y) then
			print("PAUSE")
			EXPERIMENT=0
		end
	end
	speedDown_b:addEventListener(Event.MOUSE_DOWN, f_speedDown_b,speedDown_b)
	speedUp_b:addEventListener(Event.MOUSE_DOWN, f_speedUp_b,speedUp_b)
	pause_b:addEventListener(Event.MOUSE_DOWN, f_pause_b,pause_b)
	
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

------------------------------------------------------------
---------------------ENTER FRAME----------------------------
------------------------------------------------------------
function game:onEnterFrame()
	self.world:step(1/60, 8, 3)
	
	for i = 1, self:getNumChildren() do
		local sprite = self:getChildAt(i)
		if sprite.corp then
			local body = sprite.corp
			local bodyX, bodyY = body:getPosition()
			sprite:setPosition(bodyX, bodyY)
		end
	end	
		
		if zooming == true then
			setSize(self,self:getWidth()+self:getWidth()*conf.zoom,self:getHeight()+self:getHeight()*conf.zoom)
			char:setPosition(char:getX()+conf.increment,char:getY()+conf.increment)
			--conf.viteza += conf.increm_speed
			zooming = false
		elseif unzooming == true then
			setSize(self,self:getWidth()-self:getWidth()*conf.zoom,self:getHeight()-self:getHeight()*conf.zoom)
			char:setPosition(char:getX()-conf.increment,char:getY()-conf.increment)
			unzooming = false
			--conf.viteza -= conf.increm_speed
		elseif reset == true then
			--self:setScale(1)
			self:setScale(.06)
			--conf.viteza = 20
			GTween.new(char,.5,{x=application:getContentWidth()/2-char:getWidth()/2,y=application:getContentHeight()/2-char:getHeight()/2},{ease = easing.outSine})
			--set_in_middle(char)
			reset = false
		end
		
		if stop_move == false then
			self:setX(char:getX())
			self:setY(char:getY())
		end
	----
	
end