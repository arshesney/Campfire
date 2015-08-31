Scriptname _Camp_Compatibility extends ReferenceAlias

import debug
import CampUtil
import _CampInternal

float property SKSE_MIN_VERSION = 1.07 autoReadOnly

;#PROPERTIES=====================================================================================================================
actor property PlayerRef auto
ReferenceAlias property PlayerAlias auto
Activator[] property PerkNodeControllers auto hidden
bool property multiple_perk_trees = false auto hidden 				;Flag for perk tree navigation

;#Scripts======================================================================
_Camp_SkyUIConfigPanelScript property CampConfig Auto 				;SkyUI Configuration script
_Camp_Main property Campfire auto 									;Main script
_Camp_ObjectPlacementThreadManager property PlacementSystem auto 	;Placement System Script
_Camp_TentSystem property TentSys auto
_Camp_ConditionValues property Conditions auto

;#Quests=======================================================================
Quest property _Camp_MainQuest auto 						;Main quest
Quest property _Camp_FollowerQuest auto 					;Follower tracking quest

;#Official DLC=================================================================
bool property isDLC1Loaded auto	hidden						;Dawnguard
bool property isDLC2Loaded auto hidden						;Dragonborn
bool property isHFLoaded auto hidden						;Hearthfire

;#Supported Mods===============================================================
bool property isSKSELoaded auto hidden						;SKSE
bool property isSKYUILoaded auto hidden						;SkyUI 3.4+
bool property isFrostfallLoaded auto hidden					;Frostfall
bool property isLastSeedLoaded auto hidden					;Last Seed
bool property isArtOfTheCatchLoaded auto hidden 			;Art of the Catch
bool property isIMCNLoaded auto hidden						;Imp's More Complex Needs
bool property isRNDLoaded auto hidden			 			;Realistic Needs and Diseases
bool property isINEEDLoaded auto hidden						;iNeed

;#Merchant Containers==========================================================
ObjectReference property MerchantRiverwoodTraderContainer auto

;#FormLists====================================================================
formlist property _Camp_Trees auto							;List of valid trees for Wood Harvesting
formlist property _Camp_WorldspacesInteriors auto			;Interior exception worldspace
formlist property _Camp_ModWaterSkins auto 					;List of waterskins from other mods
formlist property _Camp_HeatSources_All auto
formlist property _Camp_HeatSources_Fire auto
formlist property _Camp_HeatSources_Fire_Small auto
formlist property _Camp_HeatSources_Fire_Medium auto
formlist property _Camp_HeatSources_Fire_Large auto
formlist property _Camp_HeatSources_Other auto

;#Trees============================================================================
;@TODO: Move to Frostfall
;TreeObject property TreeReachTreeStump01 auto hidden

;#DLC / Mod Worldspaces============================================================
Worldspace property DLC2WS auto hidden						;Solstheim

;#Campfire Perk System=============================================================
Activator property _Camp_PerkNavControllerAct auto
Activator property _Camp_PerkNodeController_Camping auto

GlobalVariable property EndurancePerkPoints auto hidden
GlobalVariable property EndurancePerkPointProgress auto hidden
GlobalVariable property ProvisioningPerkPoints auto hidden
GlobalVariable property ProvisioningPerkPointProgress auto hidden
GlobalVariable property FishingPerkPoints auto hidden
GlobalVariable property FishingPerkPointProgress auto hidden

;#Misc=============================================================================
GlobalVariable property _Camp_HotkeyCreateItem auto
GlobalVariable property _Camp_HotkeyBuildCampfire auto
GlobalVariable property _Camp_HotkeyHarvestWood auto
GlobalVariable property _Camp_HotkeyInstincts auto
GlobalVariable property _Camp_Setting_TrackFollowers auto

ConstructibleObject property _Camp_FireMiscRecipe_TinderStraw auto
ConstructibleObject property _Camp_FireMiscRecipe_TinderStraw_perk1 auto
ConstructibleObject property _Camp_FireMiscRecipe_TinderStraw_perk2 auto
ConstructibleObject property _Camp_FireMiscRecipe_TinderStraw_perk3 auto
ConstructibleObject property _Camp_FireMiscRecipe_TinderStraw_perk4 auto
ConstructibleObject property _Camp_FireMiscRecipe_BW_TinderStraw auto
ConstructibleObject property _Camp_FireMiscRecipe_BW_TinderStraw_perk1 auto
ConstructibleObject property _Camp_FireMiscRecipe_BW_TinderStraw_perk2 auto
ConstructibleObject property _Camp_FireMiscRecipe_BW_TinderStraw_perk3 auto
ConstructibleObject property _Camp_FireMiscRecipe_BW_TinderStraw_perk4 auto
ConstructibleObject property _Camp_RecipeLeatherValeDeerHideDLC1 auto
ConstructibleObject property _Camp_RecipeLeatherValeSabreCatHideDLC1 auto
ConstructibleObject property _Camp_RecipeTanningLeatherValeDeerHideDLC1 auto
ConstructibleObject property _Camp_RecipeTanningLeatherValeSabreCatHideDLC1 auto

Spell property _Camp_CreateItemSpell auto
Spell property _Camp_CampfireSpell auto
Spell property _Camp_HarvestWoodSpell auto
Spell property _Camp_SurvivalVisionPower auto
Spell property _Camp_LegacyConfig_Spell auto
Spell property _Camp_FollowerDetectSpell auto
Message property _Camp_CriticalError_SKSE auto
Weather property DLC2AshStorm auto hidden

; Testing
Activator property _Camp_PerkNodeControllerTest auto

;#Upgrade Flags====================================================================
bool Upgraded_1_1 = false


Event OnPlayerLoadGame()
	RunCompatibility()
	RegisterForKeysOnLoad()
	RegisterForControlsOnLoad()
	RegisterForEventsOnLoad()
endEvent

function RunCompatibility()
	VanillaGameLoadUp()

	trace("[Campfire]======================================================================================================")
	trace("[Campfire]     Campfire is now performing compatibility checks. Papyrus warnings about missing or               ")
	trace("[Campfire]             unloaded files may follow. This is NORMAL and can be ignored.   		                   ")
	trace("[Campfire]======================================================================================================")
	
	;@TODO: Add support for Frostfall compatibility
	;@TODO: Add fatal error for old version of Frostfall
	isFrostfallLoaded = false

	if !Upgraded_1_1
		Upgrade_1_1()
	endif

	bool skse_loaded = SKSE.GetVersion()
	if skse_loaded
		float skse_version = SKSE.GetVersion() + SKSE.GetVersionMinor() * 0.01 + SKSE.GetVersionBeta() * 0.0001
		if skse_version < SKSE_MIN_VERSION
			_Camp_CriticalError_SKSE.Show(skse_version, SKSE_MIN_VERSION)
			isSKSELoaded = false
			Conditions.IsSKSELoaded = false
		else
			isSKSELoaded = true
			Conditions.IsSKSELoaded = true
		endif
	endif
	
	if isSKYUILoaded
		isSKYUILoaded = IsPluginLoaded(0x01000814, "SkyUI.esp")
		if !isSKYUILoaded
			;SkyUI was removed since the last save.
		endif
	else
		isSKYUILoaded = IsPluginLoaded(0x01000814, "SkyUI.esp")
		if isSKYUILoaded
			;SkyUI was just loaded.
		endif
	endif

	if isDLC1Loaded
		isDLC1Loaded = IsPluginLoaded(0x02009403, "Dawnguard.esm")
		if !isDLC1Loaded
			;DLC1 was removed since the last save.
			Conditions.IsDawnguardLoaded = false
		else
			Conditions.IsDawnguardLoaded = true
		endif
	else
		isDLC1Loaded = IsPluginLoaded(0x02009403, "Dawnguard.esm")
		if isDLC1Loaded
			;DLC1 was just added.
			Conditions.IsDawnguardLoaded = true
		else
			Conditions.IsDawnguardLoaded = false
		endif
	endif

	if isDLC2Loaded
		isDLC2Loaded = IsPluginLoaded(0x0201FB99, "Dragonborn.esm")
		if !isDLC2Loaded
			;DLC2 was removed since the last save.
			Conditions.IsDragonbornLoaded = false
		else
			Conditions.IsDragonbornLoaded = true
		endif
	else
		isDLC2Loaded = IsPluginLoaded(0x0201FB99, "Dragonborn.esm")
		if isDLC2Loaded
			;DLC2 was just added.
			Conditions.IsDragonbornLoaded = true
		else
			Conditions.IsDragonbornLoaded = false
		endif
	endif
	
	if isHFLoaded
		isHFLoaded = IsPluginLoaded(0x0200306C, "HearthFires.esm")
		if !isHFLoaded
			;Hearthfire was removed since the last save.
			Conditions.IsHearthfireLoaded = false
		else
			Conditions.IsHearthfireLoaded = true
		endif
	else
		isHFLoaded = IsPluginLoaded(0x0200306C, "HearthFires.esm")
		if isHFLoaded
			;Hearthfire was just added.
			Conditions.IsHearthfireLoaded = true
		else
			Conditions.IsHearthfireLoaded = false
		endif
	endif
	
	if isIMCNLoaded
		isIMCNLoaded = IsPluginLoaded(0x0005CF47, "Imp's More Complex Needs.esp")
		if !isIMCNLoaded
			;Imp's More Complex Needs was removed since the last save.
		endif
	else
		isIMCNLoaded = IsPluginLoaded(0x0005CF47, "Imp's More Complex Needs.esp")
		if isIMCNLoaded
			;Imp's More Complex Needs was just added.
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x0005CF47, "Imp's More Complex Needs.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x0005CF4B, "Imp's More Complex Needs.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x0005CF4D, "Imp's More Complex Needs.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x0005CF49, "Imp's More Complex Needs.esp"))
		endif
	endif

	if isRNDLoaded
		isRNDLoaded = IsPluginLoaded(0x00047F94, "RealisticNeedsandDiseases.esp")
		if !isRNDLoaded
			;Realistic Needs and Diseases was removed since the last save.
		endif
	else
		isRNDLoaded = IsPluginLoaded(0x00047F94, "RealisticNeedsandDiseases.esp")
		if isRNDLoaded
			;Realistic Needs and Diseases was just added.
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x00047F94, "RealisticNeedsandDiseases.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x00047F96, "RealisticNeedsandDiseases.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x00047F9A, "RealisticNeedsandDiseases.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x00047F98, "RealisticNeedsandDiseases.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x000449AB, "RealisticNeedsandDiseases.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x00047F88, "RealisticNeedsandDiseases.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x00047F89, "RealisticNeedsandDiseases.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x00047F8B, "RealisticNeedsandDiseases.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x00069FBE, "RealisticNeedsandDiseases.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x00047FA2, "RealisticNeedsandDiseases.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x00047FA4, "RealisticNeedsandDiseases.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x00047FA5, "RealisticNeedsandDiseases.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x00047FA7, "RealisticNeedsandDiseases.esp"))

		endif
	endif

	if isINEEDLoaded
		isINEEDLoaded = IsPluginLoaded(0x0000437F, "iNeed.esp")
		if !isINEEDLoaded
			;iNeed was removed since the last save.
		endif
	else
		isINEEDLoaded = IsPluginLoaded(0x0000437F, "iNeed.esp")
		if isINEEDLoaded
			;iNeed was just added.
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x0000437F, "iNeed.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x0000437D, "iNeed.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x00004376, "iNeed.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x0003B2C5, "iNeed.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x0003B2C8, "iNeed.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x0003B2CC, "iNeed.esp"))
			_Camp_ModWaterSkins.AddForm(Game.GetFormFromFile(0x0003AD62, "iNeed.esp"))
		endif
	endif

	if isLastSeedLoaded
		isLastSeedLoaded = IsPluginLoaded(0x02000D63, "LastSeed.esp")
		if !isLastSeedLoaded
			;Last Seed was removed since the last save.
			Conditions.IsLastSeedLoaded = false
		else
			Conditions.IsLastSeedLoaded = true
		endif
	else
		isLastSeedLoaded = IsPluginLoaded(0x02000D63, "LastSeed.esp")
		if isLastSeedLoaded
			;Last Seed was just added.
			Conditions.IsLastSeedLoaded = true
		else
			Conditions.IsLastSeedLoaded = false
			
		endif
	endif
	
	if isDLC1Loaded
		
		;Add trees to valid tree formlist for wood harvesting
		form DLC01TreeForm01 = Game.GetFormFromFile(0x02009670, "Dawnguard.esm")	;DLC1TreePineForestSnowHeavy01
		form DLC01TreeForm02 = Game.GetFormFromFile(0x0200B55F, "Dawnguard.esm")	;DLC1TreePineForestSnowHeavy02
		form DLC01TreeForm03 = Game.GetFormFromFile(0x02003AC5, "Dawnguard.esm")	;TreeWinterAspen01
		form DLC01TreeForm04 = Game.GetFormFromFile(0x02003AC9, "Dawnguard.esm")	;TreeWinterAspen02
		form DLC01TreeForm05 = Game.GetFormFromFile(0x02003ACA, "Dawnguard.esm")	;TreeWinterAspen03
		form DLC01TreeForm06 = Game.GetFormFromFile(0x02003ACB, "Dawnguard.esm")	;TreeWinterAspen04
		form DLC01TreeForm07 = Game.GetFormFromFile(0x02003ACC, "Dawnguard.esm")	;TreeWinterAspen05
		form DLC01TreeForm08 = Game.GetFormFromFile(0x02003ACF, "Dawnguard.esm")	;TreeWinterAspen06
		form DLC01TreeForm09 = Game.GetFormFromFile(0x02004332, "Dawnguard.esm")	;TreeSoulCairnTree01
		form DLC01TreeForm10 = Game.GetFormFromFile(0x02004333, "Dawnguard.esm")	;TreeSoulCairnTree02
		form DLC01TreeForm11 = Game.GetFormFromFile(0x02004334, "Dawnguard.esm")	;TreeSoulCairnTree03
		form DLC01TreeForm12 = Game.GetFormFromFile(0x0200DDB5, "Dawnguard.esm")	;TreeSoulCairnTreeGroup
		
		;Add worldspaces to appropriate formlists for region detection
		form DLC01WS05 = Game.GetFormFromFile(0x020048C7, "Dawnguard.esm")			;DLC1AncestorsGladeWorld			;Interior
		form DLC01WS06 = Game.GetFormFromFile(0x02004BEA, "Dawnguard.esm")			;DLC1DarkfallPassageWorld			;Interior
		form DLC01WS07 = Game.GetFormFromFile(0x02002F64, "Dawnguard.esm")			;DLC1ForebearsHoldout				;Interior
			
		if !(_Camp_Trees.HasForm(DLC01TreeForm01))		
			_Camp_Trees.AddForm(DLC01TreeForm01)
			_Camp_Trees.AddForm(DLC01TreeForm02)
			_Camp_Trees.AddForm(DLC01TreeForm03)
			_Camp_Trees.AddForm(DLC01TreeForm04)
			_Camp_Trees.AddForm(DLC01TreeForm05)
			_Camp_Trees.AddForm(DLC01TreeForm06)
			_Camp_Trees.AddForm(DLC01TreeForm07)
			_Camp_Trees.AddForm(DLC01TreeForm08)
			_Camp_Trees.AddForm(DLC01TreeForm09)
			_Camp_Trees.AddForm(DLC01TreeForm10)
			_Camp_Trees.AddForm(DLC01TreeForm11)
			_Camp_Trees.AddForm(DLC01TreeForm12)
		endif
		
		if !(_Camp_WorldspacesInteriors.HasForm(DLC01WS05))
			_Camp_WorldspacesInteriors.AddForm(DLC01WS05)
			_Camp_WorldspacesInteriors.AddForm(DLC01WS06)
			_Camp_WorldspacesInteriors.AddForm(DLC01WS07)
		endif
			
	endif

	if isDLC2Loaded
		
		;Heat sources
		form DLC02HeatForm01 = Game.GetFormFromFile(0x02018616, "Dragonborn.esm")		;Campfire01LandBurning_SnowRocks
		form DLC02HeatForm02 = Game.GetFormFromFile(0x02018619, "Dragonborn.esm")		;Campfire01LandBurning_LDirtSnowPath
		form DLC02HeatForm03 = Game.GetFormFromFile(0x0201A56A, "Dragonborn.esm")		;DLC2FXFlamingRockDebris
		form DLC02HeatForm04 = Game.GetFormFromFile(0x0201A56B, "Dragonborn.esm")		;DLC2FXFlamingRockDebrisSmall
		form DLC02HeatForm05 = Game.GetFormFromFile(0x020289E8, "Dragonborn.esm")		;Campfire01LandBurning_Ash
		form DLC02HeatForm06 = Game.GetFormFromFile(0x0202C0B0, "Dragonborn.esm")		;Campfire01LandBurningDirtPath01
		form DLC02HeatForm07 = Game.GetFormFromFile(0x0203CF6E, "Dragonborn.esm")		;DLC2CraftingBlacksmithForge
		form DLC02HeatForm08 = Game.GetFormFromFile(0x0202B074, "Dragonborn.esm")		;DLC2CraftingBlacksmithSkaalForge

		if !(_Camp_HeatSources_All.HasForm(DLC02HeatForm01))
			_Camp_HeatSources_All.AddForm(DLC02HeatForm01)
			_Camp_HeatSources_All.AddForm(DLC02HeatForm02)
			_Camp_HeatSources_All.AddForm(DLC02HeatForm03)
			_Camp_HeatSources_All.AddForm(DLC02HeatForm04)
			_Camp_HeatSources_All.AddForm(DLC02HeatForm05)
			_Camp_HeatSources_All.AddForm(DLC02HeatForm06)
			_Camp_HeatSources_All.AddForm(DLC02HeatForm07)
			_Camp_HeatSources_All.AddForm(DLC02HeatForm08)
		endif
		if !(_Camp_HeatSources_Fire.HasForm(DLC02HeatForm01))
			_Camp_HeatSources_Fire.AddForm(DLC02HeatForm01)
			_Camp_HeatSources_Fire.AddForm(DLC02HeatForm02)
			_Camp_HeatSources_Fire.AddForm(DLC02HeatForm03)
			_Camp_HeatSources_Fire.AddForm(DLC02HeatForm04)
			_Camp_HeatSources_Fire.AddForm(DLC02HeatForm05)
			_Camp_HeatSources_Fire.AddForm(DLC02HeatForm06)
			_Camp_HeatSources_Fire.AddForm(DLC02HeatForm07)
			_Camp_HeatSources_Fire.AddForm(DLC02HeatForm08)
		endif
		if !(_Camp_HeatSources_Fire_Medium.HasForm(DLC02HeatForm01))
			_Camp_HeatSources_Fire_Medium.AddForm(DLC02HeatForm01)
			_Camp_HeatSources_Fire_Medium.AddForm(DLC02HeatForm02)
			_Camp_HeatSources_Fire_Medium.AddForm(DLC02HeatForm03)
			_Camp_HeatSources_Fire_Medium.AddForm(DLC02HeatForm04)
			_Camp_HeatSources_Fire_Medium.AddForm(DLC02HeatForm05)
			_Camp_HeatSources_Fire_Medium.AddForm(DLC02HeatForm06)
		endif

		;Trees
		form DLC02TreeForm01 = Game.GetFormFromFile(0x02017F76, "Dragonborn.esm")		;<DLC2TreePineForestAsh05>
		form DLC02TreeForm02 = Game.GetFormFromFile(0x02017F75, "Dragonborn.esm")		;<DLC2TreePineForestAsh04>
		form DLC02TreeForm03 = Game.GetFormFromFile(0x02017F74, "Dragonborn.esm")		;<DLC2TreePineForestAsh03>
		form DLC02TreeForm04 = Game.GetFormFromFile(0x02017F73, "Dragonborn.esm")		;<DLC2TreePineForestAsh02>
		form DLC02TreeForm05 = Game.GetFormFromFile(0x02017F72, "Dragonborn.esm")		;<DLC2TreePineForestAsh01>
		form DLC02TreeForm06 = Game.GetFormFromFile(0x02017F71, "Dragonborn.esm")		;<DLC2TreePineForestAshL05>
		form DLC02TreeForm07 = Game.GetFormFromFile(0x02017F70, "Dragonborn.esm")		;<DLC2TreePineForestAshL04>
		form DLC02TreeForm08 = Game.GetFormFromFile(0x02017F6F, "Dragonborn.esm")		;<DLC2TreePineForestAshL03>
		form DLC02TreeForm09 = Game.GetFormFromFile(0x02017F6E, "Dragonborn.esm")		;<DLC2TreePineForestAshL01>
		form DLC02TreeForm10 = Game.GetFormFromFile(0x02017F6D, "Dragonborn.esm")		;<DLC2TreePineForestAshL02>
		form DLC02TreeForm11 = Game.GetFormFromFile(0x02017F62, "Dragonborn.esm")		;<DLC2TreePineForestDeadAshL05>
		form DLC02TreeForm12 = Game.GetFormFromFile(0x02017F60, "Dragonborn.esm")		;<DLC2TreePineForestDeadAshL04>
		form DLC02TreeForm13 = Game.GetFormFromFile(0x02017F5C, "Dragonborn.esm")		;<DLC2TreePineForestDeadAshL03>
		form DLC02TreeForm14 = Game.GetFormFromFile(0x02017F5B, "Dragonborn.esm")		;<DLC2TreePineForestDeadAshL02>
		form DLC02TreeForm15 = Game.GetFormFromFile(0x02017F5A, "Dragonborn.esm")		;<DLC2TreePineForestDeadAshL01>
		form DLC02TreeForm16 = Game.GetFormFromFile(0x020195E8, "Dragonborn.esm")		;<DLC2TreePineForestBroken01>
		form DLC02TreeForm17 = Game.GetFormFromFile(0x020195F0, "Dragonborn.esm")		;<DLC2TreePineForestBroken01Ash>
		form DLC02TreeForm18 = Game.GetFormFromFile(0x020195EB, "Dragonborn.esm")		;<DLC2TreePineForestBroken02>
		form DLC02TreeForm19 = Game.GetFormFromFile(0x02017F77, "Dragonborn.esm")		;<DLC2TreePineForestBroken04>
		form DLC02TreeForm20 = Game.GetFormFromFile(0x020185E5, "Dragonborn.esm")		;<DLC2TreePineForestBroken05>
		form DLC02TreeForm21 = Game.GetFormFromFile(0x0201D500, "Dragonborn.esm")		;<DLC2TreePineForestBroken06>
		form DLC02TreeForm22 = Game.GetFormFromFile(0x0201D4F7, "Dragonborn.esm")		;<DLC2TreePineForestBrokenCluster01>
		form DLC02TreeForm23 = Game.GetFormFromFile(0x0201D73A, "Dragonborn.esm")		;<DLC2TreePineForestBrokenSmoking01>
		form DLC02TreeForm24 = Game.GetFormFromFile(0x020185EE, "Dragonborn.esm")		;<DLC2TreePineForestHollow01Ash>
		form DLC02TreeForm25 = Game.GetFormFromFile(0x02017F6A, "Dragonborn.esm")		;<DLC2TreePineForestHollow01AshL>
		form DLC02TreeForm26 = Game.GetFormFromFile(0x020185EF, "Dragonborn.esm")		;<DLC2TreePineForestLog01Ash>
		form DLC02TreeForm27 = Game.GetFormFromFile(0x02017F68, "Dragonborn.esm")		;<DLC2TreePineForestLog01AshL>
		form DLC02TreeForm28 = Game.GetFormFromFile(0x020185F0, "Dragonborn.esm")		;<DLC2TreePineForestLog02Ash>
		form DLC02TreeForm29 = Game.GetFormFromFile(0x02017F67, "Dragonborn.esm")		;<DLC2TreePineForestLog02AshL>
		form DLC02TreeForm30 = Game.GetFormFromFile(0x020185ED, "Dragonborn.esm")		;<DLC2TreePineForestStump01Ash>
		form DLC02TreeForm31 = Game.GetFormFromFile(0x02017F64, "Dragonborn.esm")		;<DLC2TreePineForestStump01AshL>
		
		if !(_Camp_Trees.HasForm(DLC02TreeForm01))
			_Camp_Trees.AddForm(DLC02TreeForm01)
			_Camp_Trees.AddForm(DLC02TreeForm02)
			_Camp_Trees.AddForm(DLC02TreeForm03)
			_Camp_Trees.AddForm(DLC02TreeForm04)
			_Camp_Trees.AddForm(DLC02TreeForm05)
			_Camp_Trees.AddForm(DLC02TreeForm06)
			_Camp_Trees.AddForm(DLC02TreeForm07)
			_Camp_Trees.AddForm(DLC02TreeForm08)
			_Camp_Trees.AddForm(DLC02TreeForm09)
			_Camp_Trees.AddForm(DLC02TreeForm10)
			_Camp_Trees.AddForm(DLC02TreeForm11)
			_Camp_Trees.AddForm(DLC02TreeForm12)
			_Camp_Trees.AddForm(DLC02TreeForm13)
			_Camp_Trees.AddForm(DLC02TreeForm14)
			_Camp_Trees.AddForm(DLC02TreeForm15)
			_Camp_Trees.AddForm(DLC02TreeForm16)
			_Camp_Trees.AddForm(DLC02TreeForm17)
			_Camp_Trees.AddForm(DLC02TreeForm18)
			_Camp_Trees.AddForm(DLC02TreeForm19)
			_Camp_Trees.AddForm(DLC02TreeForm20)
			_Camp_Trees.AddForm(DLC02TreeForm21)
			_Camp_Trees.AddForm(DLC02TreeForm22)
			_Camp_Trees.AddForm(DLC02TreeForm23)
			_Camp_Trees.AddForm(DLC02TreeForm24)
			_Camp_Trees.AddForm(DLC02TreeForm25)
			_Camp_Trees.AddForm(DLC02TreeForm26)
			_Camp_Trees.AddForm(DLC02TreeForm27)
			_Camp_Trees.AddForm(DLC02TreeForm28)
			_Camp_Trees.AddForm(DLC02TreeForm29)
			_Camp_Trees.AddForm(DLC02TreeForm30)
			_Camp_Trees.AddForm(DLC02TreeForm31)
		endif
		
		;Weather
		DLC2AshStorm = Game.GetFormFromFile(0x02032336, "Dragonborn.esm") as Weather
		
		if ((self as ReferenceAlias) as _Camp_LegalAreaCheck).DLC2RavenRockCenterMarker == none
			((self as ReferenceAlias) as _Camp_LegalAreaCheck).DLC2RavenRockCenterMarker = Game.GetFormFromFile(0x020295EA, "Dragonborn.esm") as ObjectReference
		endif

		;Worldspaces
		form DLC02WS02 = Game.GetFormFromFile(0x02000800, "Dragonborn.esm")			;Solstheim
		if !DLC2WS
			DLC2WS = DLC02WS02 as Worldspace
		endif
		
	endif

	if isFrostfallLoaded
		EndurancePerkPoints = Game.GetFormFromFile(0x00000000, "Frostfall.esp") as GlobalVariable
		EndurancePerkPointProgress = Game.GetFormFromFile(0x00000000, "Frostfall.esp") as GlobalVariable
		Activator node_controller = Game.GetFormFromFile(0x00000000, "Frostfall.esp") as Activator
		CampfirePerkSystemRegister(node_controller, 1, "Frostfall.esp")
	else
		CampfirePerkSystemUnregister(1, "Frostfall.esp")
	endif
	
	if isLastSeedLoaded
		ProvisioningPerkPoints = Game.GetFormFromFile(0x00000000, "LastSeed.esp") as GlobalVariable
		ProvisioningPerkPointProgress = Game.GetFormFromFile(0x00000000, "LastSeed.esp") as GlobalVariable
		Activator node_controller = Game.GetFormFromFile(0x00000000, "LastSeed.esp") as Activator
		CampfirePerkSystemRegister(node_controller, 2, "LastSeed.esp")
	else
		CampfirePerkSystemUnregister(2, "LastSeed.esp")
	endif


	if isArtOfTheCatchLoaded
		FishingPerkPoints = Game.GetFormFromFile(0x00000000, "ArtOfTheCatch.esp") as GlobalVariable
		FishingPerkPointProgress = Game.GetFormFromFile(0x00000000, "ArtOfTheCatch.esp") as GlobalVariable
		Activator node_controller = Game.GetFormFromFile(0x00000000, "ArtOfTheCatch.esp") as Activator
		CampfirePerkSystemRegister(node_controller, 3, "ArtOfTheCatch.esp")
	else
		CampfirePerkSystemUnregister(3, "ArtOfTheCatch.esp")
	endif

	;#Region SKSE + Mod Support Section
	if isHFLoaded && isSKSELoaded
		form Straw = Game.GetFormFromFile(0x00005A68, "HearthFires.esm")				;Straw
		_Camp_FireMiscRecipe_TinderStraw.SetNthIngredient(Straw, 0)
		_Camp_FireMiscRecipe_TinderStraw_perk1.SetNthIngredient(Straw, 0)
		_Camp_FireMiscRecipe_TinderStraw_perk2.SetNthIngredient(Straw, 0)
		_Camp_FireMiscRecipe_TinderStraw_perk3.SetNthIngredient(Straw, 0)
		_Camp_FireMiscRecipe_TinderStraw_perk4.SetNthIngredient(Straw, 0)
		_Camp_FireMiscRecipe_BW_TinderStraw.SetNthIngredient(Straw, 0)
		_Camp_FireMiscRecipe_BW_TinderStraw_perk1.SetNthIngredient(Straw, 0)
		_Camp_FireMiscRecipe_BW_TinderStraw_perk2.SetNthIngredient(Straw, 0)
		_Camp_FireMiscRecipe_BW_TinderStraw_perk3.SetNthIngredient(Straw, 0)
		_Camp_FireMiscRecipe_BW_TinderStraw_perk4.SetNthIngredient(Straw, 0)
	endif
	
	if isDLC1Loaded && isSKSELoaded
		form ValeDeerHide = Game.GetFormFromFile(0x02011999, "Dawnguard.esm")			;Vale Deer Hide
		form ValeSabreCatHide = Game.GetFormFromFile(0x0201199A, "Dawnguard.esm")		;Vale Sabre Cat Hide
		_Camp_RecipeLeatherValeDeerHideDLC1.SetNthIngredient(ValeDeerHide, 0)
		_Camp_RecipeLeatherValeSabreCatHideDLC1.SetNthIngredient(ValeSabreCatHide, 0)
		_Camp_RecipeTanningLeatherValeDeerHideDLC1.SetNthIngredient(ValeDeerHide, 0)
		_Camp_RecipeTanningLeatherValeSabreCatHideDLC1.SetNthIngredient(ValeSabreCatHide, 0)
	endif
	
	trace("[Campfire]======================================================================================================")
	trace("[Campfire]                            Campfire compatibility check complete.   		                           ")
	trace("[Campfire]======================================================================================================")

	if isSKSELoaded
		RegisterForControlsOnLoad()
		RegisterForEventsOnLoad()
	endif
	AddStartupSpells()

	; Testing perk trees
	CampfirePerkSystemRegister(_Camp_PerkNodeControllerTest, 1, "TestPlugin.esp")
	CountPerkTrees()
endFunction

bool function IsPluginLoaded(int iFormID, string sPluginName)
	if isSKSELoaded
		int i = Game.GetModByName(sPluginName)
		if i != 255
			debug.trace("[Campfire] Loaded: " + sPluginName)
			return true
		else
			return false
		endif
	else
		bool b = Game.GetFormFromFile(iFormID, sPluginName)
		if b
			debug.trace("[Campfire] Loaded: " + sPluginName)
			return true
		else
			return false
		endif
	endif
endFunction

function Upgrade_1_1()
	PerkNodeControllers = new Activator[4]
	CampfirePerkSystemRegister(_Camp_PerkNodeController_Camping, 0, "Campfire.esm")
	Upgraded_1_1 = true
endFunction

function CampfirePerkSystemRegister(Activator akNodeController, int aiIndex, string asPluginName)
	if PerkNodeControllers[aiIndex] == None
		PerkNodeControllers[aiIndex] = akNodeController
		debug.trace("[Campfire] Registered Campfire Perk System mod: " + asPluginName)
	endif
endFunction

function CampfirePerkSystemUnregister(int aiIndex, string asPluginName)
	PerkNodeControllers[aiIndex] = None
	debug.trace("[Campfire] Unregistered Campfire Perk System mod: " + asPluginName)
endFunction

function VanillaGameLoadUp()
	; Verify quests are running and aliases are filled
	if !_Camp_MainQuest.IsRunning()
		_Camp_MainQuest.Start()
	endif
	if !_Camp_FollowerQuest.IsRunning()
		_Camp_FollowerQuest.Start()
	endif

	if !PlayerAlias.GetActorRef()
		PlayerAlias.ForceRefTo(PlayerRef)
	endif

	; Grab forms we can't fill as properties
	PlacementSystem.SmallFire = Game.GetFormFromFile(0x00013B40, "Skyrim.esm")
	
	;@TODO: Move to Frostfall
	; TreeReachTreeStump01 = Game.GetFormFromFile(0x000B8A75, "Skyrim.esm") as TreeObject
endFunction


function AddStartupSpells()							;Approved 2.0
	if isSKYUILoaded
		PlayerRef.RemoveSpell(_Camp_LegacyConfig_Spell)
	else
		PlayerRef.AddSpell(_Camp_LegacyConfig_Spell, false)
	endif

	if isSKYUILoaded
		if _Camp_HotkeyCreateItem.GetValueInt() != 0
			PlayerRef.RemoveSpell(_Camp_CreateItemSpell)
		else
			PlayerRef.AddSpell(_Camp_CreateItemSpell, false)
		endif
		if _Camp_HotkeyBuildCampfire.GetValueInt() != 0
			PlayerRef.RemoveSpell(_Camp_CampfireSpell)
		else
			PlayerRef.AddSpell(_Camp_CampfireSpell, false)
		endif
		if _Camp_HotkeyHarvestWood.GetValueInt() != 0
			PlayerRef.RemoveSpell(_Camp_HarvestWoodSpell)
		else
			PlayerRef.AddSpell(_Camp_HarvestWoodSpell, false)
		endif
		if _Camp_HotkeyInstincts.GetValueInt() != 0
			PlayerRef.RemoveSpell(_Camp_SurvivalVisionPower)
		else
			PlayerRef.AddSpell(_Camp_SurvivalVisionPower, false)
		endif
	else
		PlayerRef.AddSpell(_Camp_CreateItemSpell, false)
		PlayerRef.AddSpell(_Camp_CampfireSpell, false)
		PlayerRef.AddSpell(_Camp_HarvestWoodSpell, false)
		if isSKSELoaded
			PlayerRef.AddSpell(_Camp_SurvivalVisionPower, false)
		endif
		_Camp_HotkeyCreateItem.SetValueInt(0)
		_Camp_HotkeyBuildCampfire.SetValueInt(0)
		_Camp_HotkeyHarvestWood.SetValueInt(0)
		_Camp_HotkeyInstincts.SetValueInt(0)
	endif

	if _Camp_Setting_TrackFollowers.GetValueInt() == 2
		PlayerRef.AddSpell(_Camp_FollowerDetectSpell, false)
	endif
endFunction

function CountPerkTrees()
    int i = 0
    int count = 0
    while i < PerkNodeControllers.Length
        if PerkNodeControllers[i] != None
            count += 1
        endif
        i += 1
    endWhile
    if count > 1
    	multiple_perk_trees = true
    else
    	multiple_perk_trees = false
    endif
endFunction

function RegisterForKeysOnLoad()
	CampConfig.RegisterForKeysOnLoad()
endFunction

function RegisterForControlsOnLoad()
	CampDebug(0, "Compatibility is trying to call Campfire.RegisterForControlsOnLoad()")
	Campfire.RegisterForControlsOnLoad()
endFunction

function RegisterForEventsOnLoad()
	Campfire.RegisterForEventsOnLoad()
endFunction
