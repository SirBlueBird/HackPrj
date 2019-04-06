require "objects"
math.randomseed(os.time())

function NewOBJ( M, Str )

	OBJ_new = deepcopy(OBJ[Str])
	
	if Str == ASTEROID then
		OBJ_new.R = OBJ_new.R*math.random(1,50)
	end
	
	table.insert(M, OBJ_new)
end