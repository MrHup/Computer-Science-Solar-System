cursor = Core.class(Sprite)

function cursor:init()
	local aim = Bitmap.new(Texture.new("Art/aim.png"))
	aim:setScale(.25)
	self:addChild(aim)
	
	aim:addEventListener(Event.MOUSE_HOVER, self.onMouseMove, aim)
	aim:addEventListener(Event.MOUSE_DOWN, self.onMouseMove, aim)
	aim:addEventListener(Event.MOUSE_MOVE, self.onMouseMove, aim)
end

function cursor:onMouseMove(event)
	self:setPosition(event.x,event.y)
	lookAtX = event.x
	lookAtY = event.y
end


function onEnterFrame(aim)
	
end
