// OMG SHOES

//defines in setup.dm:
//LACES_NORMAL 0, LACES_TIED 1, LACES_CUT 2, LACES_NONE -1

/obj/item/clothing/shoes
	name = "shoes"
	icon = 'icons/obj/clothing/item_shoes.dmi'
	inhand_image_icon = 'icons/mob/inhand/hand_feethand.dmi'
	wear_image_icon = 'icons/mob/feet.dmi'
	var/chained = 0
	var/laces = LACES_NORMAL // Laces for /obj/item/gun/energy/pickpocket harass mode.
	var/kick_bonus = 0 //some shoes will yield extra kick damage!
	compatible_species = list("human", "monkey")
	protective_temperature = 500
	permeability_coefficient = 0.50
		//cogwerks - burn vars
	burn_point = 400
	burn_output = 800
	burn_possible = 1
	health = 25

	var/step_sound = "step_default"
	var/step_priority = STEP_PRIORITY_NONE
	var/step_lots = 0 //classic steps (used for clown shoos)

	var/speedy = 0 		//for industrial booties, to avoid type checks on shoe
	var/tripsalot = 0 	//for clown shooties, to avoid type checks on shoe
	var/magnetic = 0    //for magboots, to avoid type checks on shoe

	setupProperties()
		..()
		setProperty("coldprot", 5)
		setProperty("heatprot", 5)

	get_desc(dist)
		..()
		if (dist < 1) // on our tile or our person
			if (.) // we're returning something
				. += " " // add a space
			switch (src.laces)
				if (LACES_TIED)
					. += "The laces are tied."
				if (LACES_CUT)
					. += "The laces are cut."

	attackby(obj/item/W as obj, mob/user as mob)
		if (istype(W, /obj/item/tank/air) || istype(W, /obj/item/tank/oxygen) || istype(W, /obj/item/tank/emergency_oxygen) || istype(W, /obj/item/tank/jetpack))
			var/uses = 0

			if(istype(W, /obj/item/tank/emergency_oxygen)) uses = 2
			else if(istype(W, /obj/item/tank/air)) uses = 4
			else if(istype(W, /obj/item/tank/oxygen)) uses = 4
			else if(istype(W, /obj/item/tank/jetpack)) uses = 6

			var/turf/T = get_turf(user)
			var/obj/item/clothing/shoes/rocket/R = new/obj/item/clothing/shoes/rocket(T)
			R.uses = uses
			boutput(user, "<span style=\"color:blue\">You haphazardly kludge together some rocket shoes.</span>")
			qdel(W)
			qdel(src)

		if (src.laces == LACES_TIED && istool(W, TOOL_CUTTING | TOOL_SNIPPING))
			boutput(user, "You neatly cut the knot and most of the laces away. Problem solved forever!")
			src.laces = LACES_CUT

/obj/item/clothing/shoes/rocket
	name = "rocket shoes"
	desc = "A gas tank taped to some shoes. Brilliant. They also look kind of silly."
	icon_state = "rocketshoes"
	protective_temperature = 0
	var/uses = 6
	var/emagged = 0
	burn_possible = 0
	module_research = list("efficiency" = 10)
	step_sound = "step_plating"
	step_priority = STEP_PRIORITY_LOW

	setupProperties()
		..()
		setProperty("movespeed", 1)

	emag_act(var/mob/user, var/obj/item/card/emag/E)
		if (!src.emagged)
			if (user)
				user.show_text("You swipe the card over the pressure regulator, breaking it.", "blue")
			src.emagged = 1
			src.desc += " Something seems to be wrong with them, though."
			return 1
		else
			if (user)
				user.show_text("The regulator seems to have already been tampered with.", "red")
			return 0

	demag(var/mob/user)
		if (!src.emagged)
			return 0
		else
			if (user)
				user.show_text("You repair the pressure regulator on the [src].", "blue")
			src.emagged = 0
			src.desc = "A gas tank taped to some shoes. Brilliant. They also look kind of silly."
			return 1


/obj/item/clothing/shoes/rocket/abilities = list(/obj/ability_button/shoerocket)

/obj/item/clothing/shoes/sonic
	name = "Sahnic the Bushpig's Shoes"
	icon_state = "red"
	desc = "Have got to go swiftly."
	var/soniclevel = 9.999
	var/soniclength = 50
	var/sonicbreak = 0
	protective_temperature = 1500

	setupProperties()
		..()
		setProperty("movespeed", -10)

/obj/item/clothing/shoes/sonic/abilities = list(/obj/ability_button/sonic)

/obj/item/clothing/shoes/black
	name = "black shoes"
	icon_state = "black"
	desc = "These shoes somewhat protect you from fire."
	protective_temperature = 1500

	setupProperties()
		..()
		setProperty("heatprot", 7)

/obj/item/clothing/shoes/brown
	name = "brown shoes"
	icon_state = "brown"
	desc = "Brown shoes, camouflage on this kind of station."

/obj/item/clothing/shoes/red
	name = "red shoes"
	icon_state = "red"

/obj/item/clothing/shoes/blue
	name = "blue shoes"
	icon_state = "blu"

/obj/item/clothing/shoes/orange
	name = "orange shoes"
	icon_state = "orange"
	uses_multiple_icon_states = 1
	desc = "Shoes, now in prisoner orange! Can be made into shackles."

/obj/item/clothing/shoes/pink
	name = "pink shoes"
	icon_state = "pink"

/obj/item/clothing/shoes/orange/attack_self(mob/user as mob)
	if (src.chained)
		src.chained = null
		src.cant_self_remove = 0
		new /obj/item/handcuffs(get_turf(user))
		src.name = "orange shoes"
		src.icon_state = "orange"
		src.desc = "Shoes, now in prisoner orange! Can be made into shackles."
	return

/obj/item/clothing/shoes/orange/attackby(H as obj, loc)
	if (istype(H, /obj/item/handcuffs) && !src.chained)
		qdel(H)
		src.chained = 1
		src.cant_self_remove = 1
		src.name = "shackles"
		src.desc = "Used to restrain prisoners."
		src.icon_state = "orange1"
	return

/obj/item/clothing/shoes/magnetic
	name = "magnetic shoes"
	desc = "Keeps the wearer firmly anchored to the ground. Provided the ground is metal, of course."
	icon_state = "magboots"
	// c_flags = NOSLIP
	permeability_coefficient = 0.05
	mats = 8
	burn_possible = 0
	module_research = list("efficiency" = 5, "engineering" = 5)
	laces = LACES_NONE
	kick_bonus = 2
	step_sound = "step_plating"
	step_priority = STEP_PRIORITY_LOW
	magnetic = 1

/obj/item/clothing/shoes/hermes
	name = "sacred sandals" // The ultimate goal of material scientists.
	desc = "Sandals blessed by the all-powerful goddess of victory and footwear."
	icon_state = "wizard" //TODO: replace with custom sprite, thinking winged sandals
	c_flags = NOSLIP
	permeability_coefficient = 0.05
	mats = 0
	magical = 1
	burn_possible = 0
	module_research = list("efficiency" = 5, "engineering" = 5)
	laces = LACES_NONE

	setupProperties()
		..()
		setProperty("movespeed", -2)

/obj/item/clothing/shoes/industrial
#ifdef UNDERWATER_MAP
	name = "mechanised diving boots"
	icon_state = "divindboots"
	desc = "Industrial-grade boots fitted with mechanised balancers and stabilisers to increase running speed under a heavy workload."
#else
	icon_state = "indboots"
	name = "mechanised boots"
	desc = "Industrial-grade boots fitted with mechanised balancers and stabilisers to increase running speed under a heavy workload."
#endif
	permeability_coefficient = 0.05
	mats = 12
	burn_possible = 0
	module_research = list("efficiency" = 5, "engineering" = 5, "mining" = 10)
	laces = LACES_NONE
	kick_bonus = 2
	speedy = 1

/obj/item/clothing/shoes/white
	name = "white shoes"
	desc = "Protects you against biohazards that would enter your feet."
	icon_state = "white"
	permeability_coefficient = 0.05//25

/obj/item/clothing/shoes/galoshes
	name = "galoshes"
	desc = "Rubber boots that prevent slipping on wet surfaces."
	icon_state = "galoshes"
	c_flags = NOSLIP
	permeability_coefficient = 0.05

/obj/item/clothing/shoes/clown_shoes
	name = "clown shoes"
	desc = "Damn, thems some big shoes."
	icon_state = "clown"
	item_state = "clown_shoes"
	step_sound = "clownstep"
	module_research = list("audio" = 5)
	step_lots = 1
	step_priority = 999
	tripsalot = 1

/obj/item/clothing/shoes/flippers
	name = "flippers"
	desc = "A pair of rubber flippers that improves swimming ability when worn."
	icon_state = "flippers"
	permeability_coefficient = 0.05
	laces = LACES_NONE
	//step_sound = "clownstep" to-do : flip flopping sfx

	New()
		..()
		setProperty("negate_fluid_speed_penalty",0.6)

/obj/item/clothing/shoes/moon
	name = "moon shoes"
	desc = "Recent developments in trampoline-miniaturization technology have made these little wonders possible."
	icon_state = "moonshoes"
	mats = 2

	equipped(var/mob/user, var/slot)
		user.visible_message("<b>[user]</b> starts hopping around!","You start hopping around.")
		src.moonloop(user)
		return

	unequipped(var/mob/user)
		user.pixel_y = 0
		..()
		return

	proc/moonloop(var/mob/user)
		SPAWN_DBG(0)
			while(user && !user.stat && user:shoes == src)
				if(user.pixel_y < 12)
					user.pixel_y += 3
					sleep(1)
				else
					user.pixel_y -= 6
					sleep(1)

			if(user)
				user.pixel_y = 0
		return

/obj/item/clothing/shoes/cowboy
	name = "Cowboy boots"
	icon_state = "cowboy"

/obj/item/clothing/shoes/ziggy
	name = "familiar boots"
	desc = "A pair of striking red boots. Though they look clean, the soles are absolutely coated in a really fine, white powder."
	icon_state = "ziggy"

/obj/item/clothing/shoes/sandal
	name = "magic sandals"
	desc = "They magically stop you from slipping on magical hazards. It's not the mesh on the underside that does that. It's MAGIC. Read a fucking book."
	icon_state = "wizard"
	c_flags = NOSLIP
	magical = 1
	laces = LACES_NONE

	handle_other_remove(var/mob/source, var/mob/living/carbon/human/target)
		. = ..()
		if (prob(75))
			source.show_message(text("<span style=\"color:red\">\The [src] writhes in your hands as though they are alive! They just barely wriggle out of your grip!</span>"), 1)
			. = 0

/obj/item/clothing/shoes/tourist
	name = "flip-flops"
	desc = "These cheap sandals don't look very comfortable."
	icon_state = "tourist"
	protective_temperature = 0
	permeability_coefficient = 1

	setupProperties()
		..()
		setProperty("coldprot", 0)
		setProperty("heatprot", 0)
		setProperty("conductivity", 1)

/obj/item/clothing/shoes/detective
	name = "worn boots"
	desc = "This pair of leather boots has seen better days."
	icon_state = "detective"

/obj/item/clothing/shoes/chef
	name = "chef's clogs"
	desc = "Sturdy shoes that minimize injury from falling objects or knives."
	icon_state = "chef"
	permeability_coefficient = 0.30
	kick_bonus = 1
	step_sound = "step_wood"
	step_priority = STEP_PRIORITY_LOW
	setupProperties()
		..()
		setProperty("meleeprot", 1)

/obj/item/clothing/shoes/swat
	name = "military boots"
	desc = "Polished and very shiny military boots."
	icon_state = "swat"
	permeability_coefficient = 0.20
	protective_temperature = 1250
	kick_bonus = 2

	setupProperties()
		..()
		setProperty("coldprot", 10)
		setProperty("heatprot", 10)
		setProperty("meleeprot", 1)

/obj/item/clothing/shoes/fuzzy //not boolean slippers
	name = "fuzzy slippers"
	desc = "A pair of cute little pink rabbit slippers."
	icon_state = "fuzzy"

	setupProperties()
		..()
		setProperty("coldprot", 15)

/obj/item/clothing/shoes/gogo
	name = "go-go boots"
	desc = "These boots complete your Space Age look."
	icon_state = "gogo"

	setupProperties()
		..()
		setProperty("coldprot", 10)
		setProperty("heatprot", 10)

/obj/item/clothing/shoes/jetpack
	name = "jet boots"
	desc = "Some kind of fancy boots with little propulsion rockets attached to them, that let you move through space with ease and grace! Okay, maybe not grace. That part depends on you. Also, they are a fashion disaster. On the plus side, you can more easily escape the fashion police while wearing them!"
	icon_state = "rocketboots"
	laces = LACES_NONE
	burn_possible = 0
	module_research = list("efficiency" = 20)
	step_sound = "step_plating"
	step_priority = STEP_PRIORITY_LOW
	var/on = 1
	var/obj/item/tank/tank = null

	New()
		..()
		src.tank = new /obj/item/tank/emergency_oxygen(src)

	setupProperties()
		..()
		setProperty("movespeed", 0.9)

	attackby(obj/item/W as obj, mob/user as mob)
		if (istype(W, /obj/item/tank))
			if (src.tank)
				boutput(user, "<span style='color:red'>There's already a tank installed!</span>")
				return
			if (!istype(W, /obj/item/tank/emergency_oxygen))
				boutput(user, "<span style='color:red'>[W] doesn't fit!</span>")
				return
			boutput(user, "<span style='color:blue'>You install [W] into [src].</span>")
			user.u_equip(W)
			W.set_loc(src)
			src.tank = W
			src.verbs += /obj/item/clothing/shoes/jetpack/verb/eject_tank
			return
		else
			..()

	verb/toggle()
		src.on = !(src.on)
		boutput(usr, "<span style='color:blue'>The jet boots are now [src.on ? "on" : "off"].</span>")
		return

	verb/eject_tank()
		if (src.tank)
			boutput(usr, "<span style='color:blue'>You eject [src.tank] from [src].</span>")
			usr.put_in_hand_or_drop(src.tank)
			src.tank = null
		src.verbs -= /obj/item/clothing/shoes/jetpack/verb/eject_tank
		return

	proc/allow_thrust(num, mob/user as mob) // blatantly c/p from jetpacks
		if (!src.on || !istype(src.tank))
			return 0
		if (!isnum(num) || num < 0.01 || src.tank.air_contents.total_moles() < num)
			return 0

		var/datum/gas_mixture/G = src.tank.air_contents.remove(num)

		if (G.oxygen >= 0.01)
			return 1
		if (G.toxins > 0.001)
			if (user)
				var/d = G.toxins / 2
				d = min(abs(user.health + 100), d, 25)
				user.TakeDamage("chest", 0, d)
				user.updatehealth()
			return (G.oxygen >= 0.0075 ? 0.5 : 0)
		else
			if (G.oxygen >= 0.0075)
				return 0.5
			else
				return 0
		qdel(G)
		return

	get_desc(dist)
		if (dist <= 1)
			. += "<br>They're currently [src.on ? "on" : "off"].<br>[src.tank ? "The tank's current air pressure reads [src.tank.air_contents.return_pressure()]." : "<span style='color:red'>They have no tank attached!</span>"]"

/obj/item/clothing/shoes/jetpack/abilities = list(/obj/ability_button/jetboot_toggle)

/obj/item/clothing/shoes/witchfinder
	name = "witchfinder general's boots"
	desc = "You can almost hear the authority in each step."
	icon_state = "witchfinder"
	permeability_coefficient = 0.30
	kick_bonus = 1
	step_sound = "step_wood"
	step_priority = STEP_PRIORITY_LOW
	setupProperties()
		..()
		setProperty("meleeprot", 5)

/obj/item/clothing/shoes/jester
	name = "jester's shoes"
	desc = "The shoes of a not-so-funny-clown."
	icon_state = "jester"