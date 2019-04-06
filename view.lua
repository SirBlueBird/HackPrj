

CAM = {} 
	CAM.X = 0
	CAM.Y = 0
	CAM.W = 800
	CAM.H = 650

MAP = {}
	MAP.X = 1800
	MAP.Y = 1650

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
	elseif (CAM.X + CAM.W) > MAP.X then 
		CAM.X = MAP.X - CAM.W
	end

	if CAM.Y < 0 then 
		CAM.Y = 0
	elseif (CAM.Y + CAM.H) > MAP.Y then 
		CAM.Y = MAP.Y - CAM.H
	end
end