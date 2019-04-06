require "constructor_objects"
require "view"

function love.load()

	
	
	love.window.setMode(CAM.W,CAM.H)
	
	ALL_OBJ = {}
	Stars = {}
	--star = {x=0 , y=0 , visible = true}
	--star.x = 5 star.y = 10 star.visible = true
	--table.insert(Stars,star)
	for i = 1, 10000 do
		local star = {}
		star.x = math.random(1, MAP.X)
		star.y = math.random(1, MAP.Y)
		star.visible = true
		table.insert(Stars,star)
	end
end


function love.update(dt)
	PosUpdate(OBJ)
	CAM_VIEW()
	SpeedUpdate(OBJ)
	
	if love.mouse.isDown(1) then
		OBJ.SPEED.MODULE = 1
		if (love.mouse.getY() - OBJ.Y) > 0 then
			OBJ.SPEED.ANGLE = math.acos( (love.mouse.getX() - OBJ.X) / math.sqrt( (love.mouse.getX() - OBJ.X)^2 + (love.mouse.getY() - OBJ.Y)^2 ) )
		else
			OBJ.SPEED.ANGLE = -math.acos( (love.mouse.getX() - OBJ.X) / math.sqrt( (love.mouse.getX() - OBJ.X)^2 + (love.mouse.getY() - OBJ.Y)^2 ) )
		end
	elseif love.mouse.isDown(2) then
		OBJ.ACCEL.MODULE = .1
		if (love.mouse.getY() - OBJ.Y) > 0 then
			OBJ.ACCEL.ANGLE = math.acos( (love.mouse.getX() - OBJ.X) / math.sqrt( (love.mouse.getX() - OBJ.X)^2 + (love.mouse.getY() - OBJ.Y)^2 ) )
		else
			OBJ.ACCEL.ANGLE = -math.acos( (love.mouse.getX() - OBJ.X) / math.sqrt( (love.mouse.getX() - OBJ.X)^2 + (love.mouse.getY() - OBJ.Y)^2 ) )
		end
	end
	
	if love.keyboard.isDown("s") then
		OBJ.SPEED.ANGLE = 0
		OBJ.SPEED.MODULE = 0
		OBJ.ACCEL.ANGLE = 0
		OBJ.ACCEL.MODULE = 0
	end 
end

function love.draw()
	love.graphics.draw(OBJ.IMG, OBJ.X - OBJ.R, OBJ.Y - OBJ.R, 0, 0.25, 0.25)
	for k,v in pairs(Stars) do
		love.graphics.points(v.x-CAM.X, v.y-CAM.Y)
	end
	love.graphics.print(CAM.X, 10, 10)
	love.graphics.print(CAM.Y, 10, 20)
	
	love.graphics.print(OBJ.ACCEL.ANGLE, 10, 40)
	love.graphics.print(OBJ.ACCEL.MODULE, 10, 50)
	
end

function PosUpdate(U)
	U.X = U.X + U.SPEED.MODULE * math.cos(U.SPEED.ANGLE)
	U.Y = U.Y + U.SPEED.MODULE * math.sin(U.SPEED.ANGLE)
end

function SpeedUpdate(U)
	local buf = math.sqrt( (U.SPEED.MODULE*math.cos(U.SPEED.ANGLE) + U.ACCEL.MODULE*math.cos(U.ACCEL.ANGLE))^2 + (U.SPEED.MODULE*math.sin(U.SPEED.ANGLE) + U.ACCEL.MODULE*math.sin(U.ACCEL.ANGLE))^2 )
	local angle_buf = 0
	if not(buf == 0) then 
		angle_buf = math.acos( (U.SPEED.MODULE*math.cos(U.SPEED.ANGLE) + U.ACCEL.MODULE*math.cos(U.ACCEL.ANGLE)) / buf ) 
		if (U.SPEED.MODULE*math.sin(U.SPEED.ANGLE) + U.ACCEL.MODULE*math.sin(U.ACCEL.ANGLE)) < 0 then 
			angle_buf = -angle_buf 
		end
	end
	
	U.SPEED.MODULE = buf
	U.SPEED.ANGLE = angle_buf	
end

function AccelUpdate(N, M) 
	if (N.Y - M.Y) > 0 then
		N.ACCEL.ANGLE = math.acos( (N.X - M.X) / math.sqrt( (N.X - M.X)^2 + (love.mouse.getY() - M.Y)^2 ) )
	else
		N.ACCEL.ANGLE = -math.acos( (N.X - M.X) / math.sqrt( (N.X - M.X)^2 + (love.mouse.getY() - M.Y)^2 ) )
	end
end


--/*~---------------------------~*\--
function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
