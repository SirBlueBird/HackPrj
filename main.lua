Timer = require 'Timer'
require 'stuff'
require 'buttons'
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
		--g_counter = Inc(g_counter)-- + 1 
	end)

	--testbutton = ButtonCreate(100,100,100,50,"TEST",BFont,function() g_counter = g_counter - 1 end, {255,255,255,255},{0,0,255,255},{255,255,255,255})
	upbtn = ButtonCreate(MAP.X-50,0,50,30,"UP",BFont, function() 
		if panel_index > 1 then
			panel_index=panel_index-1
			guis.DrawPanel = RemovePanel(guis.DrawPanel,panel_index)
			
			guis.DrapPanel = OpenPanel(guis.Obj,guis.DrawPanel,panel_index)
		end
	end,
		{0,0,0,255},{255,255,255,255},{0,0,0,255}
	)
	downbtn = ButtonCreate(MAP.X-50,30,50,30,"DOWN",BFont, function() 
		if panel_index < 4 then
			panel_index=panel_index+1
			guis.DrawPanel = RemovePanel(guis.Draw)
			
			guis.DrapPanel = OpenPanel(guis.Obj,guis.DrawPanel,panel_index)
		end
	end,
		{0,0,0,255},{255,255,255,255},{0,0,0,255}
	)
	panel = {}
	panel[1] = ButtonControlCreate(1,0,0,110,60,"Солнце",BFont, function() 
	--Пишите ваши функции сюда, ток сделайте менее наркоманскую инициализацию, лол
	end,
	{255,255,255,200},{255,255,255,0},{255,255,200}
	)
	panel[2] = ButtonControlCreate(1,110,0,110,60,"Меркурий",BFont, function() 
	
	end,
	{255,255,255,200},{255,255,255,0},{255,255,200}
	)
	panel[3] = ButtonControlCreate(1,220,0,110,60,"Венера",BFont, function() 
	
	end,
	{255,255,255,200},{255,255,255,0},{255,255,200}
	)
	panel[4] = ButtonControlCreate(1,330,0,110,60,"Земля",BFont, function() 
	
	end,
	{255,255,255,200},{255,255,255,0},{255,255,200}
	)
	panel[5] = ButtonControlCreate(1,440,0,110,60,"Марс",BFont, function() 
	
	end,
	{255,255,255,200},{255,255,255,0},{255,255,200}
	)--[[
	for i=1,4 do
		panel[i+panel_index-1] = ButtonControlCreate(i,0,110,60,i-1+panel_index,BFont, function() 
		--Пишите ваши функции сюда, ток сделайте менее наркоманскую инициализацию, лол
		end,
		{255,255,255,200},{0,0,0,150},{255,255,200}
		)
		panel[i+panel_index-1] = ButtonControlCreate(i,110,0,110,60,i-1+panel_index,BFont, function() 
		
		end,
		{255,255,255,200},{0,0,0,150},{255,255,200}
		)
		panel[i+panel_index-1] = ButtonControlCreate(i,220,0,110,60,i-1+panel_index,BFont, function() 
		
		end,
		{255,255,255,200},{0,0,0,150},{255,255,200}
		)
		panel[i+panel_index-1] = ButtonControlCreate(i,330,0,110,60,i-1+panel_index,BFont, function() 
		
		end,
		{255,255,255,200},{0,0,0,150},{255,255,200}
		)
	end]]
	for k,v in pairs(panel) do
		if v.index == panel_index then
		table.insert(guis.DrawPanel,v) end
		table.insert(guis.Obj,v)
	end
	table.insert(guis.Draw,upbtn)
	table.insert(guis.Obj,upbtn)
	table.insert(guis.Draw,downbtn)
	table.insert(guis.Obj,downbtn)	
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

function Inc(i) -- function is for internal test only
	i=i+1
	return i
end

function love.mousepressed(x, y, button, istouch)
	mousehandle(x,y,button,guis.Draw,guis.DrawPanel)
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
	Drawgui(guis.Draw,guis.DrawPanel)
	love.graphics.draw(OBJ.IMG, OBJ.X - OBJ.R, OBJ.Y - OBJ.R, 0, 0.25, 0.25)
	love.graphics.print(panel_index,0,0)
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