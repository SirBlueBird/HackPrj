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
	g_selected = nil
	g_time = 1;
	panel_index = 1
	timer = Timer()
	rollstate = false -- свернут

	--testbutton = ButtonCreate(100,100,100,50,"TEST",BFont,function() g_counter = g_counter - 1 end, {255,255,255,255},{0,0,255,255},{255,255,255,255})

	info = {}
	oc,fc,tc = {255,255,255,200},{0,0,255,0.3},{255,255,200} --GLOBAL COLOR STANDART, FOR SURE!
	local w,h = CAM.W/6, CAM.H/20
	info.exit = ButtonControlCreate(5,0,CAM.H-h,w,h,"Закрыть",BFont, function() guis.DrawPanel = Remove(guis.DrawPanel,5) end, oc,fc,tc)
	info.a = ButtonControlCreate(5,0,CAM.H-h*2,w*0.8,h,"Ускорение",BFont, function() end, oc,fc,tc)
	info.r = ButtonControlCreate(5,0,CAM.H-h*3,w*0.8,h,"Радиус",BFont, function() end, oc,fc,tc)
	info.m = ButtonControlCreate(5,0,CAM.H-h*4,w*0.8,h,"Масса",BFont, function() end, oc,fc,tc)
	info.label = ButtonControlCreate(5,0,CAM.H-h*5,w,h,"",BFont, function() end, oc,fc,tc)

	info.ainc = ButtonControlCreate(5,w*0.9,CAM.H-h*2,w*0.1,h,"+",BFont, function() end, oc,fc,tc) --ПЯТЬ ЭТО КОНТРОЛЬ 
	info.adec = ButtonControlCreate(5,w*0.8,CAM.H-h*2,w*0.1,h,"-",BFont, function() end, oc,fc,tc)
	info.rinc = ButtonControlCreate(5,w*0.9,CAM.H-h*3,w*0.1,h,"+",BFont, function() end, oc,fc,tc)
	info.rdec = ButtonControlCreate(5,w*0.8,CAM.H-h*3,w*0.1,h,"-",BFont, function() end, oc,fc,tc)
	info.minc = ButtonControlCreate(5,w*0.9,CAM.H-h*4,w*0.1,h,"+",BFont, function() end, oc,fc,tc)
	info.mdec = ButtonControlCreate(5,w*0.8,CAM.H-h*4,w*0.1,h,"-",BFont, function() end, oc,fc,tc)

	local w,h = CAM.W/12, CAM.H/40
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
			guis.DrawPanel = RemovePanel(guis.DrawPanel)--guis.DrawPanel = {}
			roll.text = "Open"
			roll.y=0
		end
	end,
	oc,fc,tc
	)
	
	upbtn = ButtonControlCreate(0,CAM.W-w,0,w,h,"UP",BFont, function() 
		if panel_index > 1 then
			panel_index=panel_index-1
			guis.DrawPanel = RemovePanel(guis.DrawPanel)
			
			guis.DrapPanel = OpenPanel(guis.Obj,guis.DrawPanel,panel_index)
		end
	end,
		oc,fc,tc
	)
	downbtn = ButtonControlCreate(0,CAM.W-w,h,w,h,"DOWN",BFont, function() 
		if panel_index < 2 then
			panel_index=panel_index+1
			guis.DrawPanel = RemovePanel(guis.DrawPanel)
			
			guis.DrapPanel = OpenPanel(guis.Obj,guis.DrawPanel,panel_index)
		end
	end,
		oc,fc,tc
	)
	local panel = {}
	local w = CAM.W/(600/110) local h = CAM.H/(20)
	
	panel[1] = ButtonControlCreate(1,0,0,w,h,"Солнце",BFont, function() 
		NewOBJ(ALL_OBJ, "SUN")
		OBJ_selected = #ALL_OBJ
		OBJ_grabbed = true
	end,
	oc,fc,tc
	)
	panel[2] = ButtonControlCreate(1,w,0,w,h,"Меркурий",BFont, function() 
		NewOBJ(ALL_OBJ, "MERCURY")
		OBJ_selected = #ALL_OBJ
		OBJ_grabbed = true
	end,
	oc,fc,tc
	)
	panel[3] = ButtonControlCreate(1,w*2,0,w,h,"Венера",BFont, function() 
		NewOBJ(ALL_OBJ, "VENUS")
		OBJ_selected = #ALL_OBJ
		OBJ_grabbed = true
	end,
	oc,fc,tc
	)
	panel[4] = ButtonControlCreate(1,w*3,0,w,h,"Земля",BFont, function() 
		NewOBJ(ALL_OBJ, "EARTH")
		OBJ_selected = #ALL_OBJ
		OBJ_grabbed = true
	end,
	oc,fc,tc
	)
	panel[5] = ButtonControlCreate(1,w*4,0,w,h,"Марс",BFont, function() 
		NewOBJ(ALL_OBJ, "MARS")
		OBJ_selected = #ALL_OBJ
		OBJ_grabbed = true
	end,
	oc,fc,tc
	)
	--===
	panel[6] = ButtonControlCreate(2,0,0,w,h,"Юпитер",BFont, function() 
		NewOBJ(ALL_OBJ, "JUPITER")
		OBJ_selected = #ALL_OBJ
		OBJ_grabbed = true
	end,
	oc,fc,tc
	)
	panel[7] = ButtonControlCreate(2,w,0,w,h,"Сатурн",BFont, function() 
		NewOBJ(ALL_OBJ, "SATURN")
		OBJ_selected = #ALL_OBJ
		OBJ_grabbed = true
	end,
	oc,fc,tc
	)
	panel[8] = ButtonControlCreate(2,w*2,0,w,h,"Уран",BFont, function() 
		NewOBJ(ALL_OBJ, "URANUS")
		OBJ_selected = #ALL_OBJ
		OBJ_grabbed = true
	end,
	oc,fc,tc
	)
	panel[9] = ButtonControlCreate(2,w*3,0,w,h,"Нептун",BFont, function() 
		NewOBJ(ALL_OBJ, "NEPTUNE")
		OBJ_selected = #ALL_OBJ
		OBJ_grabbed = true
	end,
	oc,fc,tc
	)
	panel[10] = ButtonControlCreate(2,w*4,0,w,h,"SPACEMAN",BFont, function() 
		
	end,
	oc,fc,tc
	)
	for k,v in pairs(panel) do
		table.insert(guis.Obj,v)
	end
	for k,v in pairs(info) do
		table.insert(guis.Obj,v)
		--table.insert(guis.DrawPanel,v)
	end
	table.insert(guis.Obj,upbtn)
	table.insert(guis.Obj,downbtn)
	table.insert(guis.Draw,roll)
	table.insert(guis.Obj,roll)
---------------------------------------------------------------------------
	
	--[[Stars = {}
	for i = 1, 10000 do
		local star = {}
		star.x = math.random(1, MAP.X)
		star.y = math.random(1, MAP.Y)
		star.visible = true
		table.insert(Stars,star)
	end--]]
	
	love.window.setMode(CAM.W, CAM.H)
	
	ALL_OBJ = {}
	OBJ_selected = -1
	OBJ_grabbed = false
	
	G = 7*10^-7
	A_MIN = 2*10^-6
	
end

function love.update(dt)

	Mouse_X = love.mouse.getX() + CAM.X
	Mouse_Y = love.mouse.getY() + CAM.Y
	
	PosUpdate()
	SpeedUpdate()
	AccelUpdate()
	
	if love.keyboard.isDown("s") and not(OBJ_selected == -1) then	
		ALL_OBJ[OBJ_selected].SPEED.MODULE = 0
		ALL_OBJ[OBJ_selected].SPEED.ANGLE = 0
		ALL_OBJ[OBJ_selected].ACCEL.MODULE = 0
		ALL_OBJ[OBJ_selected].ACCEL.ANGLE = 0
	end
	
	if OBJ_grabbed then
		ALL_OBJ[OBJ_selected].SPEED.MODULE = 0
		ALL_OBJ[OBJ_selected].SPEED.ANGLE = 0
		ALL_OBJ[OBJ_selected].ACCEL.MODULE = 0
		ALL_OBJ[OBJ_selected].ACCEL.ANGLE = 0
			
		ALL_OBJ[OBJ_selected].X = Mouse_X
		ALL_OBJ[OBJ_selected].Y = Mouse_Y		
	end

	CAM_VIEW()
end

function love.draw()

	--[[for k,v in pairs(Stars) do
		love.graphics.points(v.x-CAM.X, v.y-CAM.Y)
	end--]]
	

	for key, value in pairs(ALL_OBJ) do
		love.graphics.draw(ALL_OBJ[key].IMG, (ALL_OBJ[key].X - ALL_OBJ[key].R - CAM.X), (ALL_OBJ[key].Y - ALL_OBJ[key].R - CAM.Y))
	end
	
	love.graphics.print( CAM.X, 10, 70)
	love.graphics.print( CAM.Y, 10, 80)
	
	Drawgui(guis.Draw,guis.DrawPanel)
end

function love.mousepressed(x, y, button, istouch)
	mousehandle(x,y,button,guis.Draw,guis.DrawPanel)

	for key, value in pairs(ALL_OBJ) do
		if math.sqrt( (Mouse_X - ALL_OBJ[key].X)^2 + (Mouse_Y - ALL_OBJ[key].Y)^2 ) <= ALL_OBJ[key].R then
			local obj = ALL_OBJ[key]
			guis.DrawPanel = Remove(guis.DrawPanel,5)
			Open(guis.Obj,guis.DrawPanel,5)
			info.label.text = obj.title

		end
	end
	
	if not(OBJ_grabbed) then
		for key, value in pairs(ALL_OBJ) do
			if math.sqrt( (Mouse_X - ALL_OBJ[key].X)^2 + (Mouse_Y - ALL_OBJ[key].Y)^2 ) <= ALL_OBJ[key].R then 
				if (OBJ_selected == -1) or not(OBJ_selected == key) then
					OBJ_selected = key
				end
			end
		end
	end
	if (button == 1) and not(OBJ_selected == -1) and (math.sqrt( (Mouse_X - ALL_OBJ[OBJ_selected].X)^2 + (Mouse_Y - ALL_OBJ[OBJ_selected].Y)^2 ) <= ALL_OBJ[OBJ_selected].R)  then 
		OBJ_grabbed = not(OBJ_grabbed)
	end
end

function love.keyreleased(key) 
	if key == "c" then
		NewOBJ(ALL_OBJ, "EARTH")
	elseif key == "escape" then 
		os.exit()
	end
end

function PosUpdate()
	for key, value in pairs(ALL_OBJ) do
		ALL_OBJ[key].X = ALL_OBJ[key].X + ALL_OBJ[key].SPEED.MODULE * math.cos(ALL_OBJ[key].SPEED.ANGLE)
		ALL_OBJ[key].Y = ALL_OBJ[key].Y + ALL_OBJ[key].SPEED.MODULE * math.sin(ALL_OBJ[key].SPEED.ANGLE)
	end
end

function SpeedUpdate()
	for key, value in pairs(ALL_OBJ) do 
		ALL_OBJ[key].SPEED.MODULE, ALL_OBJ[key].SPEED.ANGLE = VectSum(ALL_OBJ[key].SPEED, ALL_OBJ[key].ACCEL)
	end
end

function AccelUpdate()
	if not(#ALL_OBJ == 1) then
		local Acc_buf = deepcopy(VECT)
		local Acc_sum = deepcopy(VECT)
		for key, value in pairs(ALL_OBJ) do
			Acc_sum.MODULE, Acc_sum.ANGLE = 0, 0
			for i, j in pairs(ALL_OBJ) do
				if not(key == i) and not(OBJ_selected == i) then
					Acc_buf.MODULE, Acc_buf.ANGLE = PointsToVect( ALL_OBJ[key], ALL_OBJ[i] )
					Acc_sum.MODULE, Acc_sum.ANGLE = VectSum( Acc_sum, Acc_buf)
				end
			end
			Acc_sum.MODULE = math.sqrt(Acc_sum.MODULE * G)
			if key == OBJ_selected then 
				print(Acc_sum.MODULE)
			end
			if not(Acc_sum.MODULE <= A_MIN) then
				ALL_OBJ[key].ACCEL.MODULE, ALL_OBJ[key].ACCEL.ANGLE = VectSum( ALL_OBJ[key].ACCEL, Acc_sum )
			end
		end
	end
end

function VectSum(N, K)
	local R = deepcopy(VECT)
	R.MODULE = math.sqrt( (N.MODULE*math.cos(N.ANGLE) + K.MODULE*math.cos(K.ANGLE))^2 + (N.MODULE*math.sin(N.ANGLE) + K.MODULE*math.sin(K.ANGLE))^2 )
	if not(R.MODULE == 0) then 
		R.ANGLE = math.acos( (N.MODULE*math.cos(N.ANGLE) + K.MODULE*math.cos(K.ANGLE)) / R.MODULE ) 
		if (N.MODULE*math.sin(N.ANGLE) + K.MODULE*math.sin(K.ANGLE)) < 0 then
			R.ANGLE = -R.ANGLE
		end
	end
	
	return R.MODULE, R.ANGLE
end

function PointsToVect(N, K)
	local R = deepcopy(VECT)
	local L = math.sqrt(( K.X - N.X )^2 + ( K.Y - N.Y )^2)
	R.MODULE = N.MASS/ L^2
	if not(R.MODULE == 0) then 
		R.ANGLE = math.acos( ( K.X - N.X) / L ) 
		if (K.Y - N.Y) < 0 then
			R.ANGLE = -R.ANGLE
		end
	end
	
	return R.MODULE, R.ANGLE
end