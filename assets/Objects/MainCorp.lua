-- these are the big domains that are directly connected to the Sun without arrows.
-- cannot interconnect

MainCorp = Core.class(Sprite)

function MainCorp:init(path, name)
	local sun = self:makeBigStar()
	dom = {}
	local pixie = Bitmap.new(Texture.new("Art/char.png"))
	pixie:setPosition(application:getContentWidth()/2,application:getContentHeight()/2)
	self.img = pixie
	centru = self.img
	
	for i=1, conf.domains do
		local file2 = io.open("|D|dom"..tostring(i)..".txt", "r+")
		local str = file2:read("*all")         
		file2:close()  
		lines = {}
		for line in str:gmatch("(.-)\n") do 
			lines[#lines + 1] = line
		end
		dom[i] = self:readStuff(lines, true)	
		dom[i][1].radius = compute_radius(dom[i][1].imp)
		dom[i][1].kidNr = i-1
		
	end
	
	local l1,l2 = generate_around_circle(application:getContentWidth()/2,application:getContentHeight()/2,conf.radius,conf.domains)
	for i=1, conf.domains do
		print(name)
		if(name == nil) then
			self:addChild(dom[i][1])
			dom[i][1].orbitX = application:getContentWidth()/2
			dom[i][1].orbitY = application:getContentHeight()/2
			dom[i][1].master = self
			dom[i][1]:create()
		else
			if dom[i][1].name == name then
				self:addChild(dom[i][1])
				dom[i][1].orbitX = application:getContentWidth()/2
				dom[i][1].orbitY = application:getContentHeight()/2
				dom[i][1].master = self
				dom[i][1]:create()
			end
		end
	end
	domens = dom
	--self:setAnchorPoint(.5)
	--self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

local function starts_with(str, start)
   return str:sub(1, #start) == start
end

local function ends_with(str, ending)
   return ending == "" or str:sub(-#ending) == ending
end

function MainCorp:makeBigStar()
	local p1 = Bitmap.new(Texture.new("Art/Soare.png"))
	p1:setScale(12)
	--p1:setPosition(
	set_in_middle(p1)
	local text = TextWrap.new("Computer Science", 5550, "center")
	text:setFont(conf.hugeFont)
	set_in_middle(text)
	text:setTextColor(0xFFFFFF)
	self:addChild(p1)
	self:addChild(text)
	return p1
end

function MainCorp:afisaj(domain)
	-- make big planet
	
end

function MainCorp:readStuff(lines, first_time)
	print("IN")
	local openBr = 0
	local obj = {}
	local k = 1
	local jump = 0
	for i,line in pairs(lines) do
		if jump == 0 then
			if line == "{" and i~=1 then
				print("I found open { :" .. i)
				obj[k]=Corp.new()
				obj[k].imp = tonumber(lines[i+1])
				obj[k].scale = tonumber(lines[i+2]) * compute_scale(obj[k].imp)
				obj[k].path = lines[i+3]
				obj[k].name = lines[i+4]
				if lines[i+5] == "true" or lines[i+5]=="True" then
					obj[k].lines = true
				else
					obj[k].lines = false
				end
				obj[k].short_desc = lines[i+6]
				obj[k].long_desc = lines[i+7]
				
				local x = tonumber(lines[i+8])
				for j=1,x do 
					obj[k].satellites[j]=lines[i+8+j] 
				end
				local y = tonumber(lines[i+9+x])
				for j=1,y do
					obj[k].stars[j]=lines[i+9+x+j] 
				end
				obj[k].arg1 = lines[i+10+x+y] 
				obj[k].connected = lines[i-1] --
				
				print(obj[k].name .." has been created, woooo")
				
				openBr +=1
				--make kids
				test,jump = findEnd(lines, 0, i-1)
				--[[print("---------------CALL-----------------------")
				for i,v in pairs(test) do
					print(i .. ".." .. v)
				end
				--]]
				print(obj[k].name .. " went IN")
				local kid = self:readStuff(test,false)
				for m,n in pairs(kid) do
					obj[k].kids[obj[k].nkids] = n
					n.kidNr=obj[k].nkids
					obj[k].nkids+=1
				end
				k+=1
				
			elseif line == "}" then
				openBr -=1
			end
		--elseif line == d then
		else
			jump-=1
		end
	end
	print("OUT")
	return obj -- returns object of type Corp
end

function MainCorp:onEnterFrame()
	print("@"..domens[1][1].angle)
end

--[[

{
0 -- importance value (Determines the circle of rotation of the planet)
2 -- scale
path -- path to image
Sun -- name of body
yes/no -- if it has lines to the children
cool stuff to say -- text that is visible under the name. VERY SHORT. One sentence max or -1 if empty (use it just for domains and subdomains)
This is random text. This is gonna be popped in a text box when clicked. Keep it short
2 - number of satellites (really small planets with only a title and no connection lines)
satellite_name_1
satellite_name_2 (use it only for subdomains)
arg1 -- argument slot 1
arg2 -- argument slot 2
2 - number of stars (put 0 for any leaf or small planet, k > 0 just for big domains)
n names
8 -- number of kids
connection message -- thing that is gonna be written on the line
{} 
... 
{} -- 8 things with the same structure

}


-> have a function that reads the object, takes as argument the parent
creates the shit with all the info
calls the function again recusively if the input has more things in it


MainCorp:
 List[8]
	*Corp
		List[2]
			*Corp
			*Corp
				List[3] ...
	* Corp
		List[3]
			*Corp
			*Corp
			*Corp
	*Corp
	...
	

** CORP
Name: Computer Science
Importance = 0
Scale = 2
path = planets/Boris.png
lines = true
kids = [a,b]
satellites = []
connection message = ["Stuff link","Calculus III"]
stars = ["Daniel Pop","Micota de aur"]
pozX = 0
pozY = 0

to form CORP, call addBody(parent, input_block)

]]
