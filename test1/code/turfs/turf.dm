turf
	//Destructability
	proc
		Clickedproc()
		Destroyedproc()
		Ghostclick()
	destroy()
		usr << "[name] breaks into smithereens!"
		view() << "[name] breaks into smitheens!"
		if(istype(loc,/area/overworld))
			new /turf/natural/floor/grass(locate(src.x,src.y,src.z))
		else if(istype(loc,/area/underground))
			new /turf/natural/floor/cave(locate(src.x,src.y,src.z))
		Destroyedproc()
		var/obj/items/materials/I = new src.material(locate(src.x,src.y,src.z))
		I.stack = 1
		del src
	var/repair = null
	var/destroy = null
	var/material = null
	var/edgelayer = 1
	var/edgetype = "grass"
	Click()
		usr.dir = get_dir(usr,src)
		if(usr.hands >= 2)
			if (get_dist(src,usr) <= 1)
				if(destructable == 1)
					var/i
					for(i in usr.holding.properties)
						if(i in src.destroy)
							hurtme(1)
					if(istype(usr.holding,repair))
						healme(1)
				Clickedproc()
		else if(istype(usr,/mob/ghost))
			Ghostclick()

	proc/turfsmooth()
		var/turf/N = locate(src.x,(src.y + 1),src.z)
		var/turf/E = locate((src.x + 1),src.y,src.z)
		var/turf/S = locate(src.x,(src.y - 1),src.z)
		var/turf/W = locate((src.x - 1),src.y,src.z)
		var/turf/NE = locate((src.x + 1),(src.y + 1),src.z)
		var/turf/NW = locate((src.x - 1),(src.y + 1),src.z)
		var/turf/SE = locate((src.x + 1),(src.y - 1),src.z)
		var/turf/SW = locate((src.x - 1),(src.y - 1),src.z)
		if(!(N.edgetype == null))
			if(N.edgelayer > src.edgelayer)
				src.overlays += new/image('icons/edges.dmi',icon_state = N.edgetype,dir = NORTH)
		if(!(E.edgetype == null))
			if(E.edgelayer > src.edgelayer)
				src.overlays += new/image('icons/edges.dmi',icon_state = E.edgetype,dir = EAST)
		if(!(S.edgetype == null))
			if(S.edgelayer > src.edgelayer)
				src.overlays += new/image('icons/edges.dmi',icon_state = S.edgetype,dir = SOUTH)
		if(!(W.edgetype == null))
			if(W.edgelayer > src.edgelayer)
				src.overlays += new/image('icons/edges.dmi',icon_state = W.edgetype,dir = WEST)
		if(!(NE.edgetype == null))
			if(NE.edgelayer > src.edgelayer)
				if(istype(N,NE.type))
					if(istype(E,NE.type))
						src.overlays += new/image('icons/edges.dmi',icon_state = NE.edgetype,dir = NORTHEAST)
		if(!(NW.edgetype == null))
			if(NW.edgelayer > src.edgelayer)
				if(istype(N,NW.type))
					if(istype(W,NW.type))
						src.overlays += new/image('icons/edges.dmi',icon_state = NW.edgetype,dir = NORTHWEST)
		if(!(SE.edgetype == null))
			if(SE.edgelayer > src.edgelayer)
				if(istype(S,SE.type))
					if(istype(E,SE.type))
						src.overlays += new/image('icons/edges.dmi',icon_state = SE.edgetype,dir = SOUTHEAST)
		if(!(SW.edgetype == null))
			if(SW.edgelayer > src.edgelayer)
				if(istype(S,SW.type))
					if(istype(W,SW.type))
						src.overlays += new/image('icons/edges.dmi',icon_state = SW.edgetype,dir = SOUTHWEST)