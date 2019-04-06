require "objects"
math.randomseed(os.time())

function NewOBJ( M, Str, x,y )
	local obj = deepcopy(OBJ[Str])
	obj.X = x 
	obj.Y = y

	--if Str == ASTEROID then
	--	OBJ_new.R = OBJ_new.R*math.random(1,50)
	--end
	table.insert(M, obj)
end