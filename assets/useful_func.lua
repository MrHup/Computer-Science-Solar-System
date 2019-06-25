function findEnd(lines,openBr, lineNr)
	lines2 = {}
	local k = 1
	local debounce = true
	for i,v in pairs(lines) do
		if lineNr == 0 then
			if openBr ==0 and debounce ==false then
				return lines2,k-1
			elseif lineNr>0 then
				lineNr-=0
			else
				if v == "{" then
					openBr+=1
				elseif v== "}" then
					openBr -=1
				end
			end
				lines2[k] = v
				debounce = false
				k+=1
		else
			lineNr-=1
		end
		
		
	end
	return lines2, k-1
end

function compute_radius(imp,nkids) -- to be changed later when changing radius by the level of importance
	if imp == 0 then
		return conf.radius
	elseif imp == 1 then
		return conf.radius/4 - 300 + math.random(-50,150)
	elseif imp == 2 then
		return conf.radius/8 - 300 + math.random(-50,150)
	elseif imp == 3 then
		return conf.radius/16 - 300 + math.random(-50,150)
	else
		return conf.radius/32 - 300 + math.random(-50,150)
	end
end

function compute_scale(imp) -- compute the size based on the importance
	if imp == 0 then
		return conf.scale/2
	elseif imp == 1 then
		return conf.scale/4
	elseif imp == 2 then
		return conf.scale/8
	elseif imp == 3 then
		return conf.scale/16
	else
		return conf.scale/32
	end
end

function compute_move(scale,imp) -- compute the amount of distance added based on scale and imp
	if scale < 0.1 then
		return conf.extra * 6
	elseif scale < 0.6 then
		return conf.extra * 3
	elseif scale < 0.8 then
		return conf.extra * 2
	elseif scale < 1 then
		return conf.extra 
	else
		return 0
	end
end

function compute_scale_label(imp) -- compute the scale of the label in regars to the importance value
	if imp == 0 then
		return 1
	elseif imp == 1 then
		return 0.9
	elseif imp == 2 then
		return 0.8
	elseif imp == 3 then
		return 0.7
	else
		return 0.5
	end
end

function compute_angle_speed(imp) -- make the planets spin in regards to importance
	if imp == 0 then
		return conf.angle_speed
	elseif imp == 1 then
		return conf.angle_speed * 2
	elseif imp == 2 then
		return conf.angle_speed * 4
	elseif imp == 3 then
		return conf.angle_speed *8
	else
		return conf.angle_speed * 16
	end
end

function draw_line(x0,y0,x,y)
	local shape_test = Shape.new()
	shape_test:beginPath()
	shape_test:setLineStyle(3, 0xFFFFFF)
	shape_test:moveTo(x0,y0)
	shape_test:lineTo(x,y)
	shape_test:endPath()
	print("Added line from (" .. x0 .. "," .. y0 .. ") to (" .. x .. "," .. y .. ")")
	line_layer:addChild(shape_test)
	
	return shape_test
end

function generate_around_circle(x0,y0,r,n)
	-- given a radius and a point, generate n points around the center equally distanced
	local points_X={}
	local points_Y={}
		for i=0,n-1 do
		local x = x0 + r * math.cos(2 * math.pi * i / n)
		local y = y0 + r * math.sin(2 * math.pi * i / n)
		
		points_X[i+1]= x
		points_Y[i+1]= y
	end
	
	return points_X,points_Y
end

function set_in_middle(obj)
	obj:setPosition(application:getContentWidth()/2-obj:getWidth()/2,application:getContentHeight()/2-obj:getHeight()/2)
end