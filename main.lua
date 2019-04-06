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
	
	Stars = {}
	for i = 1, 10000 do
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
	A_MIN = 2*10^-6
	
end

function love.update(dt)

	Mouse_X = love.mouse.getX() + CAM.X
	Mouse_Y = love.mouse.getY() + CAM.Y
	
	PosUpdate()
	SpeedUpdate()
	AccelUpdate()
	
	if love.keyboard.isDown("s") then	
		if not(OBJ_selected == -1) then
			ALL_OBJ[OBJ_selected].SPEED.MODULE = 0
			ALL_OBJ[OBJ_selected].SPEED.ANGLE = 0
			ALL_OBJ[OBJ_selected].ACCEL.MODULE = 0
			ALL_OBJ[OBJ_selected].ACCEL.ANGLE = 0
		end
	elseif love.keyboard.isDown("a") then	
		if not(OBJ_selected == -1) then
			ALL_OBJ[OBJ_selected].ACCEL.MODULE = 0
			ALL_OBJ[OBJ_selected].ACCEL.ANGLE = 0
		end
	end
	
	if love.mouse.isDown(2) then
		
		for key, value in pairs(ALL_OBJ) do
			if math.sqrt( (Mouse_X - ALL_OBJ[key].X)^2 + (Mouse_Y - ALL_OBJ[key].Y)^2 ) <= ALL_OBJ[key].R then 
				if (OBJ_selected == -1) or not(OBJ_selected == key) then
					OBJ_selected = key
				end
			end
		end
	elseif love.mouse.isDown(1) then
		if not(table.getn(ALL_OBJ) == 0) and  not(OBJ_selected == -1) then
			ALL_OBJ[OBJ_selected].SPEED.MODULE = 0
			ALL_OBJ[OBJ_selected].SPEED.ANGLE = 0
				
			ALL_OBJ[OBJ_selected].X = Mouse_X
			ALL_OBJ[OBJ_selected].Y = Mouse_Y
				--[[ALL_OBJ[OBJ_selected].SPEED.MODULE = 2
				ALL_OBJ[OBJ_selected].SPEED.ANGLE = math.acos( (Mouse_X - ALL_OBJ[OBJ_selected].X) / math.sqrt( (Mouse_X - ALL_OBJ[OBJ_selected].X)^2 + (Mouse_Y - ALL_OBJ[OBJ_selected].Y)^2 ) )
				if (Mouse_Y - ALL_OBJ[OBJ_selected].Y) < 0 then
					ALL_OBJ[OBJ_selected].SPEED.ANGLE = -ALL_OBJ[OBJ_selected].SPEED.ANGLE
				end--]]
				
		end
	end
	--[[elseif (love.mouse.isDown(2)) and not(OBJ_selected == -1) then
		ALL_OBJ[OBJ_selected].ACCEL.MODULE = .1
		ALL_OBJ[OBJ_selected].ACCEL.ANGLE = math.acos( (Mouse_X - ALL_OBJ[OBJ_selected].X) / math.sqrt( (Mouse_X - ALL_OBJ[OBJ_selected].X)^2 + (Mouse_Y - ALL_OBJ[OBJ_selected].Y)^2 ) )
		if (Mouse_Y - ALL_OBJ[OBJ_selected].Y) < 0 then
			ALL_OBJ[OBJ_selected].ACCEL.ANGLE = -ALL_OBJ[OBJ_selected].ACCEL.ANGLE
		end--]]
	
	CAM_VIEW()
end

function love.draw()

	for k,v in pairs(Stars) do
		love.graphics.points(v.x-CAM.X, v.y-CAM.Y)
	end
	

	for key, value in pairs(ALL_OBJ) do
		love.graphics.draw(ALL_OBJ[key].IMG, (ALL_OBJ[key].X - ALL_OBJ[key].R - CAM.X), (ALL_OBJ[key].Y - ALL_OBJ[key].R - CAM.Y))
	end
	
	love.graphics.print( OBJ_selected, 400, 70)

	
	love.graphics.print( CAM.X, 10, 70)
	love.graphics.print( CAM.Y, 10, 80)
	
	Drawgui(guis.Draw,guis.DrawPanel)
end

function love.mousepressed(x, y, button, istouch)
	mousehandle(x,y,button,guis.Draw,guis.DrawPanel)
end

function love.keyreleased(key) 
	if key == "c" then
		NewOBJ(ALL_OBJ, "EARTH")
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
				if not(key == i) then
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