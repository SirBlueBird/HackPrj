require "objects"
math.randomseed(os.time())

function NewOBJ( M, OBJnum, Str )
	OBJnum = OBJnum+1
	M[OBJnum] = deepcopy(OBJ[Str])
	if Str == ASTEROID then
		M[OBJnum].R = M[OBJnum].R*math.random(1,50)
	end
	return M[OBJnum]
end