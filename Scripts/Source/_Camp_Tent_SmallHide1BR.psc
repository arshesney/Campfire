scriptname _Camp_Tent_SmallHide1BR extends _Camp_Tent

import debug
import utility
import CampUtil

static property _Camp_Tent_SmallHideStatic auto							;Tent world mesh
static property _Camp_Tent_SmallHideStaticExterior auto					;Exterior tent world mesh

;Main reference object (USE BEDROLL)
ObjectReference property _Camp_SmallHideTent1BR_Tent_PosRef auto

;Reference Objects
ObjectReference property _Camp_SmallHideTent1BR_Backpack_PosRef auto
ObjectReference property _Camp_SmallHideTent1BR_Boots_PosRef auto
ObjectReference property _Camp_SmallHideTent1BR_Gauntlets_PosRef auto
ObjectReference property _Camp_SmallHideTent1BR_Cuirass_PosRef auto
ObjectReference property _Camp_SmallHideTent1BR_Bow_PosRef auto
ObjectReference property _Camp_SmallHideTent1BR_FrontExit_PosRef auto
ObjectReference property _Camp_SmallHideTent1BR_GroundCover_PosRef auto
ObjectReference property _Camp_SmallHideTent1BR_Helmet_PosRef auto
ObjectReference property _Camp_SmallHideTent1BR_Lantern_PosRef auto
ObjectReference property _Camp_SmallHideTent1BR_Light_PosRef auto
ObjectReference property _Camp_SmallHideTent1BR_MainHand_PosRef auto
ObjectReference property _Camp_SmallHideTent1BR_OffHand_PosRef auto
ObjectReference property _Camp_SmallHideTent1BR_PlayerBedroll_PosRef auto
ObjectReference property _Camp_SmallHideTent1BR_PlayerLayDownMarker_PosRef auto
ObjectReference property _Camp_SmallHideTent1BR_PlayerShield_PosRef auto
ObjectReference property _Camp_SmallHideTent1BR_PlayerShieldInterior_PosRef auto
ObjectReference property _Camp_SmallHideTent1BR_PlayerSitMarker_PosRef auto
ObjectReference property _Camp_SmallHideTent1BR_TwoHand_PosRef auto
ObjectReference property _Camp_SmallHideTent1BR_Ward_PosRef auto

Event OnInit()
	;trace("[FROSTFALL] Setting up all objects...")
	while !self.Is3DLoaded()
	endWhile
	
	CreatePositionArrays()
	
	myOriginAng = GetAngleData(self)
	
	GetRelativePositions()
	
	;trace("[FROSTFALL] Placing objects...")
	if !(IsRefInInterior(PlayerRef))
		myTent = PlaceAtMeRelative(self, _Camp_Tent_SmallHideStatic, myOriginAng, myTent_Pos)	;fZLocalAngAdjust = 180.0
		myNormalTent = myTent.PlaceAtMe(_Camp_Tent_SmallHideStaticExterior, abInitiallyDisabled = true)
		mySnowTent = myTent.PlaceAtMe(SnowTentStatic, abInitiallyDisabled = true)
		myAshTent = myTent.PlaceAtMe(AshTentStatic, abInitiallyDisabled = true)
		ApplySnow()
		myWard = PlaceAtMeRelative(self, _Camp_TentWard, myOriginAng, myWard_Pos, fXLocalAngAdjust = -90.0, abIsPropped = true)
		myPlayerMarker_Shield = PlaceAtMeRelative(self, _Camp_Tent_ShieldMarker, myOriginAng, myPlayerMarker_Shield_Pos, fXLocalAngAdjust = 90.0, fZLocalAngAdjust = 124.0, abInvertedLocalY = true, abIsPropped = true)
	else
		myPlayerMarker_ShieldInterior = PlaceAtMeRelative(self, _Camp_Tent_ShieldMarker, myOriginAng, myPlayerMarker_ShieldInterior_Pos)
	endif
	myGroundCover = PlaceAtMeRelative(self, _Camp_Tent_BedrollHayNoGround02, myOriginAng, myGroundCover_Pos)
	myBedRoll = PlaceAtMeRelative(self, _Camp_Bedroll_ActualF, myOriginAng, myBedRoll_Pos)
	myLanternUnlit = PlaceAtMeRelative(self, _Camp_Tent_LanternOffGround, myOriginAng, myLanternUnlit_Pos)
	myLanternLit = PlaceAtMeRelative(self, _Camp_Tent_LanternOnGround, myOriginAng, myLanternLit_Pos, abInitiallyDisabled = true)
	myLanternLight = PlaceAtMeRelative(self, _Camp_LanternLight, myOriginAng, myLanternLight_Pos, abInitiallyDisabled = true)
	myPlayerMarker_MainWeapon = PlaceAtMeRelative(self, _Camp_Tent_MainWeaponMarker, myOriginAng, myPlayerMarker_MainWeapon_Pos)
	myPlayerMarker_OffHandWeapon = PlaceAtMeRelative(self, _Camp_Tent_OffHandWeaponMarker, myOriginAng, myPlayerMarker_OffHandWeapon_Pos)
	myPlayerMarker_BigWeapon = PlaceAtMeRelative(self, _Camp_Tent_BigWeaponMarker, myOriginAng, myPlayerMarker_BigWeapon_Pos)
	myPlayerMarker_Bow = PlaceAtMeRelative(self, _Camp_Tent_BowMarker, myOriginAng, myPlayerMarker_Bow_Pos)
	myPlayerMarker_Helm = PlaceAtMeRelative(self, _Camp_Tent_HelmMarker, myOriginAng, myPlayerMarker_Helm_Pos)
	myPlayerMarker_Boots = PlaceAtMeRelative(self, _Camp_Tent_BootsMarker, myOriginAng, myPlayerMarker_Boots_Pos)
	myPlayerMarker_Gauntlets = PlaceAtMeRelative(self, _Camp_Tent_GauntletsMarker, myOriginAng, myPlayerMarker_Gauntlets_Pos)
	myPlayerMarker_Cuirass = PlaceAtMeRelative(self, _Camp_Tent_CuirassMarker, myOriginAng, myPlayerMarker_Cuirass_Pos)
	myPlayerMarker_Backpack = PlaceAtMeRelative(self, _Camp_Tent_BackpackMarker, myOriginAng, myPlayerMarker_Backpack_Pos)
	myPlayerSitMarker = PlaceAtMeRelative(self, _Camp_TentSitMarker, myOriginAng, myPlayerSitMarker_Pos)
	myPlayerLayDownMarker = PlaceAtMeRelative(self, _Camp_TentLayDownMarker, myOriginAng, myPlayerLayDownMarker_Pos, fZLocalAngAdjust = 180.0)
	myExitFront = PlaceAtMeRelative(self, XMarker, myOriginAng, myExitFront_Pos)
	;trace("[FROSTFALL] Object placement complete.")
	
	;Move primary bedroll (self) to new position
	;CODE GOES HERE
	
endEvent

function GetRelativePositions()
	myTent_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_Tent_PosRef)
	myGroundCover_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_GroundCover_PosRef)
	myBedRoll_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_PlayerBedroll_PosRef)
	myLanternUnlit_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_Lantern_PosRef)
	myLanternLit_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_Lantern_PosRef)
	myLanternLight_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_Light_PosRef)
	myPlayerMarker_MainWeapon_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_MainHand_PosRef)
	myPlayerMarker_OffHandWeapon_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_OffHand_PosRef)
	myPlayerMarker_BigWeapon_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_TwoHand_PosRef)
	myPlayerMarker_Bow_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_Bow_PosRef)
	myPlayerMarker_Helm_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_Helmet_PosRef)
	myPlayerMarker_Boots_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_Boots_PosRef)
	myPlayerMarker_Gauntlets_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_Gauntlets_PosRef)
	myPlayerMarker_Cuirass_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_Cuirass_PosRef)
	myPlayerMarker_Backpack_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_Backpack_PosRef)
	myPlayerMarker_Shield_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_PlayerShield_PosRef)
	myPlayerMarker_ShieldInterior_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_PlayerShieldInterior_PosRef)
	myPlayerSitMarker_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_PlayerSitMarker_PosRef)
	myPlayerLayDownMarker_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_PlayerLayDownMarker_PosRef)
	myExitFront_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_FrontExit_PosRef)
	myWard_Pos = GetRelativePosition(_Camp_SmallHideTent1BR_Tent_PosRef, _Camp_SmallHideTent1BR_Ward_PosRef)
endFunction