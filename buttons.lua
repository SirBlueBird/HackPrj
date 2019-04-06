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
guis = {}
guis.Buttons = {}

function ButtonCreate(x,y,xsize,ysize,text,textsize,font,func)
    local button = deepcopy(gui.Button)
    button.x=x
    button.y=y
    button.xsize=xsize
    button.ysize=ysize
    button.text=text
    button.textsize=textsize
    button.font=font
    button.func = func
    table.insert(Buttons,button)
    return button
end

--[[function Drawgui()
    for k,v in pairs do

    end]]