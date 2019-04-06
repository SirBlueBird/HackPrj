require "constructor_objects"
require "view"
require 'stuff'
require 'buttons'
Timer = require 'Timer'

BFont = love.graphics.newFont("calibri.ttf", 15)

function love.load()
	guis = {}
	guis.Draw = {}
	guis.Obj = {}
	guis.DrawPanel = {}
	g_counter = 0
	g_time = 1;
	panel_index = 1
	timer = Timer()

	--testbutton = ButtonCreate(100,100,100,50,"TEST",BFont,function() g_counter = g_counter - 1 end, {255,255,255,255},{0,0,255,255},{255,255,255,255})
	local oc,fc,tc = {255,255,255,200},{0,0,255,0.3},{255,255,200}
	upbtn = ButtonCreate(MAP.X-50,0,50,30,"UP",BFont, function() 
		if panel_index > 1 then
			panel_index=panel_index-1
			guis.DrawPanel = RemovePanel(guis.DrawPanel,panel_index)
			
			guis.DrapPanel = OpenPanel(guis.Obj,guis.DrawPanel,panel_index)
		end
	end,
		oc,fc,tc
	)
	downbtn = ButtonCreate(MAP.X-50,30,50,30,"DOWN",BFont, function() 
		if panel_index < 4 then
			panel_index=panel_index+1
			guis.DrawPanel = RemovePanel(guis.Draw)
			
			guis.DrapPanel = OpenPanel(guis.Obj,guis.DrawPanel,panel_index)
		end
	end,
		oc,fc,tc
	)
	local panel = {}
	
	panel[1] = ButtonControlCreate(1,0,0,110,60,"Солнце",BFont, function() 
	--Пишите ваши функции сюда, ток сделайте менее наркоманскую инициализацию, лол
	end,
	oc,fc,tc
	)
	panel[2] = ButtonControlCreate(1,110,0,110,60,"Меркурий",BFont, function() 
	
	end,
	oc,fc,tc
	)
	panel[3] = ButtonControlCreate(1,220,0,110,60,"Венера",BFont, function() 
	
	end,
	oc,fc,tc
	)
	panel[4] = ButtonControlCreate(1,330,0,110,60,"Земля",BFont, function() 
	
	end,
	oc,fc,tc
	)
	panel[5] = ButtonControlCreate(1,440,0,110,60,"Марс",BFont, function() 
	
	end,
	oc,fc,tc
	)
	for k,v in pairs(panel) do
		if v.index == panel_index then
		table.insert(guis.DrawPanel,v) end
		table.insert(guis.Obj,v)
	end
	table.insert(guis.Draw,upbtn)
	table.insert(guis.Obj,upbtn)
	table.insert(guis.Draw,downbtn)
	table.insert(guis.Obj,downbtn)	
---------------------------------------------------------------------------
	
	love.window.setMode(CAM.W, CAM.H)
	
	ALL_OBJ = {}
	OBJ_count = 0
	OBJ_selected = -1
	
	G = 7*10^-10
	
end


function love.update(dt)

	Mouse_X = love.mouse.getX() + CAM.X
	Mouse_Y = love.mouse.getY() + CAM.Y
	
	PosUpdate()
	SpeedUpdate()
	
	if love.keyboard.isDown("c") then
		NewOBJ(ALL_OBJ, OBJ_count, "EARTH")
	elseif love.keyboard.isDown("s") then	
		if not(OBJ_selected == -1) then
			ALL_OBJ[OBJ_selected].SPEED.MODULE = 0
			ALL_OBJ[OBJ_selected].ACCEL.MODULE = 0
		end
	elseif love.keyboard.isDown("a") then	
		if not(OBJ_selected == -1) then
			ALL_OBJ[OBJ_selected].ACCEL.MODULE = 0
		end
	end
	
	if love.mouse.isDown(1) then
		if not(OBJ_selected == -1) then
			ALL_OBJ[OBJ_selected].SPEED.MODULE = 2
			if (Mouse_Y - ALL_OBJ[OBJ_selected].Y) > 0 then
				ALL_OBJ[OBJ_selected].SPEED.ANGLE = math.acos( (Mouse_X - ALL_OBJ[OBJ_selected].X) / math.sqrt( (Mouse_X - ALL_OBJ[OBJ_selected].X)^2 + (Mouse_Y - ALL_OBJ[OBJ_selected].Y)^2 ) )
			else
				ALL_OBJ[OBJ_selected].SPEED.ANGLE = -math.acos( (Mouse_X - ALL_OBJ[OBJ_selected].X) / math.sqrt( (Mouse_X - ALL_OBJ[OBJ_selected].X)^2 + (Mouse_Y - ALL_OBJ[OBJ_selected].Y)^2 ) )
			end
		else
			for key, value in pairs(ALL_OBJ) do
				if math.sqrt( (Mouse_X - ALL_OBJ[key].X)^2 + (Mouse_Y - ALL_OBJ[key].Y)^2 ) <= ALL_OBJ[key].R then 
					OBJ_selected = key
				end
			end
		end
	elseif (love.mouse.isDown(2)) and not(OBJ_selected == -1) then
		ALL_OBJ[OBJ_selected].ACCEL.MODULE = .1
		if (Mouse_Y - ALL_OBJ[OBJ_selected].Y) > 0 then
			ALL_OBJ[OBJ_selected].ACCEL.ANGLE = math.acos( (Mouse_X - ALL_OBJ[OBJ_selected].X) / math.sqrt( (Mouse_X - ALL_OBJ[OBJ_selected].X)^2 + (Mouse_Y - ALL_OBJ[OBJ_selected].Y)^2 ) )
		else
			ALL_OBJ[OBJ_selected].ACCEL.ANGLE = -math.acos( (Mouse_X - ALL_OBJ[OBJ_selected].X) / math.sqrt( (Mouse_X - ALL_OBJ[OBJ_selected].X)^2 + (Mouse_Y - ALL_OBJ[OBJ_selected].Y)^2 ) )
		end
	end
	
	CAM_VIEW()
	--[[
	
	if love.keyboard.isDown("s") then
		OBJ.SPEED.ANGLE = 0
		OBJ.SPEED.MODULE = 0
		OBJ.ACCEL.ANGLE = 0
		OBJ.ACCEL.MODULE = 0
	end --]]
end

function love.draw()
	for key, value in pairs(ALL_OBJ) do
		love.graphics.draw(ALL_OBJ[key].IMG, ALL_OBJ[key].X - ALL_OBJ[key].R - CAM.X, ALL_OBJ[key].Y - ALL_OBJ[key].R - CAM.Y)
	end
	
	love.graphics.print( OBJ_selected, 400, 70)
	
	love.graphics.print( CAM.X, 10, 70)
	love.graphics.print( CAM.Y, 10, 80)
	
	Drawgui(guis.Draw,guis.DrawPanel)
end

function love.mousepressed(x, y, button, istouch)
	mousehandle(x,y,button,guis.Draw,guis.DrawPanel)
end

function PosUpdate()
	for key, value in pairs(ALL_OBJ) do
		ALL_OBJ[key].X = ALL_OBJ[key].X + ALL_OBJ[key].SPEED.MODULE * math.cos(ALL_OBJ[key].SPEED.ANGLE)
		ALL_OBJ[key].Y = ALL_OBJ[key].Y + ALL_OBJ[key].SPEED.MODULE * math.sin(ALL_OBJ[key].SPEED.ANGLE)
	end
end

function SpeedUpdate()
	local buf
	local angle_buf
	for key, value in pairs(ALL_OBJ) do 
		buf = math.sqrt( (ALL_OBJ[key].SPEED.MODULE*math.cos(ALL_OBJ[key].SPEED.ANGLE) + ALL_OBJ[key].ACCEL.MODULE*math.cos(ALL_OBJ[key].ACCEL.ANGLE))^2 + (ALL_OBJ[key].SPEED.MODULE*math.sin(ALL_OBJ[key].SPEED.ANGLE) + ALL_OBJ[key].ACCEL.MODULE*math.sin(ALL_OBJ[key].ACCEL.ANGLE))^2 )
		angle_buf = 0
		if not(buf == 0) then 
			angle_buf = math.acos( (ALL_OBJ[key].SPEED.MODULE*math.cos(ALL_OBJ[key].SPEED.ANGLE) + ALL_OBJ[key].ACCEL.MODULE*math.cos(ALL_OBJ[key].ACCEL.ANGLE)) / buf ) 
			if (ALL_OBJ[key].SPEED.MODULE*math.sin(ALL_OBJ[key].SPEED.ANGLE) + ALL_OBJ[key].ACCEL.MODULE*math.sin(ALL_OBJ[key].ACCEL.ANGLE)) < 0 then 
				angle_buf = -angle_buf 
			end
		end

		ALL_OBJ[key].SPEED.MODULE = buf
		ALL_OBJ[key].SPEED.ANGLE = angle_buf	
	end
end

--[[function AccelUpdate() 
	local buf
	local angle_buf
	local a_module
	for key, value in pairs(ALL_OBJ) do
		a_module = 0
		for i, j in pairs(ALL_OBJ) do
			if not(i == key) and not(buf == 0) then
				buf = math.sqrt( (ALL_OBJ[key].X - ALL_OBJ[i].X)^2 + (ALL_OBJ[key].Y - ALL_OBJ[i].Y)^2 )
				angle_buf = 0
			
				angle_buf = math.acos( (ALL_OBJ[key].X - ALL_OBJ[i].X) / buf)
				if (ALL_OBJ[key].Y - ALL_OBJ[i].Y) > 0 then
					angle_buf = -angle_buf
				end
			end
			a_module = 
		end
		a_module = math.sqrt(a_module * G) 
	end
end--]]
