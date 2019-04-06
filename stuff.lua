function deepcopy(orig) --Наследование
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function ChangeTime(timer,time,func,count) --Функция переопределяет время таймера(timer) на новое время (time), а также заменяет функцию (func), count опционален
    timer:destroy()                         -- чтобы ничего не сломалось, не забудьте назначить её таймеру
    timer = Timer()
    count = count or -1
    if count == -1 then
        timer:every(time, function()
            func()-- + 1 
        end)
    else
        timer:every(time, function()
            func()
        end,
    count)
    end
    return timer
end

function OpenPanel(buttons,draw,index)
    for k,v in pairs(buttons) do
        if v.index == index or v.index == 0 then
            table.insert(draw,v)
        end
    end
    return draw
end

function RemovePanel(buttons)
    panel = {}
    return panel
end

function destruct()
    return nil
end