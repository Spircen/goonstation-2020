/datum/projectile/bullet
//How much of a punch this has, tends to be seconds/damage before any resist
	power = 45
//How much ammo this costs
	cost = 1
//How fast the power goes away
	dissipation_rate = 5
//How many tiles till it starts to lose power
	dissipation_delay = 5
//Kill/Stun ratio
	ks_ratio = 1.0
//name of the projectile setting, used when you change a guns setting
	sname = "single shot"
//file location for the sound you want it to play
	shot_sound = 'sound/weapons/Gunshot.ogg'
//How many projectiles should be fired, each will cost the full cost
	shot_number = 1

	// caliber list: update as needed
	// 0.22 pistol / zipgun
	// 0.308 - rifles
	// 0.357 - revolver
	// 0.38 - detective
	// 0.41 - derringer
	// 0.72 - shotgun shell, 12ga
	// 1.57 - grenade shell, 40mm
	// 1.58 - RPG-7 (Tube is 40mm too, though warheads are usually larger in diameter.)

//What is our damage type
/*
kinetic - raw power
piercing - punches though things
slashing - cuts things
energy - energy
burning - hot
radioactive - rips apart cells or some shit
toxic - poisons
*/
	damage_type = D_KINETIC
// blood system damage type - DAMAGE_STAB, DAMAGE_CUT, DAMAGE_BLUNT
	hit_type = DAMAGE_CUT
	//With what % do we hit mobs laying down
	hit_ground_chance = 33
	//Can we pass windows
	window_pass = 0
	implanted = /obj/item/implant/projectile
	// we create this overlay on walls when we hit them
	icon_turf_hit = "bhole"

	hit_mob_sound = 'sound/impact_sounds/Flesh_Stab_2.ogg'

//Any special things when it hits shit?
	on_hit(atom/hit, direction, projectile)
		if (ishuman(hit) && src.hit_type)
			take_bleeding_damage(hit, null, round(src.power / 3), src.hit_type) // oh god no why was the first var set to src what was I thinking
		..()//uh, what the fuck, call your parent
		//return // BULLETS CANNOT BLEED, HAINE

/datum/projectile/bullet/bullet_22
	name = "bullet"
	power = 22
	shot_sound = 'sound/machines/click.ogg'
	damage_type = D_KINETIC
	hit_type = DAMAGE_CUT
	implanted = /obj/item/implant/projectile/bullet_22
	casing = /obj/item/casing/small
	caliber = 0.22
	icon_turf_hit = "bhole-small"
	silentshot = 1 // It's supposed to be a stealth weapon, right (Convair880)?

/datum/projectile/bullet/bullet_9mm
	name = "bullet"
	power = 25
	shot_sound = 'sound/weapons/smg_shot.ogg'
	damage_type = D_KINETIC
	hit_type = DAMAGE_CUT
	implanted = /obj/item/implant/projectile/bullet_22
	casing = /obj/item/casing/small
	caliber = 0.355
	icon_turf_hit = "bhole-small"

	smg
		power = 20

/datum/projectile/bullet/custom
	name = "bullet"
	power = 1
	damage_type = D_KINETIC
	hit_type = DAMAGE_CUT
	implanted = /obj/item/implant/projectile/bullet_22
	casing = /obj/item/casing/small
	caliber = 0.22
	icon_turf_hit = "bhole-small"

/datum/projectile/bullet/revolver_357
	name = "bullet"
	power = 60 // okay this can be made worse again now that crit isn't naptime
	damage_type = D_KINETIC
	hit_type = DAMAGE_CUT
	implanted = /obj/item/implant/projectile/bullet_357
	caliber = 0.357
	icon_turf_hit = "bhole-small"
	casing = /obj/item/casing/medium

/datum/projectile/bullet/revolver_357/AP
	power = 50
	damage_type = D_PIERCING
	hit_type = DAMAGE_STAB
	implanted = /obj/item/implant/projectile/bullet_357AP

/datum/projectile/bullet/staple
	name = "staple"
	power = 5
	damage_type = D_KINETIC // don't staple through armor
	hit_type = DAMAGE_BLUNT
	implanted = /obj/item/implant/projectile/staple // HEH
	shot_sound = 'sound/impact_sounds/Generic_Snap_1.ogg'
	icon_turf_hit = "bhole-staple"
	casing = null

/datum/projectile/bullet/revolver_38
	name = "bullet"
	power = 35
	ks_ratio = 1.0
	implanted = /obj/item/implant/projectile/bullet_38
	caliber = 0.38
	icon_turf_hit = "bhole-small"
	casing = /obj/item/casing/medium

/datum/projectile/bullet/revolver_38/AP//traitor det revolver
	power = 50
	implanted = /obj/item/implant/projectile/bullet_38AP
	damage_type = D_PIERCING
	hit_type = DAMAGE_STAB

/datum/projectile/bullet/revolver_45
	name = "bullet"
	power = 35
	ks_ratio = 1.0
	hit_type = DAMAGE_CUT
	implanted = /obj/item/implant/projectile/bullet_45
	caliber = 0.45
	icon_turf_hit = "bhole-small"
	casing = /obj/item/casing/medium

/datum/projectile/bullet/nine_mm_NATO
	name = "bullet"
	shot_sound = 'sound/weapons/9x19NATO.ogg'
	power = 6
	ks_ratio = 0.9
	dissipation_rate = 2
	dissipation_delay = 8
	projectile_speed = 36
	caliber = 0.355
	icon_turf_hit = "bhole-small"
	implanted = /obj/item/implant/projectile/bullet_nine_mm_NATO
	casing = /obj/item/casing/small

/datum/projectile/bullet/nine_mm_NATO/burst
	shot_number = 3
	cost = 3
	sname = "burst fire"


/datum/projectile/bullet/rifle_3006
	name = "bullet"
	power = 100
	damage_type = D_PIERCING
	hit_type = DAMAGE_STAB
	implanted = /obj/item/implant/projectile/bullet_308
	shot_sound = 'sound/weapons/railgun.ogg'
	dissipation_delay = 10
	casing = /obj/item/casing/rifle
	caliber = 0.308
	icon_turf_hit = "bhole-small"

	on_hit(atom/hit, dirflag, obj/projectile/proj)
		if(ishuman(hit))
			var/mob/living/carbon/human/M = hit
			if(proj.power > 40)
#ifdef USE_STAMINA_DISORIENT
				M.do_disorient(75, weakened = 40, stunned = 40, disorient = 60, remove_stamina_below_zero = 0)
#else
				M.changeStatus("stunned", 4 SECONDS)
				M.changeStatus("weakened", 3 SECONDS)
#endif
			if(proj.power > 80)
				var/turf/target = get_edge_target_turf(M, dirflag)
				SPAWN_DBG(0)
					M.throw_at(target, 2, 2)
			if (src.hit_type)
				take_bleeding_damage(hit, null, round(src.power / 3), src.hit_type)
		impact_image_effect("K", hit)

/datum/projectile/bullet/rifle_762_NATO //like .308 but military
	name = "bullet"
	power = 80
	icon_state = "sniper_bullet"
	damage_type = D_PIERCING
	hit_type = DAMAGE_STAB
	implanted = /obj/item/implant/projectile/bullet_308
	shot_sound = 'sound/weapons/railgun.ogg'
	dissipation_delay = 15
	casing = /obj/item/casing/rifle
	caliber = 0.308
	icon_turf_hit = "bhole-small"

	on_hit(atom/hit, dirflag)
		if(ishuman(hit))
			var/mob/living/carbon/human/M = hit
			if(power > 40)
#ifdef USE_STAMINA_DISORIENT
				M.do_disorient(75, weakened = 40, stunned = 40, disorient = 60, remove_stamina_below_zero = 0)
#else
				M.changeStatus("stunned", 4 SECONDS)
				M.changeStatus("weakened", 3 SECONDS)
#endif
			if(power > 60)
				var/turf/target = get_edge_target_turf(M, dirflag)
				SPAWN_DBG(0)
					M.throw_at(target, 3, 3)
			if (src.hit_type)
				take_bleeding_damage(hit, null, round(src.power / 3), src.hit_type)

/datum/projectile/bullet/tranq_dart
	name = "dart"
	power = 10
	icon = 'icons/obj/chemical.dmi'
	icon_state = "syringeproj"
	damage_type = D_TOXIC
	hit_type = DAMAGE_BLUNT
	implanted = null
	shot_sound = 'sound/effects/syringeproj.ogg'
	dissipation_delay = 10
	caliber = 0.308
	reagent_payload = "haloperidol"
	casing = /obj/item/casing/rifle

	on_hit(atom/hit, dirflag)
		return

	syndicate
		reagent_payload = "sodium_thiopental" // HEH

		pistol
			caliber = 0.355
			casing = /obj/item/casing/small
			shot_sound = 'sound/weapons/tranq_pistol.ogg'

	//haha gannets, fuck you I stole ur shit! - kyle
	law_giver
		caliber = 0.355
		casing = /obj/item/casing/small
		shot_sound = 'sound/weapons/tranq_pistol.ogg'

	anti_mutant
		reagent_payload = "mutadone" // HAH




/datum/projectile/bullet/revolver_38/stunners//energy bullet things so he can actually stun something
	name = "stun bullet"
	power = 20
	ks_ratio = 0.0
	damage_type = D_ENERGY // FUCK YOU.
	hit_type = null
	icon_turf_hit = null // stun bullets shouldn't actually enter walls should they?

	/* this is now handled in the projectile parent on_hit for all ks_ratio 0.0 weapons.
	on_hit(atom/hit) // adding this so these work like taser shots I guess, if this sucks feel free to remove it
		if (ishuman(hit))
			var/mob/living/carbon/human/H = hit
			H.changeStatus("slowed", power)
			H.change_misstep_chance(5)
			H.emote("twitch_v")
			if (H.getStatusDuration("slowed") > power)
				H.changeStatus("stunned", power)
		return*/

	on_pointblank(var/obj/projectile/P, var/mob/living/M)
		stun_bullet_hit(P, M)
		impact_image_effect("T", M)

/datum/projectile/bullet/derringer
	name = "bullet"
	shot_sound = 'sound/weapons/derringer.ogg'
	power = 125
	dissipation_delay = 1
	dissipation_rate = 25
	damage_type = D_PIERCING
	hit_type = DAMAGE_STAB
	implanted = /obj/item/implant/projectile/bullet_41
	ks_ratio = 0.5
	caliber = 0.41
	icon_turf_hit = "bhole"
	casing = /obj/item/casing/derringer

	on_hit(atom/hit)
		if(ismob(hit) && hasvar(hit, "stunned"))
			hit:stunned += 5
		if (ishuman(hit))
			if (src.hit_type)
				take_bleeding_damage(hit, null, round(src.power / 3), src.hit_type)
				impact_image_effect("K", hit)
		return

/datum/projectile/bullet/a12
	name = "buckshot"
	shot_sound = 'sound/weapons/shotgunshot.ogg'
	power = 70
	ks_ratio = 1.0
	dissipation_delay = 3//2
	dissipation_rate = 20
	damage_type = D_KINETIC
	hit_type = DAMAGE_BLUNT
	caliber = 0.72 // roughly
	icon_turf_hit = "bhole"
	implanted = /obj/item/implant/projectile/bullet_12ga
	casing = /obj/item/casing/shotgun_red

	on_hit(atom/hit, dirflag, obj/projectile/proj)
		if (ishuman(hit))
			var/mob/living/carbon/human/M = hit
			if(proj.power > 30)
#ifdef USE_STAMINA_DISORIENT
				M.do_disorient(75, weakened = 50, stunned = 50, disorient = 30, remove_stamina_below_zero = 0)
#else
				M.changeStatus("stunned", 50)
				M.changeStatus("weakened", 5 SECONDS)
#endif
			if(proj.power > 70)
				var/turf/target = get_edge_target_turf(M, dirflag)
				SPAWN_DBG(0)
					if(!M.stat) M.emote("scream")
					M.throw_at(target, 6, 2)
			if (src.hit_type)
				take_bleeding_damage(hit, null, round(src.power / 3), src.hit_type)

	weak
		power = 30

/datum/projectile/bullet/airzooka
	name = "airburst"
	shot_sound = 'sound/weapons/airzooka.ogg'
	power = 0
	ks_ratio = 1.0
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "crescent_white"
	dissipation_delay = 6
	dissipation_rate = 5
	damage_type = D_KINETIC
	hit_type = DAMAGE_BLUNT
	icon_turf_hit = "bhole"
	implanted = null
	casing = null
	cost = 1

	on_hit(atom/hit, dirflag)
		if (ishuman(hit))
			var/mob/living/carbon/human/M = hit
			var/turf/target = get_edge_target_turf(M, dirflag)
			SPAWN_DBG(0)
				if(!M.stat) M.emote("scream")
				M.do_disorient(15, weakened = 10)
				M.throw_at(target, 6, 3)

/datum/projectile/bullet/airzooka/bad
	name = "plasmaburst"
	shot_sound = 'sound/weapons/airzooka.ogg'
	power = 15
	ks_ratio = 1.0
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "crescent_white"
	dissipation_delay = 6
	dissipation_rate = 5
	damage_type = D_KINETIC
	hit_type = DAMAGE_BLUNT
	icon_turf_hit = "bhole"
	implanted = null
	casing = null
	cost = 2

	on_hit(atom/hit, dirflag)
		if (ishuman(hit))
			var/mob/living/carbon/human/M = hit
			var/turf/target = get_edge_target_turf(M, dirflag)
			SPAWN_DBG(0)
				if(!M.stat) M.emote("scream")
				fireflash(get_turf(M), 2)
				M.do_disorient(15, weakened = 25)
				M.throw_at(target, 12, 3)


/datum/projectile/bullet/aex
	name = "explosive slug"
	shot_sound = 'sound/weapons/shotgunshot.ogg'
	power = 35 // the damage should be more from the explosion
	ks_ratio = 1.0
	dissipation_delay = 6
	dissipation_rate = 10
	implanted = null
	damage_type = D_KINETIC
	hit_type = DAMAGE_BLUNT
	caliber = 0.72
	icon_turf_hit = "bhole"
	casing = /obj/item/casing/shotgun_orange

	on_hit(atom/hit)
		explosion_new(null, get_turf(hit), 1)

	lawgiver
		name = "lawgiver"
		power = 1
		cost = 150

		on_hit(atom/hit)
			explosion_new(null, get_turf(hit), 3)

/datum/projectile/bullet/abg
	name = "rubber slug"
	shot_sound = 'sound/weapons/shotgunshot.ogg'
	power = 24
	ks_ratio = 0.2
	dissipation_rate = 4
	dissipation_delay = 3
	implanted = null
	damage_type = D_KINETIC
	hit_type = DAMAGE_BLUNT
	caliber = 0.72
	icon_turf_hit = "bhole"
	casing = /obj/item/casing/shotgun_blue

	on_hit(atom/hit, dirflag, obj/projectile/proj)
		if (ishuman(hit))
			var/mob/living/carbon/human/M = hit
			if(proj.power >= 16)
				var/turf/target = get_edge_target_turf(M, dirflag)
				SPAWN_DBG(0)
					if(!M.stat) M.emote("scream")
					M.throw_at(target, 3, 2)
			//if (src.hit_type)
			// impact_image_effect("K", hit)
				//take_bleeding_damage(hit, null, round(src.power / 3), src.hit_type)

/datum/projectile/bullet/minigun
	name = "bullet"
	shot_sound = 'sound/weapons/minigunshot.ogg'
	power = 8
	cost = 10
	shot_number = 10
	shot_delay = 0.7
	dissipation_delay = 7
	ks_ratio = 1.0
	damage_type = D_KINETIC
	hit_type = DAMAGE_CUT
	caliber = 0.308
	icon_turf_hit = "bhole-small"
	implanted = /obj/item/implant/projectile/bullet_308
	casing = /obj/item/casing/rifle

/datum/projectile/bullet/minigun/turret
	power = 15
	dissipation_delay = 8

/datum/projectile/bullet/lmg
	name = "bullet"
	shot_sound = 'sound/weapons/minigunshot.ogg'
	power = 12
	cost = 8
	shot_number = 8
	shot_delay = 0.7
	dissipation_delay = 12
	ks_ratio = 1.0
	damage_type = D_KINETIC
	hit_type = DAMAGE_CUT
	caliber = 0.308
	icon_turf_hit = "bhole-small"
	implanted = /obj/item/implant/projectile/bullet_308
	casing = /obj/item/casing/rifle

	on_hit(atom/hit, dirflag)
		if(ishuman(hit))
			var/mob/living/carbon/human/M = hit
			M.changeStatus("slowed", 1.5 SECONDS)

/datum/projectile/bullet/lmg/weak
	power = 1
	cost = 2
	shot_number = 16
	shot_delay = 0.7
	dissipation_delay = 8
	nomsg = 1

/datum/projectile/bullet/ak47
	name = "bullet"
	shot_sound = 'sound/weapons/ak47shot.ogg'
	power = 40
	cost = 3
	ks_ratio = 1.0
	damage_type = D_KINETIC
	hit_type = DAMAGE_CUT
	shot_number = 3
	caliber = 0.308
	icon_turf_hit = "bhole-small"
	implanted = /obj/item/implant/projectile/bullet_308
	casing = /obj/item/casing/rifle

/datum/projectile/bullet/assault_rifle
	name = "bullet"
	shot_sound = 'sound/weapons/ak47shot.ogg'
	power = 30
	cost = 1
	ks_ratio = 1.0
	damage_type = D_KINETIC
	hit_type = DAMAGE_CUT
	shot_number = 1
	caliber = 0.223
	icon_turf_hit = "bhole-small"
	implanted = /obj/item/implant/projectile/bullet_308
	casing = /obj/item/casing/rifle

	armor_piercing
		damage_type = D_PIERCING
		hit_type = DAMAGE_STAB

/*
/datum/projectile/bullet/revolver_357/AP
	power = 50
	damage_type = D_PIERCING
	hit_type = DAMAGE_STAB
	implanted = /obj/item/implant/projectile/bullet_357AP
*/

/datum/projectile/bullet/vbullet
	name = "virtual bullet"
	shot_sound = 'sound/weapons/Gunshot.ogg'
	power = 10
	cost = 1
	ks_ratio = 1.0
	damage_type = D_KINETIC
	hit_type = DAMAGE_CUT
	implanted = null
	casing = null
	icon_turf_hit = null

/datum/projectile/bullet/flare
	name = "flare"
	shot_sound = 'sound/weapons/flaregun.ogg'
	power = 20
	cost = 1
	ks_ratio = 1.0
	damage_type = D_BURNING
	hit_type = null
	brightness = 1
	color_red = 1
	color_green = 0.3
	color_blue = 0
	icon_state = "flare"
	implanted = null
	caliber = 0.72 // 12 guage
	icon_turf_hit = "bhole"
	casing = /obj/item/casing/shotgun_orange

	on_hit(atom/hit)
		if (isliving(hit))
			fireflash(get_turf(hit), 0)
		else if (isturf(hit))
			fireflash(hit, 0)
		else
			fireflash(get_turf(hit), 0)

/datum/projectile/bullet/flare/UFO
	name = "heat beam"
	window_pass = 1
	icon_state = "plasma"
	casing = null

/datum/projectile/bullet/shrapnel // cogwerks: for explosions
	name = "shrapnel"
	power = 10
	damage_type = D_PIERCING
	hit_type = DAMAGE_CUT
	window_pass = 0
	icon = 'icons/obj/scrap.dmi'
	icon_state = "2metal0"
	casing = null
	icon_turf_hit = "bhole-staple"

/datum/projectile/bullet/autocannon
	name = "HE grenade"
	window_pass = 0
	icon_state = "40mmR"
	damage_type = D_KINETIC
	hit_type = DAMAGE_BLUNT
	power = 25
	dissipation_delay = 30
	cost = 1
	shot_sound = 'sound/weapons/rocket.ogg'
	ks_ratio = 1.0
	caliber = 1.57 // 40mm grenade shell
	icon_turf_hit = "bhole-large"
	casing = /obj/item/casing/grenade

	on_hit(atom/hit)
		explosion_new(null, get_turf(hit), 12)

	plasma_orb
		name = "fusion orb"
		damage_type = D_BURNING
		hit_type = null
		icon_state = "fusionorb"
		implanted = null
		brightness = 0.8
		color_red = 1
		color_green = 0.6
		color_blue = 0.2
		power = 50
		shot_sound = 'sound/machines/engine_alert3.ogg'
		icon_turf_hit = null
		casing = null

	huge
		icon_state = "400mm"
		power = 100
		caliber = 15.7
		icon_turf_hit = "bhole-large"

		on_hit(atom/hit)
			explosion_new(null, get_turf(hit), 80)

	seeker
		name = "drone-seeking grenade"
		var/max_turn_rate = 20
		var/type_to_seek = /obj/critter/gunbot/drone //what are we going to seek
		precalculated = 0

		on_launch(var/obj/projectile/P)
			var/D = locate(type_to_seek) in range(15, P)
			if (D)
				P.data = D

		tick(var/obj/projectile/P)
			if (!P)
				return
			if (!P.loc)
				return
			if (!P.data)
				return
			var/obj/D = P.data
			if (!istype(D))
				return
			var/turf/T = get_turf(D)
			var/turf/S = get_turf(P)

			if (!T || !S)
				return

			var/STx = T.x - S.x
			var/STy = T.y - S.y
			var/STlen = STx * STx + STy * STy
			if (!STlen)
				return
			STlen = sqrt(STlen)
			STx /= STlen
			STy /= STlen
			var/dot = STx * P.xo + STy * P.yo
			var/det = STx * P.yo - STy * P.xo
			var/sign = -1
			if (det <= 0)
				sign = 1

			var/relang = arccos(dot)
			P.rotateDirection(max(-max_turn_rate, min(max_turn_rate, sign * relang)))

		pod_seeking
			name = "pod-seeking grenade"
			type_to_seek = /obj/machinery/vehicle

		ghost
			name = "pod-seeking grenade"
			type_to_seek = /mob/dead/observer

/datum/projectile/bullet/grenade_round
	name = "40mm round"
	window_pass = 0
	icon_state = "40mmR"
	damage_type = D_KINETIC
	hit_type = DAMAGE_BLUNT
	power = 5
	dissipation_delay = 30
	cost = 1
	shot_sound = 'sound/weapons/launcher.ogg'
	ks_ratio = 1.0
	caliber = 1.57
	icon_turf_hit = "bhole-large"
	casing = /obj/item/casing/grenade

	explosive
		name = "40mm HEDP round"

		on_hit(atom/hit)
			explosion_new(null, get_turf(hit),4,2)

	high_explosive //more powerful than HEDP
		name = "40mm HE round"
		power = 10

		on_hit(atom/hit)
			explosion_new(null,get_turf(hit),10)

// Ported from old, non-gun RPG-7 object class (Convair880).
/datum/projectile/bullet/rpg
	name = "MPRT rocket"
	window_pass = 0
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "rpg_rocket"
	damage_type = D_KINETIC
	hit_type = DAMAGE_BLUNT
	power = 40
	dissipation_delay = 30
	cost = 1
	shot_sound = 'sound/weapons/rocket.ogg'
	ks_ratio = 1.0
	caliber = 1.58
	icon_turf_hit = "bhole-large"

	on_hit(atom/hit)
		var/turf/T = get_turf(hit)
		if (T)
			for (var/mob/living/carbon/human/M in view(hit, 2))
				if (istype(M.wear_suit, /obj/item/clothing/suit/armor))
					boutput(M, "<span style=\"color:red\">Your armor blocks the shrapnel!</span>")
					M.TakeDamage("chest", 5, 0)
				else
					M.TakeDamage("chest", 15, 0)
					var/obj/item/implant/projectile/shrapnel/implanted = new /obj/item/implant/projectile/shrapnel(M)
					implanted.owner = M
					M.implant += implanted
					implanted.implanted(M, null, 2)
					boutput(M, "<span style=\"color:red\">You are struck by shrapnel!</span>")
					if (!M.stat)
						M.emote("scream")

			T.hotspot_expose(700,125)
			explosion_new(null, T, 30, 0.5)
		return

/obj/smokeDummy
	name = ""
	desc = ""
	invisibility = 101
	anchored = 1
	density = 0
	opacity = 0
	var/list/affected = list()

	disposing()
		remove()
		return ..()

	New(var/atom/sloc)
		if(!sloc) return
		src.loc = sloc
		for(var/mob/M in src.loc)
			Crossed(M)
		return ..()

	proc/remove()
		for(var/mob/M in affected)
			M.removeOverlayComposition(/datum/overlayComposition/smoke)
			M.updateOverlaysClient(M.client)
		affected.Cut()
		return

	Crossed(atom/movable/O)
		if(ishuman(O) && prob(30))
			var/mob/living/carbon/human/H = O
			if (H.internal != null && H.wear_mask && (H.wear_mask.c_flags & MASKINTERNALS))
			else
				H.emote("cough")
				if (prob(20))	//remove this maybe. it shoudla been stunning, but has been broken since the status system updates.
					H.setStatus("stunned",max(H.getStatusDuration("stunned"), 20))

		if(ismob(O))
			var/mob/M = O
			if (M.client && !isobserver(M) && !iswraith(M) && !isintangible(M)) // fuck you stop affecting ghosts FUCK YOU
				M.addOverlayComposition(/datum/overlayComposition/smoke)
				M.updateOverlaysClient(M.client)
				affected.Add(O)
		return ..()

	Uncrossed(atom/movable/O)
		if(ismob(O))
			var/mob/M = O
			if (M.client && !isobserver(M) && !iswraith(M) && !isintangible(M)) // FUCK YOU
				if(!(locate(/obj/smokeDummy) in M.loc))
					M.removeOverlayComposition(/datum/overlayComposition/smoke)
					M.updateOverlaysClient(M.client)
					affected.Remove(M)
		return ..()

/datum/projectile/bullet/smoke
	name = "smoke grenade"
	window_pass = 0
	icon_state = "40mmB"
	damage_type = D_KINETIC
	power = 25
	dissipation_delay = 10
	cost = 1
	shot_sound = 'sound/weapons/launcher.ogg'
	ks_ratio = 1.0
	caliber = 1.57 // 40mm grenade shell
	icon_turf_hit = "bhole-large"
	casing = /obj/item/casing/grenade

	var/list/smokeLocs = list()
	var/smokeLength = 100

	proc/startSmoke(atom/hit, dirflag, atom/projectile)
		/*var/turf/trgloc = get_turf(projectile)
		var/list/affected = block(locate(trgloc.x - 3,trgloc.y - 3,trgloc.z), locate(trgloc.x + 3,trgloc.y + 3,trgloc.z))
		if(!affected.len) return
		var/list/centerview = view(world.view, trgloc)
		for(var/atom/A in affected)
			if(!(A in centerview)) continue
			var/obj/smokeDummy/D = new(A)
			smokeLocs.Add(D)
			SPAWN_DBG(smokeLength) qdel(D)
		particleMaster.SpawnSystem(new/datum/particleSystem/areaSmoke("#ffffff", smokeLength, trgloc))
		return*/

		// I'm so tired of overlays freezing my client, sorry. Get rid of the old smoke call here once
		// the performance and issues of full-screen overlays have been resolved, I guess (Convair880).
		var/turf/T = get_turf(projectile)
		if (T && isturf(T))
			var/datum/effects/system/bad_smoke_spread/S = new /datum/effects/system/bad_smoke_spread/(T)
			if (S)
				S.set_up(20, 0, T)
				S.start()
		return

	on_hit(atom/hit, dirflag, atom/projectile)
		startSmoke(hit, dirflag, projectile)
		return

/datum/projectile/bullet/glitch
	name = "bullet"
	window_pass = 1
	icon_state = "glitchproj"
	damage_type = D_KINETIC
	hit_type = null
	power = 30
	dissipation_delay = 12
	cost = 1
	shot_sound = 'sound/effects/glitchshot.ogg'
	ks_ratio = 1.0
	casing = null
	icon_turf_hit = null

	New()
		..()
		src.name = pick("weird", "puzzling", "odd", "strange", "baffling", "creepy", "unusual", "confusing", "discombobulating") + " bullet"
		src.name = corruptText(src.name, 66)

	on_hit(atom/hit)
		hit.icon_state = pick(icon_states(hit.icon))

		for(var/atom/a in hit)
			a.icon_state = pick(icon_states(a.icon))

		playsound(hit, "sound/machines/glitch3.ogg", 50, 1)

/datum/projectile/bullet/glitch/gun
	power = 1

/datum/projectile/bullet/rod // for the coilgun
	name = "metal rod"
	power = 50
	damage_type = D_KINETIC
	hit_type = DAMAGE_STAB
	window_pass = 0
	icon_state = "rod_1"
	dissipation_delay = 25
	caliber = 1.0
	shot_sound = 'sound/weapons/ACgun2.ogg'
	casing = null
	icon_turf_hit = "bhole-large"

	on_hit(atom/hit)
		explosion_new(null, get_turf(hit), 5)

/datum/projectile/bullet/frog/ //sorry for making this, players -ZeWaka
	name = "green splat" //thanks aibm for wording this beautifully
	window_pass = 0
	icon_state = "acidspit"
	hit_type = null
	damage_type = 0
	power = 0
	dissipation_delay = 12
	sname = "Get In"
	shot_sound = 'sound/weapons/ribbit.ogg' //heh
	casing = null
	icon_turf_hit = null

	New()
		..()

	on_hit(atom/hit)
		hit.UpdateOverlays(image('icons/misc/frogs.dmi', "icon_state" = "getin"), "getin") //why did i code this

/datum/projectile/bullet/frog/getout
	sname = "Get Out"

	on_hit(atom/hit)
		hit.UpdateOverlays(image('icons/misc/frogs.dmi', "icon_state" = "getout"), "getout") //its like im trying to intentionally torture players


/datum/projectile/bullet/flak_chunk
	name = "flak chunk"
	sname = "flak chunk"
	icon_state = "trace"
	shot_sound = null
	power = 12
	dissipation_rate = 5
	dissipation_delay = 8
	damage_type = D_KINETIC

/datum/projectile/bullet/buckshot // buckshot pellets generates by shotguns
	name = "buckshot"
	sname = "buckshot"
	icon_state = "trace"
	power = 6
	dissipation_rate = 5
	dissipation_delay = 3
	damage_type = D_KINETIC

/datum/projectile/bullet/grenade_shell
	name = "40mm grenade conversion shell"
	window_pass = 0
	icon_state = "40mmR"
	damage_type = D_KINETIC
	power = 25
	dissipation_delay = 20
	cost = 1
	shot_sound = 'sound/weapons/rocket.ogg'
	ks_ratio = 1.0
	caliber = 1.57 // 40mm grenade shell
	icon_turf_hit = "bhole-large"
	casing = /obj/item/casing/grenade

	var/has_grenade = 0
	var/obj/item/chem_grenade/CHEM = null
	var/obj/item/old_grenade/OLD = null
	var/has_det = 0 //have we detonated a grenade yet?

	proc/get_nade()
		if (src.has_grenade != 0)
			if (src.CHEM != null)
				return src.CHEM
			else if (src.OLD != null)
				return src.OLD
			else
				return null
		else
			return null

	proc/load_nade(var/obj/item/W)
		if (W)
			if (src.has_grenade == 0)
				if (istype(W,/obj/item/chem_grenade))
					src.CHEM = W
					src.has_grenade = 1
					return 1
				else if (istype(W, /obj/item/old_grenade))
					src.OLD = W
					src.has_grenade = 1
					return 1
				else
					return 0
			else
				return 0
		else
			return 0

	proc/unload_nade(var/turf/T)
		if (src.has_grenade !=0)
			if (src.CHEM != null)
				if (T)
					src.CHEM.loc = T
				src.CHEM = null
				src.has_grenade = 0
				return 1
			else if (src.OLD != null)
				if (T)
					src.OLD.loc = T
				src.OLD = null
				src.has_grenade = 0
				return 1
			else //how did this happen?
				return 0
		else
			return 0

	proc/det(var/turf/T)
		if (T && src.has_det == 0 && src.has_grenade != 0)
			if (src.CHEM != null)
				src.CHEM.loc = T
				src.has_det = 1
				SPAWN_DBG(1)
					src.CHEM.explode()
				src.has_grenade = 0
				return
			else if (src.OLD != null)
				src.OLD.loc = T
				src.has_det = 1
				SPAWN_DBG(1)
					src.OLD.prime()
				src.has_grenade = 0
				return
			else //what the hell happened
				return
		else
			return

	on_hit(atom/hit, angle, obj/projectile/O)
		var/turf/T = get_turf(hit)
		if (T)
			src.det(T)
		else if (O)
			var/turf/pT = get_turf(O)
			if (pT)
				src.det(pT)
		return ..()

	on_end(obj/projectile/O)
		if (O && src.has_det == 0)
			var/turf/T = get_turf(O)
			if (T)
				src.det(T)
		else if (O)
			src.has_det = 0

/datum/projectile/bullet/flintlock
	name = "bullet"
	power = 110
	damage_type = D_PIERCING
	hit_type = DAMAGE_STAB
	implanted = /obj/item/implant/projectile/flintlock
	shot_sound = 'sound/weapons/flintlock.ogg'
	dissipation_delay = 10
	casing = null
	caliber = 0.58
	icon_turf_hit = "bhole-small"

	on_hit(atom/hit, dirflag)
		if(ishuman(hit))
			var/mob/living/carbon/human/M = hit
			if(power > 40)
#ifdef USE_STAMINA_DISORIENT
				M.do_disorient(75, weakened = 40, stunned = 40, disorient = 60, remove_stamina_below_zero = 0)
#else
				M.changeStatus("stunned", 4 SECONDS)
				M.changeStatus("weakened", 3 SECONDS)
#endif
			if(power > 80)
				var/turf/target = get_edge_target_turf(M, dirflag)
				SPAWN_DBG(0)
					M.throw_at(target, 2, 2)
			if (src.hit_type)
				take_bleeding_damage(hit, null, round(src.power / 3), src.hit_type)

/datum/projectile/bullet/antisingularity
	name = "Singularity buster rocket"
	window_pass = 0
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "regrocket"
	damage_type = D_KINETIC
	hit_type = DAMAGE_BLUNT
	power = 5
	dissipation_delay = 30
	cost = 1
	shot_sound = 'sound/weapons/rocket.ogg'
	ks_ratio = 1.0
	caliber = 1.12
	icon_turf_hit = "bhole-large"
	implanted = null

	on_hit(atom/hit)
		var/obj/machinery/the_singularity/S = hit
		if(istype(S))
			new /obj/bhole(S.loc,rand(100,300))
			qdel(S)
		else
			new /obj/effects/rendersparks(hit.loc)
			if(ishuman(hit))
				var/mob/living/carbon/human/M = hit
				M.TakeDamage("chest", 15, 0)
				boutput(M, "<span style=\"color:red\">You are struck by a big rocket! Thankfully it was not the exploding kind.</span>")
				M.do_disorient(stunned = 40)
				if (!M.stat)
					M.emote("scream")

/datum/projectile/bullet/clownshot
	name = "clownshot"
	power = 1
	cost = 15				//This should either cost a lot or a little I don't know. On one hand if it costs nothing you can truly tormet clowns with it, but on the other hand if it costs your full charge, then the clown will know how much you hate it because of how much you sacraficed to harm it. I settled for a med amount...
	damage_type = D_KINETIC
	hit_type = DAMAGE_BLUNT
	implanted = null
	shot_sound = 'sound/impact_sounds/Generic_Snap_1.ogg'
	icon_turf_hit = "bhole-staple"
	casing = null
	hit_ground_chance = 50
	icon_state = "random_thing"	//actually exists, looks funny enough to use as the projectile image for this

	on_hit(atom/hit, dirflag)
		if (ishuman(hit))
			var/mob/living/carbon/human/H = hit
			var/clown_tally = 0
			if(istype(H.w_uniform, /obj/item/clothing/under/misc/clown))
				clown_tally += 1
			if(istype(H.shoes, /obj/item/clothing/shoes/clown_shoes))
				clown_tally += 1
			if(istype(H.wear_mask, /obj/item/clothing/mask/clown_hat))
				clown_tally += 1
			if(clown_tally > 0)
				playsound(H, "sound/musical_instruments/Bikehorn_1.ogg", 50, 1)

			if (H.job == "Clown" || clown_tally >= 2)
				H.drop_from_slot(H.shoes)
				spawn(0)
					H.throw_at(get_offset_target_turf(H, rand(5)-rand(5), rand(5)-rand(5)), rand(2,4), 2)
				H.emote("twitch_v")

		return
