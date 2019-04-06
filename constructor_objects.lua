require "objects"
math.randomseed(os.time())

function NewOBJ( x,y , M, Str )
	local obj = deepcopy(OBJ[Str])
	obj.x = x 
	obj.y = y

	--if Str == ASTEROID then
	--	OBJ_new.R = OBJ_new.R*math.random(1,50)
	--end
	
	table.insert(M, obj)
end