
Scale = 1
DeltaScale = 0.1

CAM = {}
	CAM.X = 0
	CAM.Y = 0
	CAM.W = 800
	CAM.H = 650

MAP = {}
	MAP.X = 10000
	MAP.Y = 10000

function CAM_VIEW()
	x = love.mouse.getX()
	y = love.mouse.getY()
	if (x <= 10) and (x >= 0) then 
		CAM.X = CAM.X - 10
	elseif ((x >= CAM.W - 10) and (x <= CAM.W)) then
		CAM.X = CAM.X + 10
	end

	if (y >= 0) and (y <= 10) then 
		CAM.Y = CAM.Y - 10
	elseif ((y <= CAM.H) and (y >= CAM.H - 10)) then
		CAM.Y = CAM.Y + 10
	end

	if CAM.X < 0 then 
		CAM.X = 0
	elseif CAM.X > MAP.X then 
		CAM.X = MAP.X
	end

	if CAM.Y < 0 then 
		CAM.Y = 0
	elseif CAM.Y > MAP.Y then 
		CAM.Y = MAP.Y
	end
end