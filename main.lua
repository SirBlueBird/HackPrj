Timer = require 'Timer'
require 'stuff'

function love.load()
	g_counter = 0
	g_time = 1;
	timer = Timer()
	MAP = {}
	MAP.X = 600
	MAP.Y = 600 
	
	love.window.setMode(MAP.X,MAP.Y)
	
	VECT = {}
	VECT.ANGLE = 0
	VECT.MODULE = 0
	
	OBJ = {}
	OBJ.R = 36
	OBJ.X = (MAP.X - OBJ.R)/2
	OBJ.Y = (MAP.Y - OBJ.R)/2
	OBJ.SPEED = VECT
	OBJ.IMG = love.graphics.newImage("шар.png")
	timer:every(g_time, function()
		g_counter = Inc(g_counter)-- + 1 
	end)
	
end

function love.keypressed(key)
	if (key == "d") then
		g_time = g_time*2
		timer = ChangeTime(timer,g_time,function() g_counter = g_counter+1 end)

	elseif (key=="a") then
		g_time = g_time/2
		timer = ChangeTime(timer,g_time,function() g_counter = g_counter+1 end)
	end
end

function Inc(i)
	i=i+1
	return i
end

function love.update(dt)
	timer:update(dt)
	PosUpdate(OBJ)
	SpeedUpdate(OBJ)
	
	if love.mouse.isDown(1) then
		OBJ.SPEED.MODULE = 1
		if (love.mouse.getY() - OBJ.Y) > 0 then
			OBJ.SPEED.ANGLE = math.acos( (love.mouse.getX() - OBJ.X) / math.sqrt( (love.mouse.getX() - OBJ.X)^2 + (love.mouse.getY() - OBJ.Y)^2 ) )
		else
			OBJ.SPEED.ANGLE = -math.acos( (love.mouse.getX() - OBJ.X) / math.sqrt( (love.mouse.getX() - OBJ.X)^2 + (love.mouse.getY() - OBJ.Y)^2 ) )
		end
	end
end

function love.draw()
	love.graphics.draw(OBJ.IMG, OBJ.X - OBJ.R, OBJ.Y - OBJ.R, 0, 0.25, 0.25)
	love.graphics.print(g_counter,0,0)
end

function PosUpdate(U)
	U.X = U.X + U.SPEED.MODULE * math.cos(U.SPEED.ANGLE)
	U.Y = U.Y + U.SPEED.MODULE * math.sin(U.SPEED.ANGLE)
end

function SpeedUpdate(U)
	if U.SPEED.MODULE > 0 then
		U.SPEED.MODULE = U.SPEED.MODULE - 0.25
	elseif U.SPEED.MODULE < 0 then
		U.SPEED.MODULE = U.SPEED.MODULE + 0.25
	end
end