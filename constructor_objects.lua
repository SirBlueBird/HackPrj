require "objects"
math.randomseed(os.time())

function NewOBJ( M, Str, x,y )
	local obj = deepcopy(OBJ[Str])

	if not(x) and not(y) then
		obj.X = obj.R
		obj.Y = obj.R
	else
		obj.X = x 
		obj.Y = y
	end
	
	--if Str == ASTEROID then
	--	OBJ_new.R = OBJ_new.R*math.random(1,50)
	--end
	table.insert(M, obj)
end