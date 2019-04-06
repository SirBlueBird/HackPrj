require "stuff"
gui = {}
gui.Button = {}
gui.Button.x=0
gui.Button.y=0
gui.Button.xsize=0
gui.Button.ysize=0
gui.Button.text=""
gui.Button.textsize=0
gui.Button.font=""
gui.Button.func = function() end
gui.Button.ocolor, gui.Button.ocolor, gui.Button.ocolor = {},{},{}


gui.ButtonControl = {}
deepcopy(gui.Button)
gui.ButtonControl.index = 0
--[[gui.ControlPanel = {}
gui.ControlPanel.x = 0
gui.ControlPanel.y = 0
gui.ControlPanel.w = 0
gui.ControlPanel.h = 0
gui.ControlPanel.n = 4 -- ITS LIKE CONST, NUMBER OF PANELS
gui.ControlPanel.active = 1
gui.ControlPanel.panels = {}
gui.ControlPanel.up = {}
gui.ControlPanel.down = {} --YOU HAVE TO INIT THEM BEFORE INITIALAZING CONTROL PANEL
--gui.ControlPanel.roll = {}

gui.Panel = {}
gui.Panel.index = 1
gui.Panel.x = 0
gui.Panel.y = 0
gui.Panel.w = 0
gui.Panel.h = 0
gui.Panel.n = 5 --CONST AGAIN
gui.Panel.Buttons = {}]]


--guis = {}
--guis.Buttons = {}
--guis.Panels = {}

--[[function CreateControlPanel(x,y,w,h,panels,up,down,roll)
    local control = deepcopy(gui.ControlPanel)
    control.x = x
    control.y = y
    control.w = w
    control.h = h
    local i = 1
    local 
    for i=1,control.n do
        CreatePanel()
    end
    control.panels = panels
    control.up = up
    control.down = down
    --ControlPanel.roll = roll insert???
    return control
end

function CreatePanel(x,y,w,h,index,buttons)
    local panel = deepcopy(gui.Panel)
    panel.x = x
    panel.y = y
    panel.w = w
    panel.h = h
    panel.index = index
    panel.Buttons = buttons
    return panel
end]]

function ButtonCreate(x,y,xsize,ysize,text,font,func,ocolor,fcolor,tcolor) --FONT
    local button = deepcopy(gui.Button)
    button.x=x
    button.y=y
    button.xsize=xsize
    button.ysize=ysize
    button.text=text
    button.font=font
    button.func = func
    button.ocolor = ocolor
    button.fcolor = fcolor
    button.tcolor = tcolor
    --table.insert(guis.Buttons,button)
    return button
end

function ButtonControlCreate(index,x,y,xsize,ysize,text,font,func,ocolor,fcolor,tcolor)
    local button = ButtonCreate(x,y,xsize,ysize,text,font,func,ocolor,fcolor,tcolor)
    button.index = index
    return button
end

function Drawgui(draw)
    for k,v in pairs(draw) do
        local r, g, b, a = love.graphics.getColor( )
        love.graphics.setColor(v.fcolor[1], v.fcolor[2], v.fcolor[3], v.fcolor[4])
        love.graphics.rectangle("fill", v.x, v.y, v.xsize, v.ysize)
        love.graphics.setColor(v.ocolor[1], v.ocolor[2], v.ocolor[3], v.ocolor[4])
        love.graphics.rectangle("line", v.x, v.y, v.xsize, v.ysize)
        local th = v.font:getHeight()
        local tx,ty = v.x, v.y+v.ysize/2-th/2
        love.graphics.setColor(v.tcolor[1], v.tcolor[2], v.tcolor[3], v.tcolor[4])
        love.graphics.printf(v.text,v.font,tx, ty, v.xsize,"center")
        love.graphics.setColor(r,g,b,a)
    end
end

function mousehandle(x,y,button,draw) --TODO: YOU CAN MAKE FOR MOBILE TOO, BUT DONT FORGET ISTOUCH()
    if button == 1 then
        for k,v in pairs(draw) do
            if (x>=v.x and x <= v.x+v.xsize) and (y>=v.y and y<=v.y+v.ysize) then
                v.func()
            end
        end   
    end
end