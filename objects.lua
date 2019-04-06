
math.randomseed(os.time())

--/*~---------------------------~*\--
function deepcopy(orig)
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
--\*~---------------------------~*/--
VECT = {}
	VECT.ANGLE = 0
	VECT.MODULE = 0

OBJ = {} 
--масса равна массе * 10^22
OBJ.EARTH = {}
	OBJ.EARTH.R = 36
	OBJ.EARTH.X = 0
	OBJ.EARTH.Y = 0
	OBJ.EARTH.MASS = 597 
	OBJ.EARTH.SPEED = deepcopy(VECT)
	OBJ.EARTH.ACCEL = deepcopy(VECT)
	OBJ.EARTH.IMG = love.graphics.newImage("шар.png")

OBJ.MOON = {}
	OBJ.MOON.R = OBJ.EARTH.R/3.67
	OBJ.MOON.X = 0
	OBJ.MOON.Y = 0
	OBJ.MOON.MASS = 7.35
	OBJ.MOON.SPEED = deepcopy(VECT)
	OBJ.MOON.ACCEL = deepcopy(VECT)
	OBJ.MOON.IMG = love.graphics.newImage("шар.png")

OBJ.SUN = {}
	OBJ.SUN.R = OBJ.EARTH.R*109
	OBJ.SUN.X = 0
	OBJ.SUN.Y = 0
	OBJ.SUN.MASS = 2*(10^8)
	OBJ.SUN.SPEED = deepcopy(VECT)
	OBJ.SUN.ACCEL = deepcopy(VECT)
	OBJ.SUN.IMG = love.graphics.newImage("icons/kissun.png")

OBJ.MERCURY = {}
	OBJ.MERCURY.R = OBJ.EARTH.R*0.3829
	OBJ.MERCURY.X = 0
	OBJ.MERCURY.Y = 0
	OBJ.MERCURY.MASS = 33
	OBJ.MERCURY.SPEED = deepcopy(VECT)
	OBJ.MERCURY.ACCEL = deepcopy(VECT)
	OBJ.MERCURY.IMG = love.graphics.newImage("шар.png")

OBJ.VENUS = {}
	OBJ.VENUS.R = OBJ.EARTH.R*0.9499
	OBJ.VENUS.X = 0
	OBJ.VENUS.Y = 0
	OBJ.VENUS.MASS = 486
	OBJ.VENUS.SPEED = deepcopy(VECT)
	OBJ.VENUS.ACCEL = deepcopy(VECT)
	OBJ.VENUS.IMG = love.graphics.newImage("шар.png")

OBJ.MARS = {}
	OBJ.MARS.R = OBJ.EARTH.R*0.5315
	OBJ.MARS.X = 0
	OBJ.MARS.Y = 0
	OBJ.MARS.MASS = 64.171
	OBJ.MARS.SPEED = deepcopy(VECT)
	OBJ.MARS.ACCEL = deepcopy(VECT)
	OBJ.MARS.IMG = love.graphics.newImage("шар.png")

OBJ.JUPITER = {}
	OBJ.JUPITER.R = OBJ.EARTH.R*11.22
	OBJ.JUPITER.X = 0
	OBJ.JUPITER.Y = 0
	OBJ.JUPITER.MASS = 18986
	OBJ.JUPITER.SPEED = deepcopy(VECT)
	OBJ.JUPITER.ACCEL = deepcopy(VECT)
	OBJ.JUPITER.IMG = love.graphics.newImage("шар.png")

OBJ.SATURN = {}
	OBJ.SATURN.R = OBJ.EARTH.R*9.4597
	OBJ.SATURN.X = 0
	OBJ.SATURN.Y = 0
	OBJ.SATURN.MASS = 5684.6
	OBJ.SATURN.SPEED = deepcopy(VECT)
	OBJ.SATURN.ACCEL = deepcopy(VECT)
	OBJ.SATURN.IMG = love.graphics.newImage("шар.png")

OBJ.URANUS = {}
	OBJ.URANUS.R = OBJ.EARTH.R*3.981
	OBJ.URANUS.X = 0
	OBJ.URANUS.Y = 0
	OBJ.URANUS.MASS = 868.32
	OBJ.URANUS.SPEED = deepcopy(VECT)
	OBJ.URANUS.ACCEL = deepcopy(VECT)
	OBJ.URANUS.IMG = love.graphics.newImage("шар.png")

OBJ.NEPTUNE = {}
	OBJ.NEPTUNE.R = OBJ.EARTH.R * 3.8647
	OBJ.NEPTUNE.X = 0
	OBJ.NEPTUNE.Y = 0
	OBJ.NEPTUNE.MASS = 1024.3
	OBJ.NEPTUNE.SPEED = deepcopy(VECT)
	OBJ.NEPTUNE.ACCEL = deepcopy(VECT)
	OBJ.NEPTUNE.IMG = love.graphics.newImage("шар.png")

OBJ.PLUTO = {}
	OBJ.PLUTO.R = OBJ.EARTH.R*0.1863
	OBJ.PLUTO.X = 0
	OBJ.PLUTO.Y = 0
	OBJ.PLUTO.MASS = 1.303
	OBJ.PLUTO.SPEED = deepcopy(VECT)
	OBJ.PLUTO.ACCEL = deepcopy(VECT)
	OBJ.PLUTO.IMG = love.graphics.newImage("шар.png")

OBJ.DEIMOS = {}
	OBJ.DEIMOS.R = OBJ.EARTH.R*508.46
	OBJ.DEIMOS.X = 0
	OBJ.DEIMOS.Y = 0
	OBJ.DEIMOS.MASS = 1.48/(10^7)
	OBJ.DEIMOS.SPEED = deepcopy(VECT)
	OBJ.DEIMOS.ACCEL = deepcopy(VECT)
	OBJ.DEIMOS.IMG = love.graphics.newImage("шар.png")

OBJ.PHOBOS = {}
	OBJ.PHOBOS.R = OBJ.EARTH.R*573.964
	OBJ.PHOBOS.X = 0
	OBJ.PHOBOS.Y = 0
	OBJ.PHOBOS.MASS = 1.072/(10^8)
	OBJ.PHOBOS.SPEED = deepcopy(VECT)
	OBJ.PHOBOS.ACCEL = deepcopy(VECT)
	OBJ.PHOBOS.IMG = love.graphics.newImage("шар.png")

OBJ.ASTEROID = {}
	OBJ.ASTEROID.R = OBJ.EARTH.R/6371
	OBJ.ASTEROID.X = 0
	OBJ.ASTEROID.Y = 0
	OBJ.ASTEROID.MASS = 1.333*math.pi*(OBJ.ASTEROID.R^3)*3500/(10^22)
	OBJ.ASTEROID.SPEED = deepcopy(VECT)
	OBJ.ASTEROID.ACCEL = deepcopy(VECT)
	OBJ.ASTEROID.IMG = love.graphics.newImage("шар.png")

OBJ.STAR = {}
	OBJ.STAR.R = OBJ.EARTH.R/100
	OBJ.STAR.X = 0
	OBJ.STAR.Y = 0
	OBJ.STAR.MASS = 0.08*OBJ.SUN.MASS
	OBJ.STAR.SPEED = deepcopy(VECT)
	OBJ.STAR.ACCEL = deepcopy(VECT)
	OBJ.STAR.IMG = love.graphics.newImage("шар.png")

OBJ.BLACKHOLE = {}
	OBJ.BLACKHOLE.R = OBJ.EARTH.R/100
	OBJ.BLACKHOLE.X = 0
	OBJ.BLACKHOLE.Y = 0
	OBJ.BLACKHOLE.MASS = 50*OBJ.SUN.MASS
	OBJ.BLACKHOLE.SPEED = deepcopy(VECT)
	OBJ.BLACKHOLE.ACCEL = deepcopy(VECT)
	OBJ.BLACKHOLE.IMG = love.graphics.newImage("шар.png")

OBJ.COMET = {}
	OBJ.COMET.R = OBJ.EARTH.R/100
	OBJ.COMET.X = 0
	OBJ.COMET.Y = 0
	OBJ.COMET.MASS = OBJ.EARTH.MASS/1000000000
	OBJ.COMET.SPEED = deepcopy(VECT)
	OBJ.COMET.ACCEL = deepcopy(VECT)
	OBJ.COMET.IMG = love.graphics.newImage("шар.png")

OBJ.METEORITE = {}
	OBJ.METEORITE.R = OBJ.ASTEROID.R/10
	OBJ.METEORITE.X = 0
	OBJ.METEORITE.Y = 0
	OBJ.METEORITE.MASS = OBJ.EARTH.MASS/1000000000
	OBJ.METEORITE.SPEED = deepcopy(VECT)
	OBJ.METEORITE.ACCEL = deepcopy(VECT)
	OBJ.METEORITE.IMG = love.graphics.newImage("шар.png")

OBJ.ROCKET = {}
	OBJ.ROCKET.WIDTH = OBJ.EARTH.R/1500
	OBJ.ROCKET.HEIGTH = OBJ.ROCKET.WIDTH * 5
	OBJ.ROCKET.X = 0
	OBJ.ROCKET.Y = 0
	OBJ.ROCKET.MASS = 2.8/(10^16)
	OBJ.ROCKET.SPEED = deepcopy(VECT)
	OBJ.ROCKET.ACCEL = deepcopy(VECT)
	OBJ.ROCKET.IMG = love.graphics.newImage("шар.png")

OBJ.DEATHSTAR = {}
	OBJ.DEATHSTAR.R = OBJ.MOON.R/2
	OBJ.DEATHSTAR.X = 0
	OBJ.DEATHSTAR.Y = 0
	OBJ.DEATHSTAR.MASS = OBJ.MOON.MASS/2
	OBJ.DEATHSTAR.SPEED = deepcopy(VECT)
	OBJ.DEATHSTAR.ACCEL = deepcopy(VECT)
	OBJ.DEATHSTAR.IMG = love.graphics.newImage("шар.png")
	