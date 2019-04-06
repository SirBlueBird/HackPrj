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
	rollstate = false -- свернут

	--testbutton = ButtonCreate(100,100,100,50,"TEST",BFont,function() g_counter = g_counter - 1 end, {255,255,255,255},{0,0,255,255},{255,255,255,255})

	local w = CAM.W/12 local h = CAM.H / 40
	local oc,fc,tc = {255,255,255,200},{0,0,255,0.3},{255,255,200}
	roll = ButtonCreate(CAM.W/2-w/2,0,w,h,"Open",BFont, function()
		if rollstate == false then
			rollstate = true
			panel_index = 1
			roll.text = "Close"
			roll.y=CAM.H/20
			OpenPanel(guis.Obj,guis.DrawPanel,panel_index)
			--for k,v in pairs(guis.Obj) do
			--	if v.index == 1 or v.index == 0 then
			--		table.insert(guis.DrawPanel,v)
			--	end
			--end
		else
			rollstate = false
			guis.DrawPanel = {}
			roll.text = "Open"
			roll.y=0
		end
	end,
	oc,fc,tc
	)
	
	upbtn = ButtonControlCreate(0,CAM.W-w,0,w,h,"UP",BFont, function() 
		if panel_index > 1 then
			panel_index=panel_index-1
			guis.DrawPanel = RemovePanel(guis.DrawPanel,panel_index)
			
			guis.DrapPanel = OpenPanel(guis.Obj,guis.DrawPanel,panel_index)
		end
	end,
		oc,fc,tc
	)
	downbtn = ButtonControlCreate(0,CAM.W-w,h,w,h,"DOWN",BFont, function() 
		if panel_index < 2 then
			panel_index=panel_index+1
			guis.DrawPanel = RemovePanel(guis.Draw)
			
			guis.DrapPanel = OpenPanel(guis.Obj,guis.DrawPanel,panel_index)
		end
	end,
		oc,fc,tc
	)
	local panel = {}
	local w = CAM.W/(600/110) local h = CAM.H/(20)
	
	panel[1] = ButtonControlCreate(1,0,0,w,h,"Солнце",BFont, function() 
	--Пишите ваши функции сюда
	end,
	oc,fc,tc
	)
	panel[2] = ButtonControlCreate(1,w,0,w,h,"Меркурий",BFont, function() 
	
	end,
	oc,fc,tc
	)
	panel[3] = ButtonControlCreate(1,w*2,0,w,h,"Венера",BFont, function() 
	
	end,
	oc,fc,tc
	)
	panel[4] = ButtonControlCreate(1,w*3,0,w,h,"Земля",BFont, function() 
	
	end,
	oc,fc,tc
	)
	panel[5] = ButtonControlCreate(1,w*4,0,w,h,"Марс",BFont, function() 
	
	end,
	oc,fc,tc
	)
	--===
	panel[6] = ButtonControlCreate(2,0,0,w,h,"Юпитер",BFont, function() 
	--Пишите ваши функции сюда
	end,
	oc,fc,tc
	)
	panel[7] = ButtonControlCreate(2,w,0,w,h,"Сатурн",BFont, function() 
	
	end,
	oc,fc,tc
	)
	panel[8] = ButtonControlCreate(2,w*2,0,w,h,"Уран",BFont, function() 
	
	end,
	oc,fc,tc
	)
	panel[9] = ButtonControlCreate(2,w*3,0,w,h,"Нептун",BFont, function() 
	
	end,
	oc,fc,tc
	)
	panel[10] = ButtonControlCreate(2,w*4,0,w,h,"SPACEMAN",BFont, function() 
	
	end,
	oc,fc,tc
	)
	for k,v in pairs(panel) do
		--if v.index == panel_index then
		--table.insert(guis.DrawPanel,v) end
		table.insert(guis.Obj,v)
	end
	--table.insert(guis.Draw,upbtn)
	table.insert(guis.Obj,upbtn)
	--table.insert(guis.Draw,downbtn)
	table.insert(guis.Obj,downbtn)
	table.insert(guis.Draw,roll)
	table.insert(guis.Obj,roll)
---------------------------------------------------------------------------
	
	Stars = {}
	for i = 1, 50000 do
		local star = {}
		star.x = math.random(1, MAP.X)
		star.y = math.random(1, MAP.Y)
		star.visible = true
		table.insert(Stars,star)
	end
	
	love.window.setMode(CAM.W, CAM.H)
	
	ALL_OBJ = {}
	OBJ_selected = -1
	
	G = 7*10^-7

------------------------------------------------------
--Здесь будут определять планеты
	--NewOBJ(ALL_OBJ, "SUN",10, 10)
	
end


function love.update(dt)

	--if not(table.getn(ALL_OBJ) == 0) then 
		--print(ALL_OBJ[1].X," ",ALL_OBJ[2].X) 
	--end

	Mouse_X = love.mouse.getX() + CAM.X
	Mouse_Y = love.mouse.getY() + CAM.Y
	
	PosUpdate()
	SpeedUpdate()
	AccelUpdate()
	
	if love.keyboard.isDown("s") then	
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
		for key, value in pairs(ALL_OBJ) do
			if math.sqrt( (Mouse_X - ALL_OBJ[key].X)^2 + (Mouse_Y - ALL_OBJ[key].Y)^2 ) <= ALL_OBJ[key].R then 
				if (OBJ_selected == -1) or not(OBJ_selected == key) then
					OBJ_selected = key
				end
			else
				ALL_OBJ[OBJ_selected].SPEED.MODULE = 2
				ALL_OBJ[OBJ_selected].SPEED.ANGLE = math.acos( (Mouse_X - ALL_OBJ[OBJ_selected].X) / math.sqrt( (Mouse_X - ALL_OBJ[OBJ_selected].X)^2 + (Mouse_Y - ALL_OBJ[OBJ_selected].Y)^2 ) )
				if (Mouse_Y - ALL_OBJ[OBJ_selected].Y) < 0 then
					ALL_OBJ[OBJ_selected].SPEED.ANGLE = -ALL_OBJ[OBJ_selected].SPEED.ANGLE
				end
			end
		end
	elseif (love.mouse.isDown(2)) and not(OBJ_selected == -1) then
		ALL_OBJ[OBJ_selected].ACCEL.MODULE = .1
		ALL_OBJ[OBJ_selected].ACCEL.ANGLE = math.acos( (Mouse_X - ALL_OBJ[OBJ_selected].X) / math.sqrt( (Mouse_X - ALL_OBJ[OBJ_selected].X)^2 + (Mouse_Y - ALL_OBJ[OBJ_selected].Y)^2 ) )
		if (Mouse_Y - ALL_OBJ[OBJ_selected].Y) < 0 then
			ALL_OBJ[OBJ_selected].ACCEL.ANGLE = -ALL_OBJ[OBJ_selected].ACCEL.ANGLE
		end
	end
	
	CAM_VIEW()
end

function love.draw()

	for k,v in pairs(Stars) do
		local chance = math.random(1,10)
		if chance > 3 then
			love.graphics.points(v.x-CAM.X, v.y-CAM.Y)
		end
	end
	

	for key, value in pairs(ALL_OBJ) do
		love.graphics.draw(ALL_OBJ[key].IMG, ALL_OBJ[key].X - ALL_OBJ[key].R - CAM.X, ALL_OBJ[key].Y - ALL_OBJ[key].R - CAM.Y,ALL_OBJ[key].R/150,ALL_OBJ[key].R/150)
	end
	
	love.graphics.print( OBJ_selected, 400, 70)

	
	love.graphics.print( CAM.X, 10, 70)
	love.graphics.print( CAM.Y, 10, 80)
	
	Drawgui(guis.Draw,guis.DrawPanel)
end

function love.mousepressed(x, y, button, istouch)
	mousehandle(x,y,button,guis.Draw,guis.DrawPanel)
end

function love.keypressed(key) 
	if key == "c" then
		NewOBJ(ALL_OBJ, "SUN", 0, 0)
	end
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

function AccelUpdate() 
	print(table.getn(ALL_OBJ))
	if not(table.getn(ALL_OBJ) == 1) then
		for key, value in pairs(ALL_OBJ) do
			a_mod_buf, a_mod_buf_sum, a_angle_buf_sum = 0, 0, 0
			for i, j in pairs(ALL_OBJ) do
				buffer = math.sqrt( (ALL_OBJ[key].X - ALL_OBJ[i].X)^2 + (ALL_OBJ[key].Y - ALL_OBJ[i].Y)^2 )
				if not(i == key) and not(buffer == 0) then
				
					a_angle_buf = math.acos( (ALL_OBJ[key].X - ALL_OBJ[i].X) / buffer)
					if (ALL_OBJ[key].Y - ALL_OBJ[i].Y) > 0 then
						a_angle_buf = -a_angle_buf
					end
					a_mod_buf = ALL_OBJ[key].MASS / buffer^2
					buffer = a_mod_buf*math.cos(a_angle_buf) + a_mod_buf_sum*math.cos(a_angle_buf_sum)
					a_mod_buf_sum = math.sqrt( buffer^2 + (a_mod_buf*math.sin(a_angle_buf) + a_mod_buf_sum*math.sin(a_angle_buf_sum))^2 )
					a_angle_buf_sum = math.acos( buffer / a_mod_buf_sum )
					
				end	
			end
			a_mod_buf_sum = math.sqrt(a_mod_buf_sum * G) 
			buffer = a_mod_buf_sum*math.cos(a_angle_buf_sum) + ALL_OBJ[key].ACCEL.MODULE*math.cos(ALL_OBJ[key].ACCEL.ANGLE)
			ALL_OBJ[key].ACCEL.MODULE = math.sqrt( buffer^2 + (a_mod_buf_sum*math.sin(a_angle_buf_sum) + ALL_OBJ[key].ACCEL.MODULE*math.sin(ALL_OBJ[key].ACCEL.ANGLE))^2 )
			ALL_OBJ[key].ACCEL.ANGLE = math.acos( buffer / ALL_OBJ[key].ACCEL.MODULE )
		end
	end
end
