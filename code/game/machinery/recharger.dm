obj/machinery/recharger
	anchored = 1.0
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "recharger0"
	name = "recharger"

	var
		obj/item/weapon/gun/energy/charging = null
		obj/item/weapon/baton/charging2 = null
		obj/item/weapon/cargotele/charging3 = null
		obj/item/weapon/pickaxe/powered/charging4 = null
		obj/item/weapon/powerhammer/charging5 = null

/obj/machinery/recharger/attackby(obj/item/weapon/G as obj, mob/user as mob)
	if (src.charging || src.charging2)
		return
	if (istype(G, /obj/item/weapon/gun/energy))
		if (istype(G, /obj/item/weapon/gun/energy/laser_gun/captain))
			user << "\red The recharging port is too big!"
		else
			user.drop_item()
			G.loc = src
			src.charging = G
	if (istype(G, /obj/item/weapon/baton))
		user.drop_item()
		G.loc = src
		src.charging2 = G
	if (istype(G, /obj/item/weapon/cargotele))
		user.drop_item()
		G.loc = src
		src.charging3 = G
	if (istype(G, /obj/item/weapon/pickaxe/powered))
		user.drop_item()
		G.loc = src
		src.charging4 = G
	if (istype(G, /obj/item/weapon/powerhammer))
		user.drop_item()
		G.loc = src
		src.charging5 = G

/obj/machinery/recharger/attack_hand(mob/user as mob)
	src.add_fingerprint(user)
	if (src.charging)
		src.charging.update_icon()
		src.charging.loc = src.loc
		src.charging = null
	if(src.charging2)
	//	src.charging2.update_icon()
		src.charging2.loc = src.loc
		src.charging2 = null
	if (src.charging3)
		src.charging3.loc = src.loc
		src.charging3 = null
	if (src.charging4)
		src.charging4.loc = src.loc
		src.charging4 = null
	if (src.charging5)
		src.charging5.loc = src.loc
		src.charging5 = null


/obj/machinery/recharger/attack_paw(mob/user as mob)
	if ((ticker && ticker.mode.name == "monkey"))
		return src.attack_hand(user)

/obj/machinery/recharger/process()
	if ((src.charging) && ! (stat & NOPOWER) )
		if (src.charging.charges < src.charging.maximum_charges)
			src.charging.charges++
			src.icon_state = "recharger1"
			use_power(250)
		else
			src.icon_state = "recharger2"
	if ((src.charging2) && ! (stat & NOPOWER) )
		if (src.charging2.charges < src.charging2.maximum_charges)
			src.charging2.charges++
			src.icon_state = "recharger1"
			use_power(250)
		else
			src.icon_state = "recharger2"
	if ((src.charging3) && ! (stat & NOPOWER) )
		if (src.charging3.charges < src.charging3.maximum_charges)
			src.charging3.charges++
			src.charging3.desc = "A device for teleporting crated goods. [src.charging3.charges] charges remain."
			src.icon_state = "recharger1"
			use_power(250)
		else
			src.icon_state = "recharger2"
	if ((src.charging4) && ! (stat & NOPOWER) )
		if (src.charging4.charges < src.charging4.maximum_charges)
			src.charging4.charges++
			src.charging4.desc = "An energised mining tool. It has 15 charges left."
			src.icon_state = "recharger1"
			use_power(250)
		else
			src.icon_state = "recharger2"
	if ((src.charging5) && ! (stat & NOPOWER) )
		if (src.charging5.charges < src.charging5.maximum_charges)
			src.charging5.charges++
			src.charging5.desc = "An energised mining tool. It has 30 charges left."
			src.icon_state = "recharger1"
			use_power(250)
		else
			src.icon_state = "recharger2"
	else if (!(src.charging || src.charging2 || src.charging3 || src.charging4 || src.charging5))
		src.icon_state = "recharger0"