-- the small thingy that is proportional to the size of its parent

Corp = Core.class(Sprite)


function Corp:init()
	-- key elements given from the input
	self.imp = 0
	self.scale = 1
	self.path = ""
	self.name = ""
	self.lines = false
	self.short_desc = ""
	self.long_desc = ""
	self.satellites = {}
	self.stars = {}
	self.kids = {}
	self.arg1 = ""
	self.connected = ""
	
	--- deal with the rotation
	self.radius = 0
	self.orbitX = 0
	self.orbitY = 0
	self.kidNr = 0
	self.img = nil
	self.master = nil
	
	--- auxiliars dealing with other stuff
	self.angle = 0
	self.nkids = 1
	self.linie = nil
end

function Corp:create()
	local img1 = Bitmap.new(Texture.new(self.path))
	img1:setAnchorPoint(.5)
	local img2 = Bitmap.new(Texture.new(self.path)):setScale(.8)
	img2:setAnchorPoint(.5)
	local img = Button.new(img1, img2)
	img:setScale(self.scale)
	self.img = img
	
	
	local text = TextWrap.new(self.name, 800, "left")
	text:setFont(conf.bigFont)
	--text:setPosition(img:getX()-text:getWidth()/2, img:getY()+img:getHeight()/2 + 5)
	text:setPosition(img:getX()-text:getWidth()/2,img:getY()-text:getHeight()/2)
	text:setTextColor(0xFFFFFF)
	text:setScale(self.scale)
	
	self:addChild(img)
	self:addChild(text)
	
	local debounce= false
	
	local function undebounce()
		debounce = false
		print("[ ".. self:getX() .. "] - [ " .. self:getY() .. " ]")
	end
	
	-- buton clicked
	local function but_1(target,event) -- buton de shop
		if target:hitTestPoint(event.x, event.y) and debounce == false then
			debounce = true
			Timer.delayedCall(conf.time_fade_notif, function() undebounce() end)
			print("Show: " .. self.long_desc)
			--[[local notif = notification.new(self.long_desc)
			notif:setScale(compute_scale_label(self.imp))
			--setSize(notif, self.img:getWidth(), notif:getHeight())
			notif:setPosition(img:getX()+120, img:getY()-60)
			self:addChild(notif)]]
			local pop = long_panel.new(self.name,self.long_desc,self.stars,self.short_desc,self.satellites)
			line_layer:addChild(pop)
			-- zoom pe planeta
			--stop_move = true
			--print()
			--lume_mare:setAnchorPoint(1/event.x,1/event.y)
			local dif_scale = lume_mare:getScale() - 1.1
			local x1 = char:getX()-(event.x-application:getContentWidth()/2)
			local y1 = char:getY()-(event.y-application:getContentHeight()/2)
			local ms = self.master
			if self.imp == 0 then
				if self.imp == 0 then ms = self end
				for i,v in pairs(domens) do
					v[1].angle =0
				end
				for i,v in pairs(domens) do
					print(v[1].kidNr.. "." .. v[1].name)
					if v[1].kidNr == 6 then
						local aux = v[1].kidNr
						v[1].kidNr = ms.kidNr
						ms.kidNr = aux
						break
					end
				end
				lume_mare:setScale(.35)
				char:setPosition(char:getX()-300, conf.radius/3+400)
			else
				GTween.new(char,1,{x=x1,y=y1},{ease = easing.inSine})
				--char:setPosition(char:getX()-300, conf.radius/3+400)
			end
			--rotate = false
			de_reprezentat = ms.name
			--print(ms.name)
			--sceneManager:changeScene("zoomIn", 1, conf.transition, conf.easing)
			
			
			--print(ms.angle)
			
			
			
		end
	end
	
	self:createKids()
	
	img:addEventListener(Event.MOUSE_DOWN, but_1,img)
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	
end


function Corp:onEnterFrame()
	
	if rotate == true then
		--local x = self.master.img:getX() + math.cos(self.angle + self.kidNr*2*math.pi/conf.domains) * self.radius
		--local y = self.master.img:getY() + math.sin(self.angle + self.kidNr*2*math.pi/conf.domains) * self.radius
		local x,y
		if self.master.nkids ~=nil then
			x = self.master.img:getX() + math.cos(self.angle + conf.EXP2*self.kidNr*2*math.pi/self.master.nkids) * self.radius
			y = self.master.img:getY() + math.sin(self.angle + conf.EXP2*self.kidNr*2*math.pi/self.master.nkids) * self.radius
		else
			x = self.master.img:getX() + math.cos(self.angle + conf.EXP2*self.kidNr*2*math.pi/conf.domains) * self.radius
			y = self.master.img:getY() + math.sin(self.angle + conf.EXP2*self.kidNr*2*math.pi/conf.domains) * self.radius
			
		end
		self:setPosition(x,y)
		--[[if self.linie ~=nil then
				line_layer:removeChild(self.linie)
				self.linie = draw_line(application:getContentWidth(),application:getContentHeight(),x,y)
			else
				self.linie = draw_line(application:getContentWidth(),application:getContentHeight(),x,y)
		end]]
		self.angle +=(EXPERIMENT)*((compute_angle_speed(self.imp) )*2-1)
		--print(self.name .. " ...." .. self.kidNr)
		
	end
end

function Corp:createKids()
	-- deals with displaying the kids
	
	for i, v in pairs(self.kids) do
		if v.name ~= "" and v.name ~= nil then
			v.orbitX = self.img:getX()
			v.orbitY = self.img:getY()
			v.kidNr = i+1
			v.radius = compute_radius(v.imp, v.nkids)
			v.master = self
			--v:printStats()
			v:create()
			
			
			self:addChild(v)
		end
	end
	
	for i, v in pairs(self.kids) do
		print("Created the kids: " .. v.name)
	end
	
end

function Corp:printStats()
	print("-------------------------")
	print(self.imp)
	print(self.path)
	print(self.name)
	print(self.short_desc)
	print(self.long_desc)
	print(self.connected)
	print(self.kidNr)
	print(self.orbitX)
	print(self.radius)
	print("-------------------------")
end


-- importance in a body
-- imp = parent1.imp + parent2.imp, if parent2==nil then imp = parent1.imp + 1
-- the importance gives away the distance from the parent, the distance grows exponentially from the sun (imp = 0)
