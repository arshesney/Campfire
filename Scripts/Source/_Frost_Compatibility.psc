scriptname _Frost_Compatibility extends ReferenceAlias

import debug
import FrostUtil

int property SKSE_MIN_VERSION = 10703 autoReadOnly
float property CAMPFIRE_MIN_VERSION = 1.7 autoReadOnly
GlobalVariable property _Frost_PreviousVersion auto
GlobalVariable property _Frost_FrostfallVersion auto

string CONFIG_PATH = "../FrostfallData/"
bool datastore_update_required = false

;#PROPERTIES=====================================================================================================================
actor property PlayerRef auto
ReferenceAlias property PlayerAlias auto
Spell property _Frost_Weathersense_Spell auto
GlobalVariable property _Frost_HotkeyWeathersense auto

;#Scripts======================================================================
_Frost_SkyUIConfigPanelScript property FrostConfig Auto 			;SkyUI Configuration script
_Frost_ConditionValues property Conditions auto

;#Official DLC=================================================================
bool property isDLC1Loaded auto	hidden						;Dawnguard
bool property isDLC2Loaded auto hidden						;Dragonborn
bool property isHFLoaded auto hidden						;Hearthfire

;#Supported Mods===============================================================
bool property isUIPackageInstalled auto hidden				;SkyUI optional UI package
bool property isSKYUILoaded auto hidden						;SkyUI 4.1+
bool property isLastSeedLoaded auto hidden					;Last Seed
bool property isCOTLoaded auto hidden						;Climates of Tamriel
bool property isIMALoaded auto hidden						;Immersive Armors 7.1
bool property isWTHLoaded auto hidden						;Wyrmstooth
bool property isSKYRELoaded auto hidden						;Skyim Redone
bool property isSCLoaded auto hidden						;Scenic Carriages
bool property isNFHLoaded auto hidden						;Northborn Fur Hoods
bool property isWICLoaded auto hidden						;Winter is Coming
bool property isCOSLoaded auto hidden						;Cloaks of Skyrim
bool property isCOSDGLoaded auto hidden						;Cloaks of Skyrim - Dawnguard
bool property isHDTCloaksLoaded auto hidden					;Illustrious HDT Cloaks
bool property isAEALoaded auto hidden						;Aesir Armor
bool property isWACLoaded auto hidden						;Wet and Cold
bool property isSSILoaded auto hidden						;Summerset Isle
bool property isDRKLoaded auto hidden						;DarkenD

;#Factions=====================================================================
Faction property _WetIsUnderShelterFaction auto hidden

;#Merchant Containers==========================================================
;ObjectReference property MerchantRiverwoodTraderContainer auto

;#FormLists====================================================================
Formlist property _Camp_WorldspacesInteriors auto
Formlist property _Frost_WorldspacesFTException auto
Formlist property _Frost_SevereWeatherList auto
Formlist property _Frost_OvercastWeatherList auto
Formlist property _Frost_FastTravelExceptions auto
Formlist property _Frost_ExposureExceptions auto
Formlist property _Camp_HeatSources_All auto
Formlist property _Camp_HeatSources_Other auto

;#Trees============================================================================
;TreeObject property TreeReachTreeStump01 auto hidden

;#DLC / Mod Worldspaces============================================================
Worldspace property WS_FalmerValley auto hidden
Worldspace property WS_Solstheim auto hidden
Worldspace property WS_Wyrmstooth auto hidden
Worldspace property WS_Darkend auto hidden

;#DLC / Mod Area Arrays============================================================
float[] DLC1_FVCanyon_PolyX
float[] DLC1_FVCanyon_PolyY
float[] DLC1_FVIce_PolyX
float[] DLC1_FVIce_PolyY
float[] DLC1_FVPlayground_PolyX
float[] DLC1_FVPlayground_PolyY
float[] DLC1_FVGrove_PolyX
float[] DLC1_FVGrove_PolyY
float[] DLC1_FVBoss_PolyX
float[] DLC1_FVBoss_PolyY

float[] DLC2_Solstheim_PolyX
float[] DLC2_Solstheim_PolyY

float[] Wyrmstooth_Center_PolyX
float[] Wyrmstooth_Center_PolyY
float[] Wyrmstooth_West_PolyX
float[] Wyrmstooth_West_PolyY

float[] DNKD_Phalos_Frozen_PolyX
float[] DNKD_Phalos_Frozen_PolyY

;#Leveled Lists================================================================
LeveledItem property LItemSpellTomes00AllIllusion auto
LeveledItem property LItemSpellTomes00AllSpells auto
LeveledItem property LItemSpellTomes00Illusion auto
LeveledItem property LItemSpellTomes00Spells auto
LeveledItem property LItemSpellTomes25AllAlteration auto
LeveledItem property LItemSpellTomes25Alteration auto
LeveledItem property LItemSpellTomes25AllIllusion auto
LeveledItem property LItemSpellTomes25Illusion auto
LeveledItem property LItemSpellTomes25AllConjuration auto
LeveledItem property LItemSpellTomes25Conjuration auto
LeveledItem property LItemSpellTomes50AllAlteration auto
LeveledItem property LItemSpellTomes50Alteration auto
LeveledItem property LItemSpellTomes50Spells auto
LeveledItem property LitemSpellTomes50AllDestruction auto
LeveledItem property LitemSpellTomes50Destruction auto
LeveledItem property LItemSpellTomes50AllIllusion auto
LeveledItem property LItemSpellTomes50Illusion auto
LeveledItem property LItemSpellTOmes50AllRestoration auto
LeveledItem property LItemSpellTOmes50Restoration auto
LeveledItem property LItemSpellTomes50AllConjuration auto
LeveledItem property LItemSpellTomes50Conjuration auto
LeveledItem property LItemSpellTomes75Conjuration auto
LeveledItem property LItemSpellTomes75AllConjuration auto
LeveledItem property LItemSpellTomes75Alteration auto
LeveledItem property LItemSpellTomes75AllAlteration auto
LeveledItem property LItemSpellTomes75Spells auto
LeveledItem property LItemSpellTomes100Conjuration auto
LeveledItem property MGRitualConjurationBooks auto
LeveledItem property LItemScroll00Skill auto
LeveledItem property LItemScroll25Skill auto
LeveledItem property LItemScroll50Skill auto
LeveledItem property LItemScroll75Skill auto
LeveledItem property LItemScroll100Skill auto

;#Spellbooks===================================================================
book property _Frost_SpellTomeSoothe1 auto
book property _Frost_SpellTomeFoxskin auto
book property _Frost_SpellTomeSoothe2 auto
book property _Frost_SpellTomeBoundCloakLesser auto
book property _Frost_SpellTomeWolfskin auto
book property _Frost_SpellTomeVaporBlast auto
book property _Frost_SpellTomeSoothe3 auto
book property _Frost_SpellTomeKindle auto
book property _Frost_SpellTomeBoundCloakGreater auto
book property _Frost_SpellTomeConjureShelterLesser auto
book property _Frost_SpellTomeTransmuteWood auto
book property _Frost_SpellTomeBearskin auto
book property _Frost_SpellTomeConjureShelterGreater auto

;#Scrolls======================================================================
scroll property _Frost_ScrollSoothe auto
scroll property _Frost_ScrollBask auto
scroll property _Frost_ScrollFoxskin auto
scroll property _Frost_ScrollBoundCloakLesser auto
scroll property _Frost_ScrollRevel auto
scroll property _Frost_ScrollWolfskin auto
scroll property _Frost_ScrollVaporBlast auto
scroll property _Frost_ScrollKindle auto
scroll property _Frost_ScrollBoundCloakGreater auto
scroll property _Frost_ScrollBearskin auto
scroll property _Frost_ScrollConjureShelterLesser auto
scroll property _Frost_ScrollConjureShelterGreater auto

;#Campfire Skill System============================================================
Activator property _Frost_PerkNodeController_Endurance auto

;#Misc=============================================================================
Armor property ArmorHideCuirass auto
Message property _Frost_CriticalError_SKSE auto
Message property _Frost_CriticalError_Campfire auto
Message property _Frost_CriticalError_SkyUIInterfacePackage auto
Weather property DLC2AshStorm auto hidden
bool added_spell_books = false

;#Upgrade Flags====================================================================
GlobalVariable property _Frost_Setting_1PAnimationAllowed auto
GlobalVariable property _Frost_Upgraded_3_0_1 auto
GlobalVariable property _Frost_Upgraded_3_0_2 auto
GlobalVariable property _Frost_Upgraded_3_1 auto

Event OnPlayerLoadGame()
	RunCompatibility()
	RegisterForKeysOnLoad()
	RegisterForControlsOnLoad()
	RegisterForEventsOnLoad()

	; Notify that we are finished loading up.
	SendEvent_FrostfallLoaded()
endEvent

function FatalErrorSKSE(int version)
	trace("[Frostfall][ERROR] Detected SKSE version " + ((version as float) / 10000) + ", out of date! Expected " + ((SKSE_MIN_VERSION as float) / 10000) + " or newer.")
	while true
		_Frost_CriticalError_SKSE.Show(((version as float) / 10000), ((SKSE_MIN_VERSION as float) / 10000))
		utility.wait(3.0)
	endWhile
endFunction

function FatalErrorCampfire(float version)
	trace("[Frostfall][ERROR] Detected Campfire version " + version + ", out of date! Expected " + CAMPFIRE_MIN_VERSION + " or newer.")
	while true
		_Frost_CriticalError_Campfire.Show(version, CAMPFIRE_MIN_VERSION)
		utility.wait(3.0)
	endWhile
endFunction

function FatalErrorSkyUIPackage(int skyui_version)
	trace("[Frostfall][ERROR] Detected optional Frostfall SkyUI Interface Package, but the wrong version of SkyUI is installed!")
	while true
		_Frost_CriticalError_SkyUIInterfacePackage.Show(skyui_version)
		utility.wait(3.0)
	endWhile
endFunction


function RunCompatibility()
	VanillaGameLoadUp()

	trace("[Frostfall]======================================================================================================")
	trace("[Frostfall]                          Frostfall is now performing compatibility checks.                           ")
	trace("[Frostfall]======================================================================================================")
	
	bool can_read_write = CheckJSONReadWrite()
	if !can_read_write
		; ERROR
	endif

	if _Frost_Upgraded_3_0_1.GetValueInt() != 2
		Upgrade_3_0_1()
	endif

	if _Frost_Upgraded_3_0_2.GetValueInt() != 2
		Upgrade_3_0_2()
	endif

	if _Frost_Upgraded_3_1.GetValueInt() != 2
		Upgrade_3_1()
	endif

	if can_read_write
		; Verify that the default datastore has been populated.
		_Frost_ArmorProtectionDatastoreHandler handler = GetClothingDatastoreHandler()
		int[] armor_data = handler.GetDefaultArmorData(ArmorHideCuirass, true)
		if armor_data[0] == -1
			PopulateDefaultArmorData()
		endif
	endif

	; Update the previous version value with the current version
	_Frost_PreviousVersion.SetValue(_Frost_FrostfallVersion.GetValue())

	bool skse_loaded = SKSE.GetVersion()
	if skse_loaded
		int skse_version = (SKSE.GetVersion() * 10000) + (SKSE.GetVersionMinor() * 100) + SKSE.GetVersionBeta()
		if skse_version < SKSE_MIN_VERSION
			FatalErrorSKSE(skse_version)
		else
			trace("[Frostfall] Detected SKSE version " + ((skse_version as float) / 10000) + " (expected " + ((SKSE_MIN_VERSION as float) / 10000) + " or newer, success!)")
		endif
	else
		FatalErrorSKSE(0)
	endif

	float campfire_version = CampUtil.GetCampfireVersion()
	if campfire_version < CAMPFIRE_MIN_VERSION
		FatalErrorCampfire(campfire_version)
	else
		trace("[Frostfall] Detected Campfire version " + campfire_version + " (expected " + CAMPFIRE_MIN_VERSION + " or newer, success!)")
	endif
	
	int ui_package_version_installed = JsonUtil.GetIntValue(CONFIG_PATH + "interface_package_version", "installed_package_version")
	if ui_package_version_installed == 5
		SKI_Main skyui = Game.GetFormFromFile(0x00000814, "SkyUI.esp") as SKI_Main
		int skyui_version = skyui.ReqSWFRelease
		if skyui_version >= 1026 	; SkyUI 5.1+
			isUIPackageInstalled = true
			trace("[Frostfall] Detected optional SkyUI Interface Package version " + ui_package_version_installed + " and SkyUI version " + skyui_version + ", success!")
		else
			isUIPackageInstalled = false
			FatalErrorSkyUIPackage(5)
		endif
	else
		isUIPackageInstalled = false
	endif

	;@TODO: Rework to check version. SkyUI is now required.
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
		endif
	else
		isDLC1Loaded = IsPluginLoaded(0x02009403, "Dawnguard.esm")
		if isDLC1Loaded
			;DLC1 was just added.
			DLC1LoadUp()
			Conditions.IsDawnguardLoaded = true
		endif
	endif

	if isDLC2Loaded
		isDLC2Loaded = IsPluginLoaded(0x0201FB99, "Dragonborn.esm")
		if !isDLC2Loaded
			;DLC2 was removed since the last save.
			Conditions.IsDragonbornLoaded = false
		endif
	else
		isDLC2Loaded = IsPluginLoaded(0x0201FB99, "Dragonborn.esm")
		if isDLC2Loaded
			;DLC2 was just added.
			DLC2LoadUp()
			Conditions.IsDragonbornLoaded = true
		endif
	endif
	
	if isHFLoaded
		isHFLoaded = IsPluginLoaded(0x0200306C, "HearthFires.esm")
		if !isHFLoaded
			;Hearthfire was removed since the last save.
			Conditions.IsHearthfireLoaded = false
		endif
	else
		isHFLoaded = IsPluginLoaded(0x0200306C, "HearthFires.esm")
		if isHFLoaded
			;Hearthfire was just added.
			Conditions.IsHearthfireLoaded = true
		endif
	endif

	if isLastSeedLoaded
		isLastSeedLoaded = IsPluginLoaded(0x02000D63, "LastSeed.esp")
		if !isLastSeedLoaded
			;Last Seed was removed since the last save.
			Conditions.IsLastSeedLoaded = false
		endif
	else
		isLastSeedLoaded = IsPluginLoaded(0x02000D63, "LastSeed.esp")
		if isLastSeedLoaded
			;Last Seed was just added.
			Conditions.IsLastSeedLoaded = true
		endif
	endif

	

	if isWTHLoaded
		isWTHLoaded = IsPluginLoaded(0x01000D62, "Wyrmstooth.esp")
		if !isWTHLoaded
			;Wyrmstooth was removed since the last save.
		endif
	else
		isWTHLoaded = IsPluginLoaded(0x01000D62, "Wyrmstooth.esp")
		if isWTHLoaded
			;Wyrmstooth was just added.
			WTHLoadUp()
		endif
	endif

	if isSKYRELoaded
		isSKYRELoaded = IsPluginLoaded(0x0008D73F, "SkyRe_Main.esp")
		if !isSKYRELoaded
			;SkyRe was removed since the last save.
			Conditions.IsSkyReLoaded = false
		else
			Conditions.IsSkyReLoaded = true
		endif
	else
		isSKYRELoaded = IsPluginLoaded(0x0008D73F, "SkyRe_Main.esp")
		if isSKYRELoaded
			;SkyRe was just added.
			Conditions.IsSkyReLoaded = true
		else
			Conditions.IsSkyReLoaded = false
		endif
	endif

	; DarkenD

	if isCOTLoaded
		isCOTLoaded = IsPluginLoaded(0x01068A1A, "ClimatesOfTamriel.esm")
		if !isCOTLoaded
			;Climates of Tamriel was removed since the last save.
		endif
	else
		isCOTLoaded = IsPluginLoaded(0x01068A1A, "ClimatesOfTamriel.esm")
		if isCOTLoaded
			;Climates of Tamriel was just added.
			if !(_Frost_SevereWeatherList.HasForm(Game.GetFormFromFile(0x01068A1A, "ClimatesOfTamriel.esm")))
				_Frost_SevereWeatherList.AddForm(Game.GetFormFromFile(0x01068A1A, "ClimatesOfTamriel.esm"))				;CoTSnowBlizzard_Swirl
				_Frost_SevereWeatherList.AddForm(Game.GetFormFromFile(0x0106C559, "ClimatesOfTamriel.esm"))				;CoTSnowBlizzard_Down_NoFog
				_Frost_SevereWeatherList.AddForm(Game.GetFormFromFile(0x0104483A, "ClimatesOfTamriel.esm"))				;CoTOvercast_6_HR
				_Frost_SevereWeatherList.AddForm(Game.GetFormFromFile(0x01044838, "ClimatesOfTamriel.esm"))				;CoTOvercast_5_HR
				_Frost_SevereWeatherList.AddForm(Game.GetFormFromFile(0x01044836, "ClimatesOfTamriel.esm"))				;CoTOvercast_4_HR_T
				_Frost_SevereWeatherList.AddForm(Game.GetFormFromFile(0x01044832, "ClimatesOfTamriel.esm"))				;CoTOvercast_2_HR
				_Frost_SevereWeatherList.AddForm(Game.GetFormFromFile(0x01044831, "ClimatesOfTamriel.esm"))				;CoTOvercast_1_HR_T
			endif	
			if !(_Frost_OvercastWeatherList.HasForm(Game.GetFormFromFile(0x0104482F, "ClimatesOfTamriel.esm")))
				_Frost_OvercastWeatherList.AddForm(Game.GetFormFromFile(0x0104482F, "ClimatesOfTamriel.esm"))			;CoTOvercast_6_T
				_Frost_OvercastWeatherList.AddForm(Game.GetFormFromFile(0x0104482E, "ClimatesOfTamriel.esm"))			;CoTOvercast_5_T
				_Frost_OvercastWeatherList.AddForm(Game.GetFormFromFile(0x0104482D, "ClimatesOfTamriel.esm"))			;CoTOvercast_3_T
				_Frost_OvercastWeatherList.AddForm(Game.GetFormFromFile(0x0104482C, "ClimatesOfTamriel.esm"))			;CoTOvercast_4_T
				_Frost_OvercastWeatherList.AddForm(Game.GetFormFromFile(0x0104482B, "ClimatesOfTamriel.esm"))			;CoTOvercast_2_T
				_Frost_OvercastWeatherList.AddForm(Game.GetFormFromFile(0x0104482A, "ClimatesOfTamriel.esm"))			;CoTOvercast_1_T
				_Frost_OvercastWeatherList.AddForm(Game.GetFormFromFile(0x01044829, "ClimatesOfTamriel.esm"))			;CoTOvercast_6_AM
				_Frost_OvercastWeatherList.AddForm(Game.GetFormFromFile(0x01044827, "ClimatesOfTamriel.esm"))			;CoTOvercast_5_AP
				_Frost_OvercastWeatherList.AddForm(Game.GetFormFromFile(0x01044826, "ClimatesOfTamriel.esm"))			;CoTOvercast_4
				_Frost_OvercastWeatherList.AddForm(Game.GetFormFromFile(0x01044825, "ClimatesOfTamriel.esm"))			;CoTOvercast_3
				_Frost_OvercastWeatherList.AddForm(Game.GetFormFromFile(0x01044824, "ClimatesOfTamriel.esm"))			;CoTOvercast_2
				_Frost_OvercastWeatherList.AddForm(Game.GetFormFromFile(0x010437F9, "ClimatesOfTamriel.esm"))			;CoTOvercast_1
			endif
		endif
	endif

	if isSCLoaded
		isSCLoaded = IsPluginLoaded(0x010215C5, "ScenicCarriages.esp")
		if !isSCLoaded
			;Scenic Carriages was removed since the last save.
		endif
	else
		isSCLoaded = IsPluginLoaded(0x010215C5, "ScenicCarriages.esp")
		if isSCLoaded
			Form myCarriage = Game.GetFormFromFile(0x010215C5, "ScenicCarriages.esp")
			if !(_Frost_ExposureExceptions.HasForm(myCarriage))
				_Frost_ExposureExceptions.AddForm(myCarriage)
			endif
			if !(_Frost_FastTravelExceptions.HasForm(myCarriage))
				_Frost_FastTravelExceptions.AddForm(myCarriage)
			endif
		endif
	endif

	if isSSILoaded
		isSSILoaded = IsPluginLoaded(0x00AE416D, "summersetisles.esp")
		if !isSSILoaded
			;Summerset Isle is not loaded.
		endif
	else
		isSSILoaded = IsPluginLoaded(0x00AE416D, "summersetisles.esp")
		if isSSILoaded
			Form ssi_1 = Game.GetFormFromFile(0x00AE416D, "summersetisles.esp")
			Form ssi_2 = Game.GetFormFromFile(0x002822DC, "summersetisles.esp")
			Form ssi_3 = Game.GetFormFromFile(0x0026C9F0, "summersetisles.esp")
			Form ssi_4 = Game.GetFormFromFile(0x000C7888, "summersetisles.esp")
			Form ssi_5 = Game.GetFormFromFile(0x000AA978, "summersetisles.esp")
			Form ssi_6 = Game.GetFormFromFile(0x000A351C, "summersetisles.esp")

			if !(_Frost_WorldspacesFTException.HasForm(ssi_1))
				_Frost_WorldspacesFTException.AddForm(ssi_1)
				_Frost_WorldspacesFTException.AddForm(ssi_2)
				_Frost_WorldspacesFTException.AddForm(ssi_3)
				_Frost_WorldspacesFTException.AddForm(ssi_4)
				_Frost_WorldspacesFTException.AddForm(ssi_5)
				_Frost_WorldspacesFTException.AddForm(ssi_6)
			endif
		endif
	endif

	if isDRKLoaded
		isDRKLoaded = IsPluginLoaded(0x00000D62, "Darkend.esp")
		if !isDRKLoaded
			;DarkenD was removed.
		endif
	else
		isDRKLoaded = IsPluginLoaded(0x00000D62, "Darkend.esp")
		if isDRKLoaded
			DRKLoadUp()
		endif
	endif

	RunCompatibilityArmors()
	
	trace("[Frostfall]======================================================================================================")
	trace("[Frostfall]                            Frostfall compatibility check complete.   		                        ")
	trace("[Frostfall]======================================================================================================")

	FrostConfig.LoadProfileOnStartup()
	
	RegisterForControlsOnLoad()
	RegisterForEventsOnLoad()
	RegisterForMenusOnLoad()
	AddStartupSpells()
	RegisterCampfireSkill()
endFunction

function Upgrade_3_0_1()
	; Deprecate the 1st Person Hand Warming Animation setting
	_Frost_Setting_1PAnimationAllowed.SetValueInt(0)
	
	trace("[Frostfall] Upgraded to 3.0.1.")
	_Frost_Upgraded_3_0_1.SetValueInt(2)
endFunction

function Upgrade_3_0_2()
	; Include the Conjured Shelter spells in leveled lists.
	
	;75
	LItemSpellTomes75AllConjuration.AddForm(_Frost_SpellTomeConjureShelterLesser, 1, 1)
	LItemSpellTomes75Conjuration.AddForm(_Frost_SpellTomeConjureShelterLesser, 1, 1)
	LItemSpellTomes75Spells.AddForm(_Frost_SpellTomeConjureShelterLesser, 1, 1)
	LItemScroll75Skill.AddForm(_Frost_ScrollConjureShelterLesser, 1, 1)

	;100
	LItemSpellTomes100Conjuration.AddForm(_Frost_SpellTomeConjureShelterGreater, 1, 1)
	MGRitualConjurationBooks.AddForm(_Frost_SpellTomeConjureShelterGreater, 1, 1)
	LItemScroll100Skill.AddForm(_Frost_ScrollConjureShelterGreater, 1, 1)

	; Set the Weathersense meter color.
	_Frost_InterfaceHandler inf = FrostUtil.GetInterfaceHandler()
	inf.WeathersenseMeter.SetColors(inf._Frost_ExposureMeterColorWarm_Light.GetValueInt(), inf._Frost_ExposureMeterColorWarm_Light.GetValueInt())

	trace("[Frostfall] Upgraded to 3.0.2.")
	_Frost_Upgraded_3_0_2.SetValueInt(2)
endFunction

function Upgrade_3_1()
	_Frost_ArmorProtectionDatastoreHandler handler = GetClothingDatastoreHandler()
	handler.CreateProtectionKeywordValueMaps()

	; Get rid of the old data
	int cleared_count = 0
	if _Frost_PreviousVersion.GetValue() < 3.1
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorBody, "0")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorBody, "1")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorBody, "2")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorBody, "3")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorBody, "4")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorBody, "5")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorBody, "6")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorBody, "7")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorBody, "8")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorBody, "9")

		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorHead, "0")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorHead, "1")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorHead, "2")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorHead, "3")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorHead, "4")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorHead, "5")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorHead, "6")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorHead, "7")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorHead, "8")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorHead, "9")

		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorHands, "0")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorHands, "1")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorHands, "2")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorHands, "3")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorHands, "4")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorHands, "5")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorHands, "6")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorHands, "7")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorHands, "8")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorHands, "9")

		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorFeet, "0")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorFeet, "1")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorFeet, "2")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorFeet, "3")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorFeet, "4")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorFeet, "5")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorFeet, "6")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorFeet, "7")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorFeet, "8")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorFeet, "9")

		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorCloak, "0")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorCloak, "1")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorCloak, "2")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorCloak, "3")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorCloak, "4")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorCloak, "5")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorCloak, "6")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorCloak, "7")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorCloak, "8")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorCloak, "9")

		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorShield, "0")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorShield, "1")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorShield, "2")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorShield, "3")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorShield, "4")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorShield, "5")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorShield, "6")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorShield, "7")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorShield, "8")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorShield, "9")

		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorIgnore, "0")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorIgnore, "1")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorIgnore, "2")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorIgnore, "3")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorIgnore, "4")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorIgnore, "5")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorIgnore, "6")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorIgnore, "7")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorIgnore, "8")
		cleared_count += StorageUtil.ClearAllObjPrefix(handler._FrostData_ArmorIgnore, "9")
	endif

	; Create new default data
	PopulateDefaultArmorData()

	if _Frost_PreviousVersion.GetValue() > 0.0
		; Upgraded from previous version, start the new Frost Resist system.
		GetFrostResistSystem().StartSystem()
	endif

	trace("[Frostfall] Upgrade cleared " + cleared_count + " old records.")
	trace("[Frostfall] Upgraded to 3.1.")
	_Frost_Upgraded_3_1.SetValueInt(2)
endFunction

bool function CheckJSONReadWrite()
	; Attempt to open the file and write a value.
	string path = "../FrostfallData/readwrite_test"
	string test_key = "test_key"
	JsonUtil.IntListSet(path, test_key, 0, 0)
	JsonUtil.IntListSet(path, test_key, 1, 1)
	JsonUtil.IntListSet(path, test_key, 2, 100)
	JsonUtil.IntListSet(path, test_key, 3, 1000)
	JsonUtil.IntListSet(path, test_key, 4, 5555)
	JsonUtil.IntListSet(path, test_key, 5, -1)
	JsonUtil.IntListSet(path, test_key, 6, 123456)

	; Test saving the file.
	bool save_success = JsonUtil.Save(path)
	if !save_success
		return false
	endif

	; Test loading the file.
	bool load_success = JsonUtil.Load(path)
	if !load_success
		return false
	endif
	; Test reading back the values.
	int val0 = JsonUtil.IntListGet(path, test_key, 0)
	int val1 = JsonUtil.IntListGet(path, test_key, 1)
	int val2 = JsonUtil.IntListGet(path, test_key, 2)
	int val3 = JsonUtil.IntListGet(path, test_key, 3)
	int val4 = JsonUtil.IntListGet(path, test_key, 4)
	int val5 = JsonUtil.IntListGet(path, test_key, 5)
	int val6 = JsonUtil.IntListGet(path, test_key, 6)

	if val0 == 0 		&& \
	   val1 == 1 		&& \
	   val2 == 100 		&& \
	   val3 == 1000 	&& \
	   val4 == 5555 	&& \
	   val5 == -1   	&& \
	   val6 == 123456

	    ; Success - Clear the values for the next test.
		JsonUtil.IntListClear(path, test_key)
		return true
	else
		return false
	endif
endFunction

function PopulateDefaultArmorData()
	_Frost_ArmorProtectionDatastoreHandler handler = GetClothingDatastoreHandler()
	handler.CreateProtectionKeywordValueMaps()
	handler.SetDefaults_Body()
	handler.SetDefaults_Hands()
	handler.SetDefaults_Head()
	handler.SetDefaults_Feet()
	handler.SetDefaults_Cloak()
	handler.SetDefaults_Shield()
	handler.SaveDefaultArmorProfile()
endFunction

function RunCompatibilityArmors()
	IMALoadUp()
	NFHLoadUp()
	WICLoadUp()
	COSLoadUp()
	COSDGLoadUp()
	AEALoadUp()
	WACLoadUp()
	;HDTCloaksLoadUp()

	GetClothingDatastoreHandler().SaveDefaultArmorProfile()
endFunction


bool function IsPluginLoaded(int iFormID, string sPluginName)
	int i = Game.GetModByName(sPluginName)
	if i != 255
		debug.trace("[Frostfall] Loaded: " + sPluginName)
		return true
	else
		return false
	endif
endFunction

function DLC1LoadUp()

	if !DLC1_FVCanyon_PolyX
		DLC1_FVCanyon_PolyX = new float[5]
	endif
	if !DLC1_FVCanyon_PolyY
		DLC1_FVCanyon_PolyY = new float[5]
	endif
	if !DLC1_FVIce_PolyX
		DLC1_FVIce_PolyX = new float[8]
	endif
	if !DLC1_FVIce_PolyY
		DLC1_FVIce_PolyY = new float[8]
	endif
	if !DLC1_FVPlayground_PolyX
		DLC1_FVPlayground_PolyX = new float[6]
	endif
	if !DLC1_FVPlayground_PolyY
		DLC1_FVPlayground_PolyY = new float[6]
	endif
	if !DLC1_FVGrove_PolyX
		DLC1_FVGrove_PolyX = new float[5]
	endif
	if !DLC1_FVGrove_PolyY
		DLC1_FVGrove_PolyY = new float[5]
	endif
	if !DLC1_FVBoss_PolyX
		DLC1_FVBoss_PolyX = new float[5]
	endif
	if !DLC1_FVBoss_PolyY
		DLC1_FVBoss_PolyY = new float[5]
	endif

	;Set up polygon arrays that describe Falmer Valley weather regions (if necessary)
	if !DLC1_FVCanyon_PolyX[0]
		DLC1_FVCanyon_PolyX[0] = -47273
		DLC1_FVCanyon_PolyX[1] = -4083
		DLC1_FVCanyon_PolyX[2] = 16369
		DLC1_FVCanyon_PolyX[3] = -31458
		DLC1_FVCanyon_PolyX[4] = -55597
	endif
	if !DLC1_FVIce_PolyX[0]
		DLC1_FVIce_PolyX[0] = -22417
		DLC1_FVIce_PolyX[1] = 5287
		DLC1_FVIce_PolyX[2] = 17525
		DLC1_FVIce_PolyX[3] = 38431
		DLC1_FVIce_PolyX[4] = 47312
		DLC1_FVIce_PolyX[5] = 16369
		DLC1_FVIce_PolyX[6] = -4083
		DLC1_FVIce_PolyX[7] = -24967
	endif
	if !DLC1_FVPlayground_PolyX[0]
		DLC1_FVPlayground_PolyX[0] = -47273
		DLC1_FVPlayground_PolyX[1] = -42686
		DLC1_FVPlayground_PolyX[2] = 24409
		DLC1_FVPlayground_PolyX[3] = 5287
		DLC1_FVPlayground_PolyX[4] = -22417
		DLC1_FVPlayground_PolyX[5] = -24967
	endif
	if !DLC1_FVGrove_PolyX[0]
		DLC1_FVGrove_PolyX[0] = 24409
		DLC1_FVGrove_PolyX[1] = 46535
		DLC1_FVGrove_PolyX[2] = 58431
		DLC1_FVGrove_PolyX[3] = 17525
		DLC1_FVGrove_PolyX[4] = 5287
	endif
	if !DLC1_FVBoss_PolyX[0]
		DLC1_FVBoss_PolyX[0] = -7340
		DLC1_FVBoss_PolyX[1] = -7065
		DLC1_FVBoss_PolyX[2] = -12013
		DLC1_FVBoss_PolyX[3] = -14487
		DLC1_FVBoss_PolyX[4] = -11023
	endif
	if !DLC1_FVCanyon_PolyY[0]
		DLC1_FVCanyon_PolyY[0] = 15175
		DLC1_FVCanyon_PolyY[1] = -16276
		DLC1_FVCanyon_PolyY[2] = -43088
		DLC1_FVCanyon_PolyY[3] = -43787
		DLC1_FVCanyon_PolyY[4] = -18209
	endif
	if !DLC1_FVIce_PolyY[0]
		DLC1_FVIce_PolyY[0] = 15633
		DLC1_FVIce_PolyY[1] = 16908
		DLC1_FVIce_PolyY[2] = -2680
		DLC1_FVIce_PolyY[3] = 10491
		DLC1_FVIce_PolyY[4] = -10372
		DLC1_FVIce_PolyY[5] = -43088
		DLC1_FVIce_PolyY[6] = -16276
		DLC1_FVIce_PolyY[7] = -6122
	endif
	if !DLC1_FVPlayground_PolyY[0]
		DLC1_FVPlayground_PolyY[0] = 15175
		DLC1_FVPlayground_PolyY[1] = 40024
		DLC1_FVPlayground_PolyY[2] = 50095
		DLC1_FVPlayground_PolyY[3] = 16908
		DLC1_FVPlayground_PolyY[4] = 15633
		DLC1_FVPlayground_PolyY[5] = -6122
	endif
	if !DLC1_FVGrove_PolyY[0]
		DLC1_FVGrove_PolyY[0] = 50095
		DLC1_FVGrove_PolyY[1] = 17714
		DLC1_FVGrove_PolyY[2] = 10491
		DLC1_FVGrove_PolyY[3] = -2680
		DLC1_FVGrove_PolyY[4] = 16908
	endif
	if !DLC1_FVBoss_PolyY[0]
		DLC1_FVBoss_PolyY[0] = -7244
		DLC1_FVBoss_PolyY[1] = -9662
		DLC1_FVBoss_PolyY[2] = -14170
		DLC1_FVBoss_PolyY[3] = -10432
		DLC1_FVBoss_PolyY[4] = -7244
	endif
	
endFunction

function DRKLoadUp()
	form orb = Game.GetFormFromFile(0x000B8474, "Darkend.esp")
	if !_Camp_HeatSources_All.HasForm(orb)
		_Camp_HeatSources_All.AddForm(orb)
	endif
	if !_Camp_HeatSources_Other.HasForm(orb)
		_Camp_HeatSources_Other.AddForm(orb)
	endif
	if !WS_Darkend
		WS_Darkend = Game.GetFormFromFile(0x00000D62, "Darkend.esp") as Worldspace
	endif
	if !DNKD_Phalos_Frozen_PolyX
		DNKD_Phalos_Frozen_PolyX = new float[4]
	endif
	if !DNKD_Phalos_Frozen_PolyY
		DNKD_Phalos_Frozen_PolyY = new float[4]
	endif
	if !DNKD_Phalos_Frozen_PolyX[0]
		DNKD_Phalos_Frozen_PolyX[0] = 931.0
		DNKD_Phalos_Frozen_PolyX[1] = 19951.0
		DNKD_Phalos_Frozen_PolyX[2] = 28261.0
		DNKD_Phalos_Frozen_PolyX[3] = -4750.0
	endif
	if !DNKD_Phalos_Frozen_PolyY[0]
		DNKD_Phalos_Frozen_PolyY[0] = 14542.0
		DNKD_Phalos_Frozen_PolyY[1] = 6015.0
		DNKD_Phalos_Frozen_PolyY[2] = 49880.0
		DNKD_Phalos_Frozen_PolyY[3] = 49880.0
	endif
endFunction

function DLC2LoadUp()
	; Make a Fast Travel exception for the Black Books
	form Book1 = Game.GetFormFromFile(0x000270ED, "Dragonborn.esm")
	form Book2 = Game.GetFormFromFile(0x000270EE, "Dragonborn.esm")
	form Book3 = Game.GetFormFromFile(0x000270EF, "Dragonborn.esm")
	form Book4 = Game.GetFormFromFile(0x000270F0, "Dragonborn.esm")
	form Book5 = Game.GetFormFromFile(0x000270F1, "Dragonborn.esm")
	form Book6 = Game.GetFormFromFile(0x000270F2, "Dragonborn.esm")
	form Book7 = Game.GetFormFromFile(0x000270F3, "Dragonborn.esm")

	if !(_Frost_FastTravelExceptions.HasForm(Book1))
		_Frost_FastTravelExceptions.AddForm(Book1)
	endif
	if !(_Frost_FastTravelExceptions.HasForm(Book2))
		_Frost_FastTravelExceptions.AddForm(Book2)
	endif
	if !(_Frost_FastTravelExceptions.HasForm(Book3))
		_Frost_FastTravelExceptions.AddForm(Book3)
	endif
	if !(_Frost_FastTravelExceptions.HasForm(Book4))
		_Frost_FastTravelExceptions.AddForm(Book4)
	endif
	if !(_Frost_FastTravelExceptions.HasForm(Book5))
		_Frost_FastTravelExceptions.AddForm(Book5)
	endif
	if !(_Frost_FastTravelExceptions.HasForm(Book6))
		_Frost_FastTravelExceptions.AddForm(Book6)
	endif
	if !(_Frost_FastTravelExceptions.HasForm(Book7))
		_Frost_FastTravelExceptions.AddForm(Book7)
	endif

	; Make an exposure exception for the ship that takes you to Solstheim

endFunction

function WTHLoadUp()

	if !WS_Wyrmstooth
		WS_Wyrmstooth = Game.GetFormFromFile(0x01000D62, "Wyrmstooth.esp") as Worldspace
	endif
	
	if !(_Camp_WorldspacesInteriors.HasForm(Game.GetFormFromFile(0x010825E1, "Wyrmstooth.esp")))	;Dimfrost
		_Camp_WorldspacesInteriors.AddForm(Game.GetFormFromFile(0x010825E1, "Wyrmstooth.esp"))
	endif
	
	if !Wyrmstooth_Center_PolyX
		Wyrmstooth_Center_PolyX = new float[5]
	endif
	if !Wyrmstooth_Center_PolyY
		Wyrmstooth_Center_PolyY = new float[5]
	endif
	if !Wyrmstooth_West_PolyX
		Wyrmstooth_West_PolyX = new float[8]
	endif
	if !Wyrmstooth_West_PolyY
		Wyrmstooth_West_PolyY = new float[8]
	endif
	if !Wyrmstooth_Center_PolyX[0]
		Wyrmstooth_Center_PolyX[0] = 19045.16
		Wyrmstooth_Center_PolyX[1] = 13357.78
		Wyrmstooth_Center_PolyX[2] = 19684.59
		Wyrmstooth_Center_PolyX[3] = 41285.82
		Wyrmstooth_Center_PolyX[4] = 25999.50
	endif
	if !Wyrmstooth_Center_PolyY[0]
		Wyrmstooth_Center_PolyY[0] = 727.36
		Wyrmstooth_Center_PolyY[1] = -10888.55
		Wyrmstooth_Center_PolyY[2] = -18279.13
		Wyrmstooth_Center_PolyY[3] = 3264.52
		Wyrmstooth_Center_PolyY[4] = 8109.01
	endif
	if !Wyrmstooth_West_PolyX[0]
		Wyrmstooth_West_PolyX[0] = -184.0
		Wyrmstooth_West_PolyX[1] = -6402.0
		Wyrmstooth_West_PolyX[2] = -16690.0
		Wyrmstooth_West_PolyX[3] = -14528.0
		Wyrmstooth_West_PolyX[4] = -10068.0
		Wyrmstooth_West_PolyX[5] = -11671.0
		Wyrmstooth_West_PolyX[6] = -70148.0
		Wyrmstooth_West_PolyX[7] = -63280.0
	endif
	if !Wyrmstooth_West_PolyY[0]
		Wyrmstooth_West_PolyY[0] = 17652.0
		Wyrmstooth_West_PolyY[1] = -3939.0
		Wyrmstooth_West_PolyY[2] = -8281.0
		Wyrmstooth_West_PolyY[3] = -17718.0
		Wyrmstooth_West_PolyY[4] = -29543.0
		Wyrmstooth_West_PolyY[5] = -18706.0
		Wyrmstooth_West_PolyY[6] = -29523.0
		Wyrmstooth_West_PolyY[7] = 52329.0
	endif
endFunction

function VanillaGameLoadUp()
	if added_spell_books == false
		AddSpellBooks()
	endif
	
	; TreeReachTreeStump01 = Game.GetFormFromFile(0x000B8A75, "Skyrim.esm") as TreeObject
endFunction

function AddStartupSpells()
	if _Frost_HotkeyWeathersense.GetValueInt() != 0
		PlayerRef.RemoveSpell(_Frost_Weathersense_Spell)
	else
		PlayerRef.AddSpell(_Frost_Weathersense_Spell, false)
	endif

	GetFrostResistSystem().CheckFrostResist()
endFunction

function AddSpellBooks()
	if added_spell_books == false
		;0
		LItemSpellTomes00AllIllusion.AddForm(_Frost_SpellTomeSoothe1, 1, 1)
		LItemSpellTomes00AllSpells.AddForm(_Frost_SpellTomeSoothe1, 1, 1)
		LItemSpellTomes00Illusion.AddForm(_Frost_SpellTomeSoothe1, 1, 1)
		LItemSpellTomes00Spells.AddForm(_Frost_SpellTomeSoothe1, 1, 1)
		LItemScroll00Skill.AddForm(_Frost_ScrollSoothe, 1, 1)

		;25
		LItemSpellTomes25AllAlteration.AddForm(_Frost_SpellTomeFoxskin, 1, 1)
		LItemSpellTomes25Alteration.AddForm(_Frost_SpellTomeFoxskin, 1, 1)
		LItemSpellTomes25AllIllusion.AddForm(_Frost_SpellTomeSoothe2, 1, 1)
		LItemSpellTomes25Illusion.AddForm(_Frost_SpellTomeSoothe2, 1, 1)
		LItemSpellTomes25AllConjuration.AddForm(_Frost_SpellTomeBoundCloakLesser, 1, 1)
		LItemSpellTomes25Conjuration.AddForm(_Frost_SpellTomeBoundCloakLesser, 1, 1)
		LItemScroll25Skill.AddForm(_Frost_ScrollBask, 1, 1)
		LItemScroll25Skill.AddForm(_Frost_ScrollFoxskin, 1, 1)
		LItemScroll25Skill.AddForm(_Frost_ScrollBoundCloakLesser, 1, 1)

		;50
		LItemSpellTomes50AllAlteration.AddForm(_Frost_SpellTomeWolfskin, 1, 1)
		LItemSpellTomes50Alteration.AddForm(_Frost_SpellTomeWolfskin, 1, 1)
		LItemSpellTomes50Spells.AddForm(_Frost_SpellTomeWolfskin, 1, 1)
		LitemSpellTomes50AllDestruction.AddForm(_Frost_SpellTomeVaporBlast, 1, 1)
		LitemSpellTomes50Destruction.AddForm(_Frost_SpellTomeVaporBlast, 1, 1)
		LItemSpellTomes50Spells.AddForm(_Frost_SpellTomeVaporBlast, 1, 1)
		LItemSpellTomes50AllIllusion.AddForm(_Frost_SpellTomeSoothe3, 1, 1)
		LItemSpellTomes50Illusion.AddForm(_Frost_SpellTomeSoothe3, 1, 1)
		LItemSpellTomes50Spells.AddForm(_Frost_SpellTomeSoothe3, 1, 1)
		LItemSpellTOmes50AllRestoration.AddForm(_Frost_SpellTomeKindle, 1, 1)
		LItemSpellTOmes50Restoration.AddForm(_Frost_SpellTomeKindle, 1, 1)
		LItemSpellTomes50Spells.AddForm(_Frost_SpellTomeKindle, 1, 1)
		LItemSpellTomes50AllConjuration.AddForm(_Frost_SpellTomeBoundCloakGreater, 1, 1)
		LItemSpellTomes50Conjuration.AddForm(_Frost_SpellTomeBoundCloakGreater, 1, 1)
		LItemSpellTomes50Spells.AddForm(_Frost_SpellTomeBoundCloakGreater, 1, 1)
		LItemScroll50Skill.AddForm(_Frost_ScrollRevel, 1, 1)
		LItemScroll50Skill.AddForm(_Frost_ScrollWolfskin, 1, 1)
		LItemScroll50Skill.AddForm(_Frost_ScrollVaporBlast, 1, 1)
		LItemScroll50Skill.AddForm(_Frost_ScrollKindle, 1, 1)
		LItemScroll50Skill.AddForm(_Frost_ScrollBoundCloakGreater, 1, 1)

		;75
		; LItemSpellTomes75AllConjuration.AddForm(_Frost_SpellTomeConjureShelterLesser, 1, 1)
		; LItemSpellTomes75Conjuration.AddForm(_Frost_SpellTomeConjureShelterLesser, 1, 1)
		; LItemSpellTomes75Spells.AddForm(_Frost_SpellTomeConjureShelterLesser, 1, 1)
		LItemSpellTomes75AllAlteration.AddForm(_Frost_SpellTomeTransmuteWood, 1, 1)
		LItemSpellTomes75Alteration.AddForm(_Frost_SpellTomeTransmuteWood, 1, 1)
		LItemSpellTomes75Spells.AddForm(_Frost_SpellTomeTransmuteWood, 1, 1)
		LItemSpellTomes75AllAlteration.AddForm(_Frost_SpellTomeBearskin, 1, 1)
		LItemSpellTomes75Alteration.AddForm(_Frost_SpellTomeBearskin, 1, 1)
		LItemSpellTomes75Spells.AddForm(_Frost_SpellTomeBearskin, 1, 1)
		LItemScroll75Skill.AddForm(_Frost_ScrollBearskin, 1, 1)
		; LItemScroll75Skill.AddForm(_Frost_ScrollConjureShelterLesser, 1, 1)

		;100
		; LItemSpellTomes100Conjuration.AddForm(_Frost_SpellTomeConjureShelterGreater, 1, 1)
		; MGRitualConjurationBooks.AddForm(_Frost_SpellTomeConjureShelterGreater, 1, 1)
		; LItemScroll100Skill.AddForm(_Frost_ScrollConjureShelterGreater, 1, 1)

		added_spell_books = true
	endif
endFunction

function RegisterForKeysOnLoad()
	FrostConfig.RegisterForKeysOnLoad()
endFunction

function RegisterForControlsOnLoad()
	; pass
endFunction

function RegisterForEventsOnLoad()
	GetExposureSystem().RegisterForEvents()
	GetClothingSystem().RegisterForEvents()
	GetWetnessSystem().RegisterForEvents()
	GetClimateSystem().RegisterForEvents()
	GetWarmthSystem().RegisterForEvents()
	GetCoverageSystem().RegisterForEvents()
	GetRescueSystem().RegisterForEvents()
	GetInterfaceHandler().RegisterForEvents()
endFunction

function RegisterForMenusOnLoad()
	(PlayerAlias as _Frost_PlayerDialogueMonitor).RegisterForMenus()
	GetInterfaceHandler().RegisterForMenus()
endFunction

int function GetPlayerRegionTemp_FalmerValley(float afPosX, float afPosY)
	if IsPointInPolygon(DLC1_FVBoss_PolyX, DLC1_FVBoss_PolyY, afPosX, afPosY) && PlayerRef.GetPositionZ() >= 8385.0
		;notification("[Frostfall] Current Region: Boss")
		return 20
	elseif IsPointInPolygon(DLC1_FVIce_PolyX, DLC1_FVIce_PolyY, afPosX, afPosY)
		;notification("[Frostfall] Current Region: Ice")
		return -10
	elseif IsPointInPolygon(DLC1_FVCanyon_PolyX, DLC1_FVCanyon_PolyY, afPosX, afPosY)
		;notification("[Frostfall] Current Region: Canyon")
		return 12
	elseif IsPointInPolygon(DLC1_FVPlayground_PolyX, DLC1_FVPlayground_PolyY, afPosX, afPosY)
		;notification("[Frostfall] Current Region: Playground")
		return -5
	elseif IsPointInPolygon(DLC1_FVGrove_PolyX, DLC1_FVGrove_PolyY, afPosX, afPosY)
		;notification("[Frostfall] Current Region: Grove")
		return 1
	else
		;notification("[Frostfall] Current Region: Unknown!")
		return 10
	endif

endFunction

int function GetPlayerRegionTemp_Solstheim(float afPosX, float afPosY)
	if IsPointInPolygon(DLC2_Solstheim_PolyX, DLC2_Solstheim_PolyY, afPosX, afPosY)
		;notification("[Frostfall] Current Region: Ice")
		return -10
	else
		return 16
	endif
endFunction

int function GetPlayerRegionTemp_Wyrmstooth(float afPosX, float afPosY)
	if IsPointInPolygon(Wyrmstooth_Center_PolyX, Wyrmstooth_Center_PolyY, afPosX, afPosY)
		return 12
	elseif IsPointInPolygon(Wyrmstooth_West_PolyX, Wyrmstooth_West_PolyY, afPosX, afPosY)
		return 9
	else
		return -10
	endif
endFunction

int function GetPlayerRegionTemp_Darkend(float afPosX, float afPosY)
	if IsPointInPolygon(DNKD_Phalos_Frozen_PolyX, DNKD_Phalos_Frozen_PolyY, afPosX, afPosY)
		return -10
	else
		return 5
	endif
endFunction

bool function IsPointInPolygon(float[] polyX, float[] polyY, float x, float y)
    ; Attempts to determine if a given point (x, y) lies inside the bounds of a polygon described as a series
    ; of ordered pairs described in the polyX[] and polyY[] arrays.
    ; If (x, y) lies exactly on one of the line segments, this functiom may return True or False.
    ; From http://alienryderflex.com/polygon/, converted to Papyrus by Chesko
    
    ; Return Values
    ;     True  = Point is inside polygon
    ;     False = Point lies outside polygon OR polygon arrays are of different lengths

    ;float[] polyX = array that describes the polygon's x coordinates
    ;float[] polyY = array that describes the polygon's y coordinates
    ;float x           = the x coordinate under test
    ;float y           = the y coordinate under test
    
    ;Polygon arrays must be the same length
    if polyX.Length != polyY.Length
        return false
    endif
        
    int polySides = polyX.Length
    int i = 0
    int j = polySides - 1
    bool oddNodes = false

    while i < polySides
        if (((polyY[i] < y && polyY[j] >= y) || (polyY[j] < y && polyY[i] >= y)) && (polyX[i] <= x || polyX[j] <= x))
            if (polyX[i] + (y- polyY[i]) / (polyY[j] - polyY[i]) * (polyX[j] - polyX[i])) < x
                oddNodes = !oddNodes
            endif
        endif
        j = i
        i += 1
    endWhile
        
    return oddNodes
endFunction


; Equipment Compatibility

function NFHLoadUp()
	_Frost_ArmorProtectionDatastoreHandler handler = GetClothingDatastoreHandler()

	; Check if already loaded
	if ArmorProtectionDataExistsByKey("18655___Northborn Fur Hoods.esp")
		return
	endif

	handler.SetArmorDataByKey("18655___Northborn Fur Hoods.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; ArmorFurHoodNsLtWhite
	handler.SetArmorDataByKey("18654___Northborn Fur Hoods.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; ArmorFurHoodNsLtBlack
	handler.SetArmorDataByKey("18653___Northborn Fur Hoods.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; ArmorFurHoodNsLt
	handler.SetArmorDataByKey("18652___Northborn Fur Hoods.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; ArmorFurHoodNsHvWhite
	handler.SetArmorDataByKey("18651___Northborn Fur Hoods.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; ArmorFurHoodNsHvBlack
	handler.SetArmorDataByKey("18650___Northborn Fur Hoods.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; ArmorFurHoodNsHv
	handler.SetArmorDataByKey("18649___Northborn Fur Hoods.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; ArmorFurHoodNsBlack
	handler.SetArmorDataByKey("18648___Northborn Fur Hoods.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; ArmorFurHoodNs
	handler.SetArmorDataByKey("7567___Northborn Fur Hoods.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; ArmorFurHoodLtWhite
	handler.SetArmorDataByKey("8949___Northborn Fur Hoods.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; ArmorFurHoodHvBlack
	handler.SetArmorDataByKey("764315___Northborn Fur Hoods.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; ArmorFurHoodLt
	handler.SetArmorDataByKey("7566___Northborn Fur Hoods.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; ArmorFurHoodWhite
	handler.SetArmorDataByKey("764314___Northborn Fur Hoods.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; ArmorFurHood
	handler.SetArmorDataByKey("8957___Northborn Fur Hoods.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; ArmorFurHoodLtBlack
	handler.SetArmorDataByKey("8956___Northborn Fur Hoods.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; ArmorFurHoodBlack
	handler.SetArmorDataByKey("764316___Northborn Fur Hoods.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; ArmorFurHoodHv
	handler.SetArmorDataByKey("6185___Northborn Fur Hoods.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; ArmorFurHoodHvWhite
	handler.SetArmorDataByKey("18656___Northborn Fur Hoods.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; ArmorFurHoodNsWhite
endFunction

function COSLoadUp()
	AddCOSDatastoreEntries("Complete Crafting Overhaul_Remade.esp")
	AddCOSDatastoreEntries("Cloaks.esp")
	AddCOSDatastoreEntries("Cloaks - Player Only.esp")
	AddCOSDatastoreEntries("Cloaks - No Imperial.esp")
endFunction

function AddCOSDatastoreEntries(string asPluginName)
	_Frost_ArmorProtectionDatastoreHandler handler = GetClothingDatastoreHandler()

	; Check if already loaded
	if ArmorProtectionDataExistsByKey("58747___" + asPluginName)
		return
	endif

	;==========BURLAP CLOAKS===========
	handler.SetArmorDataByKey("58747___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakForswornAlt
	handler.SetArmorDataByKey("53213___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakBurned
	handler.SetArmorDataByKey("49074___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakAshlander1
	handler.SetArmorDataByKey("33856___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakHjarvoBlanket
	handler.SetArmorDataByKey("62998___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakDwemerCeremonial
	handler.SetArmorDataByKey("62977___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakAshlander2
	handler.SetArmorDataByKey("61588___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakNecroAlt
	handler.SetArmorDataByKey("28327___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakDwemer
	handler.SetArmorDataByKey("28329___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakDwemerAlt
	handler.SetArmorDataByKey("53221___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakWarmSands
	handler.SetArmorDataByKey("67140___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakDragonPriest
	handler.SetArmorDataByKey("58751___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakWildHunt
	handler.SetArmorDataByKey("61587___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakNecro
	handler.SetArmorDataByKey("75456___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakShortLover
	handler.SetArmorDataByKey("75455___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakShortRedEagle
	handler.SetArmorDataByKey("76856___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakShortBlackTalos
	handler.SetArmorDataByKey("76854___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakShortSilverhand
	handler.SetArmorDataByKey("76852___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakShortStormcloak
	handler.SetArmorDataByKey("76850___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakShortMossy
	handler.SetArmorDataByKey("74045___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakDPOtar
	handler.SetArmorDataByKey("74046___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakDPVokun
	handler.SetArmorDataByKey("74047___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakDPVolsung
	handler.SetArmorDataByKey("74048___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakDPRahgot
	handler.SetArmorDataByKey("74043___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakDPKrosis
	handler.SetArmorDataByKey("74044___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakDPMorokei
	handler.SetArmorDataByKey("68520___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakDPHevnoraak
	handler.SetArmorDataByKey("68522___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakDPNahkriin
	handler.SetArmorDataByKey("62979___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakBlackBurlap
	handler.SetArmorDataByKey("62980___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakBlueBurlap
	handler.SetArmorDataByKey("62981___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakBrownBurlap
	handler.SetArmorDataByKey("62982___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakCrimsonBurlap
	handler.SetArmorDataByKey("62983___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakGreenBurlap
	handler.SetArmorDataByKey("62984___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakGreyBurlap
	handler.SetArmorDataByKey("62985___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakWhiteBurlap
	handler.SetArmorDataByKey("74062___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakShortBlueBurlap
	handler.SetArmorDataByKey("74063___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakShortBlackBurlap
	handler.SetArmorDataByKey("74066___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakShortBrownBurlap
	handler.SetArmorDataByKey("74068___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakShortCrimsonBurlap
	handler.SetArmorDataByKey("74070___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakShortGreenBurlap
	handler.SetArmorDataByKey("74072___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakShortGreyBurlap
	handler.SetArmorDataByKey("74074___" + asPluginName, handler.GEARTYPE_CLOAK, 5, 5, abExportToDefaults = true, abSave = false) ; CloakShortWhiteBurlap
	
	;==========LINEN CLOAKS===========
	handler.SetArmorDataByKey("58748___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakImperialGold
	handler.SetArmorDataByKey("40785___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakKvatch
	handler.SetArmorDataByKey("46316___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakVaermina
	handler.SetArmorDataByKey("32476___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakFallWinterhold
	handler.SetArmorDataByKey("25551___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakThalmorAlt
	handler.SetArmorDataByKey("24169___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakThalmor
	handler.SetArmorDataByKey("25552___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakThalmorAltEnch
	handler.SetArmorDataByKey("58749___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakImperialSilver
	handler.SetArmorDataByKey("62995___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakDwemerPurple
	handler.SetArmorDataByKey("53223___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakSolitudeLinen
	handler.SetArmorDataByKey("42172___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakMarkarthLinen
	handler.SetArmorDataByKey("42170___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakFalkreathLinen
	handler.SetArmorDataByKey("38022___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakRiftenLinen
	handler.SetArmorDataByKey("22786___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakLinenBrownHealth02
	handler.SetArmorDataByKey("21380___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakWhiterunLinen
	handler.SetArmorDataByKey("21390___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakBrownLinen
	handler.SetArmorDataByKey("21391___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakCrimsonLinen
	handler.SetArmorDataByKey("21392___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakDawnstarLinen
	handler.SetArmorDataByKey("21393___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakGreenLinen
	handler.SetArmorDataByKey("21394___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakGreyLinen
	handler.SetArmorDataByKey("21395___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakHjaalmarchLinen
	handler.SetArmorDataByKey("21396___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakStormcloakLinen
	handler.SetArmorDataByKey("21397___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakWhiteLinen
	handler.SetArmorDataByKey("21379___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakBlackLinen
	handler.SetArmorDataByKey("22785___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakLinenBrownHealth01
	handler.SetArmorDataByKey("22784___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakLinenBlackResist02
	handler.SetArmorDataByKey("22783___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakLinenBlackResist01
	handler.SetArmorDataByKey("25557___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakBlueLinen
	handler.SetArmorDataByKey("25563___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakWinterholdLinen
	handler.SetArmorDataByKey("72658___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakShortBlack
	handler.SetArmorDataByKey("74064___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakShortBlue
	handler.SetArmorDataByKey("74065___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakShortBrown
	handler.SetArmorDataByKey("74067___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakShortCrimson
	handler.SetArmorDataByKey("74069___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakShortGreen
	handler.SetArmorDataByKey("74071___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakShortGrey
	handler.SetArmorDataByKey("74073___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakShortWhite
	handler.SetArmorDataByKey("83903___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakShortCollege
	handler.SetArmorDataByKey("1066944___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakShortDawnstar
	handler.SetArmorDataByKey("1066945___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakShortFalkreath
	handler.SetArmorDataByKey("1066946___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakShortHjaalmarch
	handler.SetArmorDataByKey("1066947___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakShortMarkarth
	handler.SetArmorDataByKey("1066948___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakShortRiften
	handler.SetArmorDataByKey("1066949___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakShortSolitude
	handler.SetArmorDataByKey("1066950___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakShortWhiterun
	handler.SetArmorDataByKey("1066951___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakShortWinterhold
		
	;==========HIDE CLOAKS===========
	handler.SetArmorDataByKey("50454___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakForsworn
	handler.SetArmorDataByKey("53219___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakNorthPaladin
	handler.SetArmorDataByKey("38016___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakHuntersFolly
	handler.SetArmorDataByKey("29714___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakCrow
	handler.SetArmorDataByKey("31094___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakNya
	handler.SetArmorDataByKey("31096___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakGreyFox
	handler.SetArmorDataByKey("24170___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakGreybeard
	handler.SetArmorDataByKey("4820___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakBrownHealth01
	handler.SetArmorDataByKey("4822___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakBlackResist01
	handler.SetArmorDataByKey("4823___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakBlackResist02
	handler.SetArmorDataByKey("4821___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakBrownHealth02
	handler.SetArmorDataByKey("62997___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakDwemerPurpleAlt
	handler.SetArmorDataByKey("42171___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakMarkarth
	handler.SetArmorDataByKey("42169___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakFalkreath
	handler.SetArmorDataByKey("38021___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakRiften
	handler.SetArmorDataByKey("25554___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakBlue
	handler.SetArmorDataByKey("18617___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakHjaalmarch
	handler.SetArmorDataByKey("18618___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakDawnstar
	handler.SetArmorDataByKey("3435___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakCrimson
	handler.SetArmorDataByKey("3432___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakGreen
	handler.SetArmorDataByKey("10340___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakStormcloak
	handler.SetArmorDataByKey("3431___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakBlack
	handler.SetArmorDataByKey("3430___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakBrown
	handler.SetArmorDataByKey("3433___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakGrey
	handler.SetArmorDataByKey("17235___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakWhite
	handler.SetArmorDataByKey("22787___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakWhiterun
	handler.SetArmorDataByKey("25562___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakWinterhold
	handler.SetArmorDataByKey("25564___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakSolitude
	handler.SetArmorDataByKey("57362___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakHimirHide
	
	;Cloaks of Skyrim 1.2
	handler.SetArmorDataByKey("94961___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakDaedric
	handler.SetArmorDataByKey("100481___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakComp
	handler.SetArmorDataByKey("89445___" + asPluginName, handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; CloakShortImperial
	handler.SetArmorDataByKey("94961___" + asPluginName, handler.GEARTYPE_CLOAK, 12, 40, abExportToDefaults = true, abSave = false) ; CloakScale
endFunction

function COSDGLoadUp()
	AddCOSDGDatastoreEntries("Complete Crafting Overhaul_Remade.esp")
	AddCOSDGDatastoreEntries("Cloaks - Dawnguard.esp")
	AddCOSDGDatastoreEntries("Cloaks - Player Only - Dawnguard.esp")
	AddCOSDGDatastoreEntries("Cloaks - No Imperial - Dawnguard.esp")
endFunction

function AddCOSDGDatastoreEntries(string asPluginName)
	_Frost_ArmorProtectionDatastoreHandler handler = GetClothingDatastoreHandler()

	if asPluginName == "Complete Crafting Overhaul_Remade.esp"
		; Check if already loaded
		if ArmorProtectionDataExistsByKey("22789___" + asPluginName)
			return
		endif

		handler.SetArmorDataByKey("22789___" + asPluginName, 10, 10, abExportToDefaults = true, abSave = false) ; CloakDawnguard
		handler.SetArmorDataByKey("22790___" + asPluginName, 10, 10, abExportToDefaults = true, abSave = false) ; CloakShortDawnguard
	else
		; Check if already loaded
		if ArmorProtectionDataExistsByKey("3428___" + asPluginName)
			return
		endif
		handler.SetArmorDataByKey("3428___" + asPluginName, 10, 10, abExportToDefaults = true, abSave = false) ; CloakDawnguard
		handler.SetArmorDataByKey("3429___" + asPluginName, 10, 10, abExportToDefaults = true, abSave = false) ; CloakShortDawnguard
	endif
endFunction

function HDTCloaksLoadUp()

endFunction

function WICLoadUp()
	AddWICDatastoreEntries("Complete Crafting Overhaul_Remade.esp")
	AddWICDatastoreEntries("1nivWICCloaks.esp")
	AddWICDatastoreEntries("1nivWICCloaksNoGuards.esp")
	AddWICDatastoreEntries("1nivWICCloaksCRAFT.esp")
endFunction

function AddWICDatastoreEntries(string asPluginName)
	_Frost_ArmorProtectionDatastoreHandler handler = GetClothingDatastoreHandler()

	; Check if already loaded
	if ArmorProtectionDataExistsByKey("7639___" + asPluginName) ; 1nivCloakBearClawComBrown
		return
	endif

	handler.SetArmorDataByKey("10445___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearComBrown
	handler.SetArmorDataByKey("14581___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearComCave
	handler.SetArmorDataByKey("14582___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearComSnow
	handler.SetArmorDataByKey("110288___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearComSteelBrown
	handler.SetArmorDataByKey("110289___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearComSteelCave
	handler.SetArmorDataByKey("110290___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearComSteelSnow
	handler.SetArmorDataByKey("76952___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearComStuddedBrown
	handler.SetArmorDataByKey("76953___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearComStuddedCave
	handler.SetArmorDataByKey("76954___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearComStuddedSnow
	handler.SetArmorDataByKey("14586___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearOrnateBrown
	handler.SetArmorDataByKey("14587___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearOrnateCave
	handler.SetArmorDataByKey("14588___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearOrnateSnow
	handler.SetArmorDataByKey("110291___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearOrnateSteelBrown
	handler.SetArmorDataByKey("110292___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearOrnateSteelCave
	handler.SetArmorDataByKey("110293___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearOrnateSteelSnow
	handler.SetArmorDataByKey("78336___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearOrnateStuddedBrown
	handler.SetArmorDataByKey("78337___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearOrnateStuddedCave
	handler.SetArmorDataByKey("78338___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearOrnateStuddedSnow
	handler.SetArmorDataByKey("14583___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearTrimBrown
	handler.SetArmorDataByKey("14584___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearTrimCave
	handler.SetArmorDataByKey("14585___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearTrimSnow
	handler.SetArmorDataByKey("110294___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearTrimSteelBrown
	handler.SetArmorDataByKey("110295___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearTrimSteelCave
	handler.SetArmorDataByKey("110296___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearTrimSteelSnow
	handler.SetArmorDataByKey("78339___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearTrimStuddedBrown
	handler.SetArmorDataByKey("78340___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearTrimStuddedCave
	handler.SetArmorDataByKey("78341___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodBearTrimStuddedSnow
	handler.SetArmorDataByKey("50540___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinComBlack
	handler.SetArmorDataByKey("111757___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinComSteelBlack
	handler.SetArmorDataByKey("111756___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinComSteelTimber
	handler.SetArmorDataByKey("111758___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinComSteelWhite
	handler.SetArmorDataByKey("81140___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinComStuddedBlack
	handler.SetArmorDataByKey("81141___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinComStuddedTimber
	handler.SetArmorDataByKey("81142___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinComStuddedWhite
	handler.SetArmorDataByKey("50539___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinComTimber
	handler.SetArmorDataByKey("50541___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinComWhite
	handler.SetArmorDataByKey("88117___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinRareBlack
	handler.SetArmorDataByKey("111754___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinRareSteelBlack
	handler.SetArmorDataByKey("111753___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinRareSteelTimber
	handler.SetArmorDataByKey("111755___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinRareSteelWhite
	handler.SetArmorDataByKey("88120___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinRareStuddedBlack
	handler.SetArmorDataByKey("88119___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinRareStuddedTimber
	handler.SetArmorDataByKey("88121___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinRareStuddedWhite
	handler.SetArmorDataByKey("89500___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinRareTimber
	handler.SetArmorDataByKey("88118___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinRareWhite
	handler.SetArmorDataByKey("50543___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimBBlack
	handler.SetArmorDataByKey("111760___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimBSteelBlack
	handler.SetArmorDataByKey("111759___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimBSteelTimber
	handler.SetArmorDataByKey("111761___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimBSteelWhite
	handler.SetArmorDataByKey("81143___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimBStuddedBlack
	handler.SetArmorDataByKey("81144___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimBStuddedTimber
	handler.SetArmorDataByKey("81145___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimBStuddedWhite
	handler.SetArmorDataByKey("50542___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimBTimber
	handler.SetArmorDataByKey("50544___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimBWhite
	handler.SetArmorDataByKey("90880___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimRareBlack
	handler.SetArmorDataByKey("113156___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimRareSteelBlack
	handler.SetArmorDataByKey("113155___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimRareSteelTimber
	handler.SetArmorDataByKey("113157___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimRareSteelWhite
	handler.SetArmorDataByKey("90882___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimRareStuddedBlack
	handler.SetArmorDataByKey("90883___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimRareStuddedTimber
	handler.SetArmorDataByKey("90884___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimRareStuddedWhite
	handler.SetArmorDataByKey("89501___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimRareTimber
	handler.SetArmorDataByKey("90881___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimRareWhite
	handler.SetArmorDataByKey("50546___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimWBlack
	handler.SetArmorDataByKey("111763___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimWSteelBlack
	handler.SetArmorDataByKey("111762___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimWSteelTimber
	handler.SetArmorDataByKey("111764___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimWSteelWhite
	handler.SetArmorDataByKey("81146___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimWStuddedBlack
	handler.SetArmorDataByKey("81147___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimWStuddedTimber
	handler.SetArmorDataByKey("81148___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimWStuddedWhite
	handler.SetArmorDataByKey("50545___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimWTimber
	handler.SetArmorDataByKey("50547___" + asPluginName, handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; 1nivHoodWolfSkinTrimWWhite

	handler.SetArmorDataByKey("7639___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawComBrown
	handler.SetArmorDataByKey("56156___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawComBrownEnchF
	handler.SetArmorDataByKey("56175___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawComBrownEnchM
	handler.SetArmorDataByKey("9020___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawComCave
	handler.SetArmorDataByKey("56158___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawComCaveEnchF
	handler.SetArmorDataByKey("56176___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawComCaveEnchM
	handler.SetArmorDataByKey("9021___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawComSnow
	handler.SetArmorDataByKey("56159___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawComSnowEnchF
	handler.SetArmorDataByKey("56177___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawComSnowEnchM
	handler.SetArmorDataByKey("9025___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawOrnateBrown
	handler.SetArmorDataByKey("56160___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawOrnateBrownEnchF
	handler.SetArmorDataByKey("56178___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawOrnateBrownEnchM
	handler.SetArmorDataByKey("9026___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawOrnateCave
	handler.SetArmorDataByKey("56161___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawOrnateCaveEnchF
	handler.SetArmorDataByKey("56179___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawOrnateCaveEnchM
	handler.SetArmorDataByKey("9027___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawOrnateSnow
	handler.SetArmorDataByKey("56162___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawOrnateSnowEnchF
	handler.SetArmorDataByKey("56180___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawOrnateSnowEnchM
	handler.SetArmorDataByKey("9022___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawTrimBrown
	handler.SetArmorDataByKey("56163___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawTrimBrownEnchF
	handler.SetArmorDataByKey("56181___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawTrimBrownEnchM
	handler.SetArmorDataByKey("9023___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawTrimCave
	handler.SetArmorDataByKey("56164___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawTrimCaveEnchF
	handler.SetArmorDataByKey("56182___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawTrimCaveEnchM
	handler.SetArmorDataByKey("9024___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawTrimSnow
	handler.SetArmorDataByKey("56165___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawTrimSnowEnchF
	handler.SetArmorDataByKey("56183___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakBearClawTrimSnowEnchM
	handler.SetArmorDataByKey("9029___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinComBlack
	handler.SetArmorDataByKey("56166___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinComBlackEnchF
	handler.SetArmorDataByKey("56184___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinComBlackEnchM
	handler.SetArmorDataByKey("9028___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinComTimber
	handler.SetArmorDataByKey("56167___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinComTimberEnchF
	handler.SetArmorDataByKey("56185___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinComTimberEnchM
	handler.SetArmorDataByKey("9030___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinComWhite
	handler.SetArmorDataByKey("56168___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinComWhiteEnchF
	handler.SetArmorDataByKey("56186___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinComWhiteEnchM
	handler.SetArmorDataByKey("70014___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinRareBlack
	handler.SetArmorDataByKey("70016___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinRareBlackEnchF
	handler.SetArmorDataByKey("70019___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinRareBlackEnchM
	handler.SetArmorDataByKey("70013___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinRareTimber
	handler.SetArmorDataByKey("70017___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinRareTimberEnchF
	handler.SetArmorDataByKey("70020___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinRareTimberEnchM
	handler.SetArmorDataByKey("70015___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinRareWhite
	handler.SetArmorDataByKey("70018___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinRareWhiteEnchF
	handler.SetArmorDataByKey("70021___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinRareWhiteEnchM
	handler.SetArmorDataByKey("9034___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinTrimBBlack
	handler.SetArmorDataByKey("56169___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinTrimBBlackEnchF
	handler.SetArmorDataByKey("56187___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinTrimBBlackEnchM
	handler.SetArmorDataByKey("9035___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinTrimBTimber
	handler.SetArmorDataByKey("56170___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinTrimBTimberEnchF
	handler.SetArmorDataByKey("56188___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinTrimBTimberEnchM
	handler.SetArmorDataByKey("9036___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinTrimBWhite
	handler.SetArmorDataByKey("56171___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinTrimBWhiteEnchF
	handler.SetArmorDataByKey("56189___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinTrimBWhiteEnchM
	handler.SetArmorDataByKey("9032___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinTrimWBlack
	handler.SetArmorDataByKey("56172___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinTrimWBlackEnchF
	handler.SetArmorDataByKey("56190___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinTrimWBlackEnchM
	handler.SetArmorDataByKey("9031___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinTrimWTimber
	handler.SetArmorDataByKey("56173___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinTrimWTimberEnchF
	handler.SetArmorDataByKey("56191___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinTrimWTimberEnchM
	handler.SetArmorDataByKey("9033___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinTrimWWhite
	handler.SetArmorDataByKey("56174___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinTrimWWhiteEnchF
	handler.SetArmorDataByKey("56192___" + asPluginName, handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; 1nivCloakWolfSkinTrimWWhiteEnchM
endFunction

function AEALoadUp()
	_Frost_ArmorProtectionDatastoreHandler handler = GetClothingDatastoreHandler()

	; Check if already loaded
	if ArmorProtectionDataExistsByKey("20056___AesirArmor.esp")
		return
	endif

	handler.SetArmorDataByKey("20056___AesirArmor.esp", handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; cloak fur
	handler.SetArmorDataByKey("130085___AesirArmor.esp", handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; cloak fur
	handler.SetArmorDataByKey("98064___AesirArmor.esp", handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; cloak fur
	handler.SetArmorDataByKey("130086___AesirArmor.esp", handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; cloak fur
	handler.SetArmorDataByKey("98065___AesirArmor.esp", handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; cloak fur
	handler.SetArmorDataByKey("130087___AesirArmor.esp", handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; cloak fur
	handler.SetArmorDataByKey("233387___AesirArmor.esp", handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; cloak fur
	handler.SetArmorDataByKey("233392___AesirArmor.esp", handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; cloak fur
	handler.SetArmorDataByKey("233388___AesirArmor.esp", handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; cloak fur
	handler.SetArmorDataByKey("233393___AesirArmor.esp", handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; cloak fur
	handler.SetArmorDataByKey("233389___AesirArmor.esp", handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; cloak fur
	handler.SetArmorDataByKey("233394___AesirArmor.esp", handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; cloak fur

	handler.SetArmorDataByKey("95268___AesirArmor.esp", handler.GEARTYPE_BODY, 175, 54, abExportToDefaults = true, abSave = false) ; body full
	handler.SetArmorDataByKey("125934___AesirArmor.esp", handler.GEARTYPE_BODY, 175, 54, abExportToDefaults = true, abSave = false) ; body full
	handler.SetArmorDataByKey("49193___AesirArmor.esp", handler.GEARTYPE_BODY, 175, 54, abExportToDefaults = true, abSave = false) ; body full

	handler.SetArmorDataByKey("247294___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("247295___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("247296___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("247297___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("10379___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("130178___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("18674___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("131557___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("18675___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("131559___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("18676___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("131558___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("211121___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("211122___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("211123___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("211124___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("211125___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("211126___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("211127___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("211128___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("211129___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("212522___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("211130___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("212523___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("211131___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("212524___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("211136___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("212525___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("211135___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("212526___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("211132___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("212527___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("211133___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("212528___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("211134___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full
	handler.SetArmorDataByKey("212529___AesirArmor.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; head full

	handler.SetArmorDataByKey("49195___AesirArmor.esp", handler.GEARTYPE_HANDS, 21, 14, abExportToDefaults = true, abSave = false) ; hands full
	handler.SetArmorDataByKey("31538___AesirArmor.esp", handler.GEARTYPE_HANDS, 21, 14, abExportToDefaults = true, abSave = false) ; hands full
	handler.SetArmorDataByKey("131561___AesirArmor.esp", handler.GEARTYPE_HANDS, 21, 14, abExportToDefaults = true, abSave = false) ; hands full

	handler.SetArmorDataByKey("31541___AesirArmor.esp", handler.GEARTYPE_FEET, 21, 14, abExportToDefaults = true, abSave = false) ; feet full
	handler.SetArmorDataByKey("131560___AesirArmor.esp", handler.GEARTYPE_FEET, 21, 14, abExportToDefaults = true, abSave = false) ; feet full
	handler.SetArmorDataByKey("49194___AesirArmor.esp", handler.GEARTYPE_FEET, 21, 14, abExportToDefaults = true, abSave = false) ; feet full
endFunction

function WACLoadUp()
	_WetIsUnderShelterFaction = Game.GetFormFromFile(0x07119C, "WetandCold.esp") as Faction

	_Frost_ArmorProtectionDatastoreHandler handler = GetClothingDatastoreHandler()

	; Check if already loaded
	if ArmorProtectionDataExistsByKey("860640___WetandCold.esp")
		return
	endif

	handler.SetArmorDataByKey("860640___WetandCold.esp", handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; _WetCloak1 linen
	handler.SetArmorDataByKey("860649___WetandCold.esp", handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; _WetCloak1_Black linen
	handler.SetArmorDataByKey("864795___WetandCold.esp", handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; _WetCloak1_Blue linen
	handler.SetArmorDataByKey("864791___WetandCold.esp", handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; _WetCloak1_Gray linen
	handler.SetArmorDataByKey("864794___WetandCold.esp", handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; _WetCloak1_Green linen
	handler.SetArmorDataByKey("864796___WetandCold.esp", handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; _WetCloak1_Purple linen
	handler.SetArmorDataByKey("864792___WetandCold.esp", handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; _WetCloak1_Red linen
	handler.SetArmorDataByKey("864793___WetandCold.esp", handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; _WetCloak1_Yellow linen
	handler.SetArmorDataByKey("415000___WetandCold.esp", handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; _WetCloakFur1 fur
	handler.SetArmorDataByKey("514265___WetandCold.esp", handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; _WetCloakFur1_Black fur
	handler.SetArmorDataByKey("416384___WetandCold.esp", handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; _WetCloakFur1_Brown fur
	handler.SetArmorDataByKey("416380___WetandCold.esp", handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; _WetCloakFur1_Gray fur
	handler.SetArmorDataByKey("831666___WetandCold.esp", handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; _WetCloakFur2 fur
	handler.SetArmorDataByKey("831673___WetandCold.esp", handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; _WetCloakFur2_Black fur
	handler.SetArmorDataByKey("831674___WetandCold.esp", handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; _WetCloakFur2_Brown fur
	handler.SetArmorDataByKey("831675___WetandCold.esp", handler.GEARTYPE_CLOAK, 40, 12, abExportToDefaults = true, abSave = false) ; _WetCloakFur2_Gray fur

	handler.SetArmorDataByKey("152448___WetandCold.esp", handler.GEARTYPE_HANDS, 5, 14, abExportToDefaults = true, abSave = false) ; _WetGloves1
	handler.SetArmorDataByKey("698278___WetandCold.esp", handler.GEARTYPE_HANDS, 5, 14, abExportToDefaults = true, abSave = false) ; _WetGloves1_Blue
	handler.SetArmorDataByKey("152450___WetandCold.esp", handler.GEARTYPE_HANDS, 5, 14, abExportToDefaults = true, abSave = false) ; _WetGloves1_Gray
	handler.SetArmorDataByKey("698279___WetandCold.esp", handler.GEARTYPE_HANDS, 5, 14, abExportToDefaults = true, abSave = false) ; _WetGloves1_Green
	handler.SetArmorDataByKey("152451___WetandCold.esp", handler.GEARTYPE_HANDS, 5, 14, abExportToDefaults = true, abSave = false) ; _WetGloves1_Yellow

	handler.SetArmorDataByKey("95879___WetandCold.esp", handler.GEARTYPE_HEAD, 35, 43, abExportToDefaults = true, abSave = false) ; _WetHood1
	handler.SetArmorDataByKey("334976___WetandCold.esp", handler.GEARTYPE_HEAD, 35, 43, abExportToDefaults = true, abSave = false) ; _WetHood1_Teal
	handler.SetArmorDataByKey("95880___WetandCold.esp", handler.GEARTYPE_HEAD, 35, 43, abExportToDefaults = true, abSave = false) ; _WetHood2
	handler.SetArmorDataByKey("104164___WetandCold.esp", handler.GEARTYPE_HEAD, 35, 43, abExportToDefaults = true, abSave = false) ; _WetHood2_Gray
	handler.SetArmorDataByKey("97267___WetandCold.esp", handler.GEARTYPE_HEAD, 35, 43, abExportToDefaults = true, abSave = false) ; _WetHood3
	handler.SetArmorDataByKey("104163___WetandCold.esp", handler.GEARTYPE_HEAD, 35, 43, abExportToDefaults = true, abSave = false) ; _WetHood3_Yellow
	handler.SetArmorDataByKey("450851___WetandCold.esp", handler.GEARTYPE_HEAD, 35, 43, abExportToDefaults = true, abSave = false) ; _WetHood4
	handler.SetArmorDataByKey("804073___WetandCold.esp", handler.GEARTYPE_HEAD, 35, 28, abExportToDefaults = true, abSave = false) ; _WetHood5
	handler.SetArmorDataByKey("804074___WetandCold.esp", handler.GEARTYPE_HEAD, 35, 28, abExportToDefaults = true, abSave = false) ; _WetHood5_Brown
	handler.SetArmorDataByKey("804075___WetandCold.esp", handler.GEARTYPE_HEAD, 35, 28, abExportToDefaults = true, abSave = false) ; _WetHood5_Gray
	handler.SetArmorDataByKey("804076___WetandCold.esp", handler.GEARTYPE_HEAD, 35, 28, abExportToDefaults = true, abSave = false) ; _WetHood5_Green
	handler.SetArmorDataByKey("804077___WetandCold.esp", handler.GEARTYPE_HEAD, 35, 28, abExportToDefaults = true, abSave = false) ; _WetHood5_Red
	handler.SetArmorDataByKey("146916___WetandCold.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; _WetHoodFur1
	handler.SetArmorDataByKey("146917___WetandCold.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; _WetHoodFur1_Black
	handler.SetArmorDataByKey("699670___WetandCold.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; _WetHoodFur1_Brown
	handler.SetArmorDataByKey("146918___WetandCold.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; _WetHoodFur1_Gray
	handler.SetArmorDataByKey("873070___WetandCold.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; _WetHoodFur2
	handler.SetArmorDataByKey("874470___WetandCold.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; _WetHoodFur2_Black
	handler.SetArmorDataByKey("874471___WetandCold.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; _WetHoodFur2_Brown
	handler.SetArmorDataByKey("874472___WetandCold.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; _WetHoodFur2_LightBrown
	handler.SetArmorDataByKey("874473___WetandCold.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; _WetHoodFur2_White
	handler.SetArmorDataByKey("874476___WetandCold.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; _WetHoodFur3
	handler.SetArmorDataByKey("874481___WetandCold.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; _WetHoodFur3_Black
	handler.SetArmorDataByKey("874482___WetandCold.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; _WetHoodFur3_White
	handler.SetArmorDataByKey("841332___WetandCold.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; _WetHoodFurLined1
	handler.SetArmorDataByKey("842717___WetandCold.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; _WetHoodFurLined1_Brown
	handler.SetArmorDataByKey("842718___WetandCold.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; _WetHoodFurLined1_Dark
endFunction

function IMALoadUp()
	_Frost_ArmorProtectionDatastoreHandler handler = GetClothingDatastoreHandler()

	; Check if already loaded
	if ArmorProtectionDataExistsByKey("20258___Hothtrooper44_ArmorCompilation.esp")
		return
	endif

	handler.SetArmorDataByKey("20258___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 54, abExportToDefaults = true, abSave = false) ; IAAkaviriSamuraiCuirass
	handler.SetArmorDataByKey("144010___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 140, 109, abExportToDefaults = true, abSave = false) ; IAAlduinCuirass
	handler.SetArmorDataByKey("46671___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 91, abExportToDefaults = true, abSave = false) ; IAApotheusCuirass
	handler.SetArmorDataByKey("23132___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 30, 0, abExportToDefaults = true, abSave = false) ; IABarbarianCuirass
	handler.SetArmorDataByKey("144116___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 54, abExportToDefaults = true, abSave = false) ; IABoiledChitinHCuirass
	handler.SetArmorDataByKey("544585___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 54, abExportToDefaults = true, abSave = false) ; IABoiledChitinLCuirass
	handler.SetArmorDataByKey("145634___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 91, abExportToDefaults = true, abSave = false) ; IABosmerCuirass
	handler.SetArmorDataByKey("145637___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 91, abExportToDefaults = true, abSave = false) ; IABosmerEngravedCuirass
	handler.SetArmorDataByKey("145646___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 91, abExportToDefaults = true, abSave = false) ; IABosmerHeavyCuirass
	handler.SetArmorDataByKey("145653___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 91, abExportToDefaults = true, abSave = false) ; IABosmerHuntHeavyCuirass
	handler.SetArmorDataByKey("145656___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 91, abExportToDefaults = true, abSave = false) ; IABosmerHuntLightCuirass
	handler.SetArmorDataByKey("143594___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 0, 0, abExportToDefaults = true, abSave = false) ; IAConanCuirass
	handler.SetArmorDataByKey("143608___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 91, abExportToDefaults = true, abSave = false) ; IACrimsonArcherCuirass
	handler.SetArmorDataByKey("145723___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 160, 91, abExportToDefaults = true, abSave = false) ; IADaedricLordCuirass
	handler.SetArmorDataByKey("139237___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 140, 109, abExportToDefaults = true, abSave = false) ; IADragonEbonBulkyCuirass
	handler.SetArmorDataByKey("139238___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 140, 109, abExportToDefaults = true, abSave = false) ; IADragonEbonSleekCuirass
	handler.SetArmorDataByKey("143558___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 140, 109, abExportToDefaults = true, abSave = false) ; IADragonKnightCuirassFox
	handler.SetArmorDataByKey("143557___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 140, 109, abExportToDefaults = true, abSave = false) ; IADragonKnightCuirassFull
	handler.SetArmorDataByKey("15925___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 190, 72, abExportToDefaults = true, abSave = false) ; IAEinherjarBrigandineDarkCuirass
	handler.SetArmorDataByKey("15926___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 190, 72, abExportToDefaults = true, abSave = false) ; IAEinherjarBrigandineLightCuirass
	handler.SetArmorDataByKey("32830___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 190, 72, abExportToDefaults = true, abSave = false) ; IAEinherjarPlateDarkCuirass
	handler.SetArmorDataByKey("4820___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 190, 72, abExportToDefaults = true, abSave = false) ; IAEinherjarPlateLightCuirass
	handler.SetArmorDataByKey("3428___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, abExportToDefaults = true, abSave = false) ; IAFalkreathCuirass
	handler.SetArmorDataByKey("144118___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 190, 91, abExportToDefaults = true, abSave = false) ; IAGlacialCrystalHCuirass
	handler.SetArmorDataByKey("544590___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 190, 91, abExportToDefaults = true, abSave = false) ; IAGlacialCrystalLCuirass
	handler.SetArmorDataByKey("3478___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, abExportToDefaults = true, abSave = false) ; IAHedgeKnightCuirass
	handler.SetArmorDataByKey("23065___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, abExportToDefaults = true, abSave = false) ; IAHeroicImperialCuirass
	handler.SetArmorDataByKey("43878___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 140, 35, abExportToDefaults = true, abSave = false) ; IAHeroicStormcloakCuirass
	handler.SetArmorDataByKey("14469___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 91, abExportToDefaults = true, abSave = false) ; IAHunterCuirass
	handler.SetArmorDataByKey("436741___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, abExportToDefaults = true, abSave = false) ; IAImperialKnightCuirass
	handler.SetArmorDataByKey("23050___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 110, 35, abExportToDefaults = true, abSave = false) ; IAMercenaryCuirass
	handler.SetArmorDataByKey("43874___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 10, aiExtraCloakCoverage = 10, abExportToDefaults = true, abSave = false) ; IAPaladinCuirass	@MULTI
	; handler.SetArmorDataByKey("23102___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, Y, Z, abExportToDefaults = true, abSave = false) ; IAPrimitiveNordHeavyCuirass
	; handler.SetArmorDataByKey("23106___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, Y, Z, abExportToDefaults = true, abSave = false) ; IAPrimitiveNordLightCuirass
	handler.SetArmorDataByKey("23151___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 110, 35, abExportToDefaults = true, abSave = false) ; IARangerCuirass
	handler.SetArmorDataByKey("3440___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 91, abExportToDefaults = true, abSave = false) ; IARedguardKnightHeavyCuirass
	handler.SetArmorDataByKey("3441___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 91, abExportToDefaults = true, abSave = false) ; IARedguardKnightLightCuirass
	handler.SetArmorDataByKey("144113___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 110, 35, abExportToDefaults = true, abSave = false) ; IARingmailCuirass
	handler.SetArmorDataByKey("139149___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 140, 109, abExportToDefaults = true, abSave = false) ; IARitualBoethiahCuirass
	handler.SetArmorDataByKey("43870___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 91, abExportToDefaults = true, abSave = false) ; IASeadogCuirass
	handler.SetArmorDataByKey("144117___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 140, 35, aiExtraCloakWarmth = 40, aiExtraCloakCoverage = 12, abExportToDefaults = true, abSave = false) ; IASnowBearCuirass	@MULTI
	handler.SetArmorDataByKey("53616___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, abExportToDefaults = true, abSave = false) ; IASpellbinderCrimsonCuirass
	handler.SetArmorDataByKey("53617___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, abExportToDefaults = true, abSave = false) ; IASpellbinderRunicCuirass
	handler.SetArmorDataByKey("436720___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 40, aiExtraCloakCoverage = 12, abExportToDefaults = true, abSave = false) ; IAStormlordCuirass	@MULTI
	handler.SetArmorDataByKey("143492___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 140, 35, aiExtraCloakWarmth = 40, aiExtraCloakCoverage = 12, abExportToDefaults = true, abSave = false) ; IATrollbaneHeavyCuirass	@MULTI
	handler.SetArmorDataByKey("143498___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 140, 35, aiExtraCloakWarmth = 40, aiExtraCloakCoverage = 12, abExportToDefaults = true, abSave = false) ; IATrollbaneLightCuirass	@MULTI
	handler.SetArmorDataByKey("3447___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 128, 106, aiExtraCloakWarmth = 20, aiExtraCloakCoverage = 20, abExportToDefaults = true, abSave = false) ; IAVagabondCrimsonCuirass
	handler.SetArmorDataByKey("3449___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 128, 106, aiExtraCloakWarmth = 20, aiExtraCloakCoverage = 20, abExportToDefaults = true, abSave = false) ; IAVagabondDuskCuirass
	handler.SetArmorDataByKey("3448___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 128, 106, aiExtraCloakWarmth = 20, aiExtraCloakCoverage = 20, abExportToDefaults = true, abSave = false) ; IAVagabondLeatherCuirass
	handler.SetArmorDataByKey("3460___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 128, 106, abExportToDefaults = true, abSave = false) ; IAVanguardPlateCuirass
	handler.SetArmorDataByKey("144124___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, abExportToDefaults = true, abSave = false) ; IAVvardenfellGlassCuirass
	handler.SetArmorDataByKey("50833___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 54, abExportToDefaults = true, abSave = false) ; IAWitchplateCuirass
	handler.SetArmorDataByKey("143995___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 110, 52, abExportToDefaults = true, abSave = false) ; IABrigandDwemerScrap
	handler.SetArmorDataByKey("143996___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 90, 35, abExportToDefaults = true, abSave = false) ; IABrigandHighwayChain
	handler.SetArmorDataByKey("143997___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 90, 35, abExportToDefaults = true, abSave = false) ; IABrigandIronHide
	handler.SetArmorDataByKey("20284___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 140, 109, abExportToDefaults = true, abSave = false) ; IADragonhideHeavyRobe
	handler.SetArmorDataByKey("144024___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 140, 109, abExportToDefaults = true, abSave = false) ; IADragonhideLRobe
	handler.SetArmorDataByKey("226058___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 140, 109, abExportToDefaults = true, abSave = false) ; IADragonhideURobe
	handler.SetArmorDataByKey("23079___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 140, 72, abExportToDefaults = true, abSave = false) ; IADwarvenMageHRobe
	handler.SetArmorDataByKey("144028___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 140, 72, abExportToDefaults = true, abSave = false) ; IADwarvenMageLRobe
	handler.SetArmorDataByKey("226053___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 140, 72, abExportToDefaults = true, abSave = false) ; IADwarvenMageURobe
	handler.SetArmorDataByKey("145736___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 140, 54, abExportToDefaults = true, abSave = false) ; IAEbonyMageHeavyRobe
	handler.SetArmorDataByKey("145740___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 140, 54, abExportToDefaults = true, abSave = false) ; IAEbonyMageLightRobe
	handler.SetArmorDataByKey("226045___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 140, 54, abExportToDefaults = true, abSave = false) ; IAEbonyMageUnarmoredRobe
	handler.SetArmorDataByKey("143533___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 40, 0, abExportToDefaults = true, abSave = false) ; IAShamanLRobe
	handler.SetArmorDataByKey("536248___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 40, 0, abExportToDefaults = true, abSave = false) ; IAShamanURobe
	handler.SetArmorDataByKey("143706___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalHeavyRobeBlackCloak	@MULTI
	handler.SetArmorDataByKey("143701___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalHeavyRobeBlackNoCloak	@MULTI
	handler.SetArmorDataByKey("143707___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalHeavyRobeBlueCloak	@MULTI
	handler.SetArmorDataByKey("143702___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalHeavyRobeBlueNoCloak	@MULTI
	handler.SetArmorDataByKey("143708___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalHeavyRobeGreenCloak	@MULTI
	handler.SetArmorDataByKey("143703___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalHeavyRobeGreenNoCloak	@MULTI
	handler.SetArmorDataByKey("143709___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalHeavyRobeRedCloak	@MULTI
	handler.SetArmorDataByKey("143704___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalHeavyRobeRedNoCloak	@MULTI
	handler.SetArmorDataByKey("143710___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalHeavyRobeWhiteCloak	@MULTI
	handler.SetArmorDataByKey("143705___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalHeavyRobeWhiteNoCloak	@MULTI
	handler.SetArmorDataByKey("143731___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalLightRobeBlackCloak	@MULTI
	handler.SetArmorDataByKey("143726___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalLightRobeBlackNoCloak	@MULTI
	handler.SetArmorDataByKey("143732___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalLightRobeBlueCloak	@MULTI
	handler.SetArmorDataByKey("143727___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalLightRobeBlueNoCloak	@MULTI
	handler.SetArmorDataByKey("143733___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalLightRobeGreenCloak	@MULTI
	handler.SetArmorDataByKey("143728___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalLightRobeGreenNoCloak	@MULTI
	handler.SetArmorDataByKey("143734___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalLightRobeRedCloak	@MULTI
	handler.SetArmorDataByKey("143729___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalLightRobeRedNoCloak	@MULTI
	handler.SetArmorDataByKey("143735___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalLightRobeWhiteCloak	@MULTI
	handler.SetArmorDataByKey("143730___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalLightRobeWhiteNoCloak	@MULTI
	handler.SetArmorDataByKey("143755___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalUnarmoredRobeBlack	@MULTI
	handler.SetArmorDataByKey("143756___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalUnarmoredRobeBlue	@MULTI
	handler.SetArmorDataByKey("143757___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalUnarmoredRobeGreen	@MULTI
	handler.SetArmorDataByKey("143758___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalUnarmoredRobeRed	@MULTI
	handler.SetArmorDataByKey("143759___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 125, 72, aiExtraCloakWarmth = 5, aiExtraCloakCoverage = 5, abExportToDefaults = true, abSave = false) ; IATribunalUnarmoredRobeWhite	@MULTI
	handler.SetArmorDataByKey("16070___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 75, 35, abExportToDefaults = true, abSave = false) ; IANordMailHeavyHauberk
	handler.SetArmorDataByKey("16068___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 75, 35, abExportToDefaults = true, abSave = false) ; IANordMailLightShirt
	handler.SetArmorDataByKey("3466___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 175, 54, abExportToDefaults = true, abSave = false) ; IAWarchiefHeavyBulwark
	handler.SetArmorDataByKey("3467___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_BODY, 175, 54, abExportToDefaults = true, abSave = false) ; IAWarchiefLightBulwark


	handler.SetArmorDataByKey("20259___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 14, abExportToDefaults = true, abSave = false) ; IAAkaviriSamuraiGauntlets
	handler.SetArmorDataByKey("144011___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 29, abExportToDefaults = true, abSave = false) ; IAAlduinGauntlets
	handler.SetArmorDataByKey("23133___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 7, 6, abExportToDefaults = true, abSave = false) ; IABarbarianGauntlets
	handler.SetArmorDataByKey("144096___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 6, abExportToDefaults = true, abSave = false) ; IABoiledChitinHGauntlets
	handler.SetArmorDataByKey("544586___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 6, abExportToDefaults = true, abSave = false) ; IABoiledChitinLGauntlets
	handler.SetArmorDataByKey("145647___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 5, 6, abExportToDefaults = true, abSave = false) ; IABosmerHeavyGauntlets
	handler.SetArmorDataByKey("145654___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 5, 6, abExportToDefaults = true, abSave = false) ; IABosmerHuntHeavyGauntlets
	handler.SetArmorDataByKey("145657___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 5, 6, abExportToDefaults = true, abSave = false) ; IABosmerHuntLightGauntlets
	handler.SetArmorDataByKey("145724___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 18, 21, abExportToDefaults = true, abSave = false) ; IADaedricLordGauntlets
	handler.SetArmorDataByKey("139239___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 29, abExportToDefaults = true, abSave = false) ; IADragonEbonBulkyGauntlets
	handler.SetArmorDataByKey("143560___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 29, abExportToDefaults = true, abSave = false) ; IADragonKnightGauntlets0
	handler.SetArmorDataByKey("143561___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 29, abExportToDefaults = true, abSave = false) ; IADragonKnightGauntlets1
	handler.SetArmorDataByKey("143562___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 29, abExportToDefaults = true, abSave = false) ; IADragonKnightGauntlets2
	handler.SetArmorDataByKey("23080___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 21, abExportToDefaults = true, abSave = false) ; IADwarvenMageHGauntlets
	handler.SetArmorDataByKey("144026___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 21, abExportToDefaults = true, abSave = false) ; IADwarvenMageLGauntlets
	handler.SetArmorDataByKey("226051___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 21, abExportToDefaults = true, abSave = false) ; IADwarvenMageUGauntlets
	handler.SetArmorDataByKey("15917___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 24, 21, abExportToDefaults = true, abSave = false) ; IAEinherjarBrigandineDarkGauntlets
	handler.SetArmorDataByKey("32832___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 24, 21, abExportToDefaults = true, abSave = false) ; IAEinherjarPlateDarkGauntlets
	handler.SetArmorDataByKey("4818___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 24, 21, abExportToDefaults = true, abSave = false) ; IAEinherjarPlateLightGauntlets
	handler.SetArmorDataByKey("3429___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 14, abExportToDefaults = true, abSave = false) ; IAFalkreathGauntlets
	handler.SetArmorDataByKey("144100___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 24, 14, abExportToDefaults = true, abSave = false) ; IAGlacialCrystalHGauntlets
	handler.SetArmorDataByKey("544591___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 24, 14, abExportToDefaults = true, abSave = false) ; IAGlacialCrystalLGauntlets
	handler.SetArmorDataByKey("3479___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 14, abExportToDefaults = true, abSave = false) ; IAHedgeKnightGauntlets
	handler.SetArmorDataByKey("43877___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 18, 14, abExportToDefaults = true, abSave = false) ; IAHeroicStormcloakGauntlets
	handler.SetArmorDataByKey("23051___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 6, abExportToDefaults = true, abSave = false) ; IAMercenaryGauntlets
	handler.SetArmorDataByKey("43873___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 14, abExportToDefaults = true, abSave = false) ; IAPaladinGauntlets
	;handler.SetArmorDataByKey("23103___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, Y, Z, abExportToDefaults = true, abSave = false) ; IAPrimitiveNordHeavyGauntlets
	;handler.SetArmorDataByKey("23107___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, Y, Z, abExportToDefaults = true, abSave = false) ; IAPrimitiveNordLightGauntlets
	handler.SetArmorDataByKey("3436___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 14, abExportToDefaults = true, abSave = false) ; IARedguardKnightHeavyGauntlets
	handler.SetArmorDataByKey("3437___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 14, abExportToDefaults = true, abSave = false) ; IARedguardKnightLightGauntlets
	handler.SetArmorDataByKey("6189___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 5, 6, abExportToDefaults = true, abSave = false) ; IASeadogGauntlets
	handler.SetArmorDataByKey("144120___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 18, 14, abExportToDefaults = true, abSave = false) ; IASnowBearGauntlets
	handler.SetArmorDataByKey("53615___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 14, abExportToDefaults = true, abSave = false) ; IASpellbinderCrimsonGauntlets
	handler.SetArmorDataByKey("53618___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 14, abExportToDefaults = true, abSave = false) ; IASpellbinderRunicGauntlets
	handler.SetArmorDataByKey("436721___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 14, abExportToDefaults = true, abSave = false) ; IAStormlordGauntlets
	handler.SetArmorDataByKey("143493___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 18, 14, abExportToDefaults = true, abSave = false) ; IATrollbaneHeavyGauntlets
	handler.SetArmorDataByKey("3453___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 35, abExportToDefaults = true, abSave = false) ; IAVagabondCrimsonGauntlets
	handler.SetArmorDataByKey("3455___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 35, abExportToDefaults = true, abSave = false) ; IAVagabondDuskGauntlets
	handler.SetArmorDataByKey("3461___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 21, abExportToDefaults = true, abSave = false) ; IAVanguardPlateGauntlets
	handler.SetArmorDataByKey("144125___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 14, abExportToDefaults = true, abSave = false) ; IAVvardenfellGlassGauntlets
	handler.SetArmorDataByKey("50835___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 6, abExportToDefaults = true, abSave = false) ; IAWitchplateGauntlets
	handler.SetArmorDataByKey("46670___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 10, 6, abExportToDefaults = true, abSave = false) ; IAApotheusGloves
	handler.SetArmorDataByKey("143609___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 5, 6, abExportToDefaults = true, abSave = false) ; IACrimsonArcherGloves
	handler.SetArmorDataByKey("139240___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 29, abExportToDefaults = true, abSave = false) ; IADragonEbonSleekGloves
	handler.SetArmorDataByKey("20281___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 29, abExportToDefaults = true, abSave = false) ; IADragonhideHeavyGloves
	handler.SetArmorDataByKey("144022___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 29, abExportToDefaults = true, abSave = false) ; IADragonhideLGloves
	handler.SetArmorDataByKey("226061___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 29, abExportToDefaults = true, abSave = false) ; IADragonhideUGloves
	handler.SetArmorDataByKey("145737___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 14, abExportToDefaults = true, abSave = false) ; IAEbonyMageHeavyGloves
	handler.SetArmorDataByKey("145741___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 14, abExportToDefaults = true, abSave = false) ; IAEbonyMageLightGloves
	handler.SetArmorDataByKey("226043___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 14, abExportToDefaults = true, abSave = false) ; IAEbonyMageUnarmoredGloves
	handler.SetArmorDataByKey("139150___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 29, abExportToDefaults = true, abSave = false) ; IARitualBoethiahGloves
	handler.SetArmorDataByKey("143536___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 6, abExportToDefaults = true, abSave = false) ; IAShamanLGloves
	handler.SetArmorDataByKey("536246___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 6, abExportToDefaults = true, abSave = false) ; IAShamanUGloves
	handler.SetArmorDataByKey("143691___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalHeavyGlovesBlack
	handler.SetArmorDataByKey("143692___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalHeavyGlovesBlue
	handler.SetArmorDataByKey("143693___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalHeavyGlovesGreen
	handler.SetArmorDataByKey("143694___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalHeavyGlovesRed
	handler.SetArmorDataByKey("143695___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalHeavyGlovesWhite
	handler.SetArmorDataByKey("143716___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalLightGlovesBlack
	handler.SetArmorDataByKey("143717___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalLightGlovesBlue
	handler.SetArmorDataByKey("143718___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalLightGlovesGreen
	handler.SetArmorDataByKey("143719___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalLightGlovesRed
	handler.SetArmorDataByKey("143720___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalLightGlovesWhite
	handler.SetArmorDataByKey("143745___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalUnarmoredGlovesBlack
	handler.SetArmorDataByKey("143746___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalUnarmoredGlovesBlue
	handler.SetArmorDataByKey("143747___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalUnarmoredGlovesGreen
	handler.SetArmorDataByKey("143748___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalUnarmoredGlovesRed
	handler.SetArmorDataByKey("143749___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalUnarmoredGlovesWhite
	handler.SetArmorDataByKey("145643___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 5, 6, abExportToDefaults = true, abSave = false) ; IABosmerBracers
	handler.SetArmorDataByKey("145638___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 5, 6, abExportToDefaults = true, abSave = false) ; IABosmerEngravedBracers
	handler.SetArmorDataByKey("143592___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 3, 0, abExportToDefaults = true, abSave = false) ; IAConanBracers
	handler.SetArmorDataByKey("15918___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 24, 21, abExportToDefaults = true, abSave = false) ; IAEinherjarBrigandineLightBracers
	handler.SetArmorDataByKey("23066___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 14, abExportToDefaults = true, abSave = false) ; IAHeroicImperialBracers
	handler.SetArmorDataByKey("14468___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 5, 6, abExportToDefaults = true, abSave = false) ; IAHunterBracers
	handler.SetArmorDataByKey("16065___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 7, 6, abExportToDefaults = true, abSave = false) ; IANordMailHeavyBracers
	handler.SetArmorDataByKey("16069___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 7, 6, abExportToDefaults = true, abSave = false) ; IANordMailLightBracers
	handler.SetArmorDataByKey("23152___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 6, abExportToDefaults = true, abSave = false) ; IARangerBracers
	handler.SetArmorDataByKey("144114___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 5, 6, abExportToDefaults = true, abSave = false) ; IARingmailBracers
	handler.SetArmorDataByKey("143499___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 18, 14, abExportToDefaults = true, abSave = false) ; IATrollbaneLightBracers
	handler.SetArmorDataByKey("3454___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 12, 35, abExportToDefaults = true, abSave = false) ; IAVagabondLeatherBracers
	handler.SetArmorDataByKey("436744___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 15, 14, abExportToDefaults = true, abSave = false) ; IAImperialKnightVambraces
	handler.SetArmorDataByKey("3470___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 21, 14, abExportToDefaults = true, abSave = false) ; IAWarchiefHeavyGrips
	handler.SetArmorDataByKey("3471___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HANDS, 21, 14, abExportToDefaults = true, abSave = false) ; IAWarchiefLightGrips


	handler.SetArmorDataByKey("20260___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 14, abExportToDefaults = true, abSave = false) ; IAAkaviriSamuraiHelmet
	handler.SetArmorDataByKey("144012___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IAAlduinHelmet
	handler.SetArmorDataByKey("46669___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 43, abExportToDefaults = true, abSave = false) ; IAApotheusHelm
	handler.SetArmorDataByKey("23134___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 15, 3, abExportToDefaults = true, abSave = false) ; IABarbarianHelmet
	handler.SetArmorDataByKey("144097___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 14, abExportToDefaults = true, abSave = false) ; IABoiledChitinHHelmet
	handler.SetArmorDataByKey("544587___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 14, abExportToDefaults = true, abSave = false) ; IABoiledChitinLHelmet
	handler.SetArmorDataByKey("145639___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 14, abExportToDefaults = true, abSave = false) ; IABosmerEngravedHelmet
	handler.SetArmorDataByKey("145648___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 14, abExportToDefaults = true, abSave = false) ; IABosmerHeavyHelmet
	handler.SetArmorDataByKey("145649___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 14, abExportToDefaults = true, abSave = false) ; IABosmerHelmet
	handler.SetArmorDataByKey("145652___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 43, abExportToDefaults = true, abSave = false) ; IABosmerHuntHeavyHelmet
	handler.SetArmorDataByKey("139247___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonHHelmClassic
	handler.SetArmorDataByKey("139248___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonHHelmClassicVeil
	handler.SetArmorDataByKey("139249___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonHHelmClaw
	handler.SetArmorDataByKey("139250___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonHHelmClawVeil
	handler.SetArmorDataByKey("139243___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonHHelmGrand
	handler.SetArmorDataByKey("139244___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonHHelmGrandVeil
	handler.SetArmorDataByKey("139245___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonHHelmHorn
	handler.SetArmorDataByKey("139246___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonHHelmHornVeil
	handler.SetArmorDataByKey("139241___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonHHelmStout
	handler.SetArmorDataByKey("139242___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonHHelmStoutVeil
	handler.SetArmorDataByKey("543154___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonLHelmClassic
	handler.SetArmorDataByKey("543155___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonLHelmClassicVeil
	handler.SetArmorDataByKey("543156___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonLHelmClaw
	handler.SetArmorDataByKey("543157___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonLHelmClawVeil
	handler.SetArmorDataByKey("543158___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonLHelmGrand
	handler.SetArmorDataByKey("543159___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonLHelmGrandVeil
	handler.SetArmorDataByKey("543160___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonLHelmHorn
	handler.SetArmorDataByKey("543161___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonLHelmHornVeil
	handler.SetArmorDataByKey("543162___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonLHelmStout
	handler.SetArmorDataByKey("543163___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonLHelmStoutVeil
	handler.SetArmorDataByKey("143563___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonKnightHHelm
	handler.SetArmorDataByKey("548818___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonKnightLHelm
	handler.SetArmorDataByKey("3430___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 14, abExportToDefaults = true, abSave = false) ; IAFalkreathHelmet
	handler.SetArmorDataByKey("144101___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 55, 29, abExportToDefaults = true, abSave = false) ; IAGlacialCrystalHHelmet
	handler.SetArmorDataByKey("544592___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 55, 29, abExportToDefaults = true, abSave = false) ; IAGlacialCrystalLHelmet
	handler.SetArmorDataByKey("3480___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 14, abExportToDefaults = true, abSave = false) ; IAHedgeKnightHelmet
	handler.SetArmorDataByKey("23067___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 43, abExportToDefaults = true, abSave = false) ; IAHeroicImperialHelmet
	handler.SetArmorDataByKey("43876___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; IAHeroicStormcloakHelmet
	handler.SetArmorDataByKey("436743___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 14, abExportToDefaults = true, abSave = false) ; IAImperialKnightHelmet
	handler.SetArmorDataByKey("16071___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 14, abExportToDefaults = true, abSave = false) ; IANordMailHeavyHelmet
	handler.SetArmorDataByKey("16072___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 14, abExportToDefaults = true, abSave = false) ; IANordMailHeavySpectacleHelmet
	handler.SetArmorDataByKey("16074___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 14, abExportToDefaults = true, abSave = false) ; IANordMailLightSpectacleHelmet
	handler.SetArmorDataByKey("16073___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 14, abExportToDefaults = true, abSave = false) ; IANordMailLightHelmet
	handler.SetArmorDataByKey("139134___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; IAOrcishMaskHelm
	handler.SetArmorDataByKey("15853___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 14, abExportToDefaults = true, abSave = false) ; IAPaladinGreatHelm
	handler.SetArmorDataByKey("43872___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 14, abExportToDefaults = true, abSave = false) ; IAPaladinHelmet
	;handler.SetArmorDataByKey("23104___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, Y, Z, abExportToDefaults = true, abSave = false) ; IAPrimitiveNordHeavyHelmet
	;handler.SetArmorDataByKey("23108___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, Y, Z, abExportToDefaults = true, abSave = false) ; IAPrimitiveNordLightHelmet
	handler.SetArmorDataByKey("139151___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IARitualBoethiahHelm
	handler.SetArmorDataByKey("143534___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 45, 3, abExportToDefaults = true, abSave = false) ; IAShamanLHelm
	handler.SetArmorDataByKey("536247___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 45, 3, abExportToDefaults = true, abSave = false) ; IAShamanUHelm
	handler.SetArmorDataByKey("144121___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; IASnowBearHelmet
	handler.SetArmorDataByKey("53613___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 14, abExportToDefaults = true, abSave = false) ; IASpellbinderCrimsonHelmet
	handler.SetArmorDataByKey("53620___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 14, abExportToDefaults = true, abSave = false) ; IASpellbinderRunicHelmet
	handler.SetArmorDataByKey("436723___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 14, abExportToDefaults = true, abSave = false) ; IAStormlordHelmet
	handler.SetArmorDataByKey("143496___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; IATrollbaneHeavyHelmet
	handler.SetArmorDataByKey("143501___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; IATrollbaneLightHelmet
	handler.SetArmorDataByKey("143494___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; IATrollbaneHeavyHeaddress
	handler.SetArmorDataByKey("143500___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; IATrollbaneLightHeaddress
	handler.SetArmorDataByKey("3472___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; IAWarchiefHeavyHeaddress
	handler.SetArmorDataByKey("3473___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; IAWarchiefLightHeaddress
	handler.SetArmorDataByKey("3456___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 72, abExportToDefaults = true, abSave = false) ; IAVagabondHelmet
	handler.SetArmorDataByKey("3462___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 29, abExportToDefaults = true, abSave = false) ; IAVanguardPlateHelmet
	handler.SetArmorDataByKey("3463___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 29, abExportToDefaults = true, abSave = false) ; IAVanguardPlateHelmetCLOSED
	handler.SetArmorDataByKey("144126___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 30, 29, abExportToDefaults = true, abSave = false) ; IAVvardenfellGlassHelmet
	handler.SetArmorDataByKey("17238___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 43, abExportToDefaults = true, abSave = false) ; IAApotheusHood
	handler.SetArmorDataByKey("18651___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; IAArmorHeavyFurHoodBlack
	handler.SetArmorDataByKey("8949___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 45, 14, aiExtraCloakWarmth = 20, aiExtraCloakCoverage = 6, abExportToDefaults = true, abSave = false) ; IAArmorHeavyFurHoodBlackScarf	@MULTI
	handler.SetArmorDataByKey("18650___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; IAArmorHeavyFurHoodPlain
	handler.SetArmorDataByKey("764316___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 45, 14, aiExtraCloakWarmth = 20, aiExtraCloakCoverage = 6, abExportToDefaults = true, abSave = false) ; IAArmorHeavyFurHoodPlainScarf	@MULTI
	handler.SetArmorDataByKey("18652___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; IAArmorHeavyFurHoodWhite
	handler.SetArmorDataByKey("6185___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 45, 14, aiExtraCloakWarmth = 20, aiExtraCloakCoverage = 6, abExportToDefaults = true, abSave = false) ; IAArmorHeavyFurHoodWhiteScarf	@MULTI
	handler.SetArmorDataByKey("18654___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; IAArmorLightFurHoodBlack
	handler.SetArmorDataByKey("8957___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 45, 14, aiExtraCloakWarmth = 20, aiExtraCloakCoverage = 6, abExportToDefaults = true, abSave = false) ; IAArmorLightFurHoodBlackScarf	@MULTI
	handler.SetArmorDataByKey("18653___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; IAArmorLightFurHoodPlain
	handler.SetArmorDataByKey("764315___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 45, 14, aiExtraCloakWarmth = 20, aiExtraCloakCoverage = 6, abExportToDefaults = true, abSave = false) ; IAArmorLightFurHoodPlainScarf	@MULTI
	handler.SetArmorDataByKey("18655___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; IAArmorLightFurHoodWhite
	handler.SetArmorDataByKey("7567___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 45, 14, aiExtraCloakWarmth = 20, aiExtraCloakCoverage = 6, abExportToDefaults = true, abSave = false) ; IAArmorLightFurHoodWhiteScarf	@MULTI
	handler.SetArmorDataByKey("145640___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 43, abExportToDefaults = true, abSave = false) ; IABosmerEngravedHood
	handler.SetArmorDataByKey("145650___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 43, abExportToDefaults = true, abSave = false) ; IABosmerHood
	handler.SetArmorDataByKey("145658___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 43, abExportToDefaults = true, abSave = false) ; IABosmerHuntLightHood
	handler.SetArmorDataByKey("139251___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonHHood
	handler.SetArmorDataByKey("543164___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonEbonLHood
	handler.SetArmorDataByKey("20283___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonhideHeavyHood
	handler.SetArmorDataByKey("144023___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonhideLHood
	handler.SetArmorDataByKey("226060___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 58, abExportToDefaults = true, abSave = false) ; IADragonhideUHood
	handler.SetArmorDataByKey("23081___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 29, abExportToDefaults = true, abSave = false) ; IADwarvenMageHHood
	handler.SetArmorDataByKey("144027___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 29, abExportToDefaults = true, abSave = false) ; IADwarvenMageLHood
	handler.SetArmorDataByKey("226052___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 29, abExportToDefaults = true, abSave = false) ; IADwarvenMageUHood
	handler.SetArmorDataByKey("145738___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 29, abExportToDefaults = true, abSave = false) ; IAEbonyMageHeavyHood
	handler.SetArmorDataByKey("145742___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 29, abExportToDefaults = true, abSave = false) ; IAEbonyMageLightHood
	handler.SetArmorDataByKey("226044___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 40, 29, abExportToDefaults = true, abSave = false) ; IAEbonyMageUnarmoredHood
	handler.SetArmorDataByKey("15921___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 55, 29, abExportToDefaults = true, abSave = false) ; IAEinherjarBrigandineDarkHood
	handler.SetArmorDataByKey("15922___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 55, 29, abExportToDefaults = true, abSave = false) ; IAEinherjarBrigandineLightHood
	handler.SetArmorDataByKey("32831___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 55, 29, abExportToDefaults = true, abSave = false) ; IAEinherjarPlateDarkHood
	handler.SetArmorDataByKey("4819___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 55, 29, abExportToDefaults = true, abSave = false) ; IAEinherjarPlateLightHood
	handler.SetArmorDataByKey("18649___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; IAFurHoodBlack
	handler.SetArmorDataByKey("8956___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; IAFurHoodBlackScarf
	handler.SetArmorDataByKey("18648___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; IAFurHoodPlain
	handler.SetArmorDataByKey("764314___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; IAFurHoodPlainScarf
	handler.SetArmorDataByKey("18656___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; IAFurHoodWhite
	handler.SetArmorDataByKey("7566___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 45, 14, abExportToDefaults = true, abSave = false) ; IAFurHoodWhiteScarf
	handler.SetArmorDataByKey("23153___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 30, 29, aiExtraCloakWarmth = 8, aiExtraCloakCoverage = 20, abExportToDefaults = true, abSave = false) ; IARangerHood	@MULTI
	handler.SetArmorDataByKey("144115___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 43, abExportToDefaults = true, abSave = false) ; IARingmailHood
	handler.SetArmorDataByKey("143696___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 30, 29, abExportToDefaults = true, abSave = false) ; IATribunalHeavyHoodBlack
	handler.SetArmorDataByKey("143697___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 30, 29, abExportToDefaults = true, abSave = false) ; IATribunalHeavyHoodBlue
	handler.SetArmorDataByKey("143698___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 30, 29, abExportToDefaults = true, abSave = false) ; IATribunalHeavyHoodGreen
	handler.SetArmorDataByKey("143699___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 30, 29, abExportToDefaults = true, abSave = false) ; IATribunalHeavyHoodRed
	handler.SetArmorDataByKey("143700___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 30, 29, abExportToDefaults = true, abSave = false) ; IATribunalHeavyHoodWhite
	handler.SetArmorDataByKey("143721___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 30, 29, abExportToDefaults = true, abSave = false) ; IATribunalLightHoodBlack
	handler.SetArmorDataByKey("143722___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 30, 29, abExportToDefaults = true, abSave = false) ; IATribunalLightHoodBlue
	handler.SetArmorDataByKey("143723___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 30, 29, abExportToDefaults = true, abSave = false) ; IATribunalLightHoodGreen
	handler.SetArmorDataByKey("143724___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 30, 29, abExportToDefaults = true, abSave = false) ; IATribunalLightHoodRed
	handler.SetArmorDataByKey("143725___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 30, 29, abExportToDefaults = true, abSave = false) ; IATribunalLightHoodWhite
	handler.SetArmorDataByKey("143750___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 30, 29, abExportToDefaults = true, abSave = false) ; IATribunalUnarmoredHoodBlack
	handler.SetArmorDataByKey("143751___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 30, 29, abExportToDefaults = true, abSave = false) ; IATribunalUnarmoredHoodBlue
	handler.SetArmorDataByKey("143752___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 30, 29, abExportToDefaults = true, abSave = false) ; IATribunalUnarmoredHoodGreen
	handler.SetArmorDataByKey("143753___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 30, 29, abExportToDefaults = true, abSave = false) ; IATribunalUnarmoredHoodRed
	handler.SetArmorDataByKey("143754___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 30, 29, abExportToDefaults = true, abSave = false) ; IATribunalUnarmoredHoodWhite
	handler.SetArmorDataByKey("50836___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 43, abExportToDefaults = true, abSave = false) ; IAWitchplateHood
	handler.SetArmorDataByKey("3427___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 0, 0, abExportToDefaults = true, abSave = false) ; IAFalkreathCrown
	handler.SetArmorDataByKey("3464___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; IAWarchiefHeavyBattlecrown
	handler.SetArmorDataByKey("3465___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 50, 14, abExportToDefaults = true, abSave = false) ; IAWarchiefLightBattlecrown
	handler.SetArmorDataByKey("143593___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, abIgnore = true, abExportToDefaults = true, abSave = false) ; IAConanCirclet 	@CHECK
	handler.SetArmorDataByKey("143464___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 50, 14, aiExtraCloakWarmth = 40, aiExtraCloakCoverage = 12, abExportToDefaults = true, abSave = false) ; IAMantleSilverHandHeavy	@MULTI
	handler.SetArmorDataByKey("143465___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 50, 14, aiExtraCloakWarmth = 40, aiExtraCloakCoverage = 12, abExportToDefaults = true, abSave = false) ; IAMantleSilverHandLight	@MULTI
	handler.SetArmorDataByKey("4807___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 43, abExportToDefaults = true, abSave = false) ; IASeadogTricorne
	handler.SetArmorDataByKey("7571___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 43, abExportToDefaults = true, abSave = false) ; IASeadogTricorneFeathered
	handler.SetArmorDataByKey("145633___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 43, abExportToDefaults = true, abSave = false) ; Bosmer Coif
	handler.SetArmorDataByKey("145645___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, 35, 43, abExportToDefaults = true, abSave = false) ; Bosmer Reinforced Coif


	handler.SetArmorDataByKey("20257___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IAAkaviriSamuraiBoots
	handler.SetArmorDataByKey("144009___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 29, abExportToDefaults = true, abSave = false) ; IAAlduinBoots
	handler.SetArmorDataByKey("46672___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 21, abExportToDefaults = true, abSave = false) ; IAApotheusBoots
	handler.SetArmorDataByKey("23131___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 7, 6, abExportToDefaults = true, abSave = false) ; IABarbarianBoots
	handler.SetArmorDataByKey("144095___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IABoiledChitinHBoots
	handler.SetArmorDataByKey("544584___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IABoiledChitinLBoots
	handler.SetArmorDataByKey("145632___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 21, abExportToDefaults = true, abSave = false) ; IABosmerBoots
	handler.SetArmorDataByKey("145635___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 21, abExportToDefaults = true, abSave = false) ; IABosmerEngravedBoots
	handler.SetArmorDataByKey("145644___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 21, abExportToDefaults = true, abSave = false) ; IABosmerHeavyBoots
	handler.SetArmorDataByKey("145651___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 21, abExportToDefaults = true, abSave = false) ; IABosmerHuntHeavyBoots
	handler.SetArmorDataByKey("145655___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 21, abExportToDefaults = true, abSave = false) ; IABosmerHuntLightBoots
	handler.SetArmorDataByKey("143591___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 6, abExportToDefaults = true, abSave = false) ; IAConanBoots
	handler.SetArmorDataByKey("143607___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 21, abExportToDefaults = true, abSave = false) ; IACrimsonArcherBoots
	handler.SetArmorDataByKey("145722___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 18, 21, abExportToDefaults = true, abSave = false) ; IADaedricLordBoots
	handler.SetArmorDataByKey("139235___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 29, abExportToDefaults = true, abSave = false) ; IADragonEbonBulkyBoots
	handler.SetArmorDataByKey("139236___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 29, abExportToDefaults = true, abSave = false) ; IADragonEbonSleekBoots
	handler.SetArmorDataByKey("20280___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 29, abExportToDefaults = true, abSave = false) ; IADragonhideHeavyBoots
	handler.SetArmorDataByKey("144021___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 29, abExportToDefaults = true, abSave = false) ; IADragonhideLBoots
	handler.SetArmorDataByKey("226062___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 29, abExportToDefaults = true, abSave = false) ; IADragonhideUBoots
	handler.SetArmorDataByKey("143556___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 29, abExportToDefaults = true, abSave = false) ; IADragonKnightHBoots
	handler.SetArmorDataByKey("548819___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 29, abExportToDefaults = true, abSave = false) ; IADragonKnightLBoots
	handler.SetArmorDataByKey("23078___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 21, abExportToDefaults = true, abSave = false) ; IADwarvenMageHBoots
	handler.SetArmorDataByKey("144025___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 21, abExportToDefaults = true, abSave = false) ; IADwarvenMageLBoots
	handler.SetArmorDataByKey("226050___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 21, abExportToDefaults = true, abSave = false) ; IADwarvenMageUBoots
	handler.SetArmorDataByKey("145735___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 14, abExportToDefaults = true, abSave = false) ; IAEbonyMageHeavyBoots
	handler.SetArmorDataByKey("145739___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 14, abExportToDefaults = true, abSave = false) ; IAEbonyMageLightBoots
	handler.SetArmorDataByKey("226042___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 14, abExportToDefaults = true, abSave = false) ; IAEbonyMageUnarmoredBoots
	handler.SetArmorDataByKey("15913___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 24, 21, abExportToDefaults = true, abSave = false) ; IAEinherjarBrigandineDarkBoots
	handler.SetArmorDataByKey("15914___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 24, 21, abExportToDefaults = true, abSave = false) ; IAEinherjarBrigandineLightBoots
	handler.SetArmorDataByKey("3432___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 24, 21, abExportToDefaults = true, abSave = false) ; IAEinherjarPlateDarkBoots
	handler.SetArmorDataByKey("4817___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 24, 21, abExportToDefaults = true, abSave = false) ; IAEinherjarPlateLightBoots
	handler.SetArmorDataByKey("3426___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 14, abExportToDefaults = true, abSave = false) ; IAFalkreathBoots
	handler.SetArmorDataByKey("144099___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 24, 14, abExportToDefaults = true, abSave = false) ; IAGlacialCrystalHBoots
	handler.SetArmorDataByKey("544589___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 24, 14, abExportToDefaults = true, abSave = false) ; IAGlacialCrystalLBoots
	handler.SetArmorDataByKey("3477___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 14, abExportToDefaults = true, abSave = false) ; IAHedgeKnightBoots
	handler.SetArmorDataByKey("23064___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IAHeroicImperialBoots
	handler.SetArmorDataByKey("43879___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 18, 14, abExportToDefaults = true, abSave = false) ; IAHeroicStormcloakBoots
	handler.SetArmorDataByKey("14466___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 21, abExportToDefaults = true, abSave = false) ; IAHunterBoots
	handler.SetArmorDataByKey("23049___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 6, abExportToDefaults = true, abSave = false) ; IAMercenaryBoots
	handler.SetArmorDataByKey("16064___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 7, 6, abExportToDefaults = true, abSave = false) ; IANordMailHeavyBoots
	handler.SetArmorDataByKey("16067___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 7, 6, abExportToDefaults = true, abSave = false) ; IANordMailLightBoots
	handler.SetArmorDataByKey("43875___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 14, abExportToDefaults = true, abSave = false) ; IAPaladinBoots
	;handler.SetArmorDataByKey("23101___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, Y, Z, abExportToDefaults = true, abSave = false) ; IAPrimitiveNordHeavyBoots
	;handler.SetArmorDataByKey("23105___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, Y, Z, abExportToDefaults = true, abSave = false) ; IAPrimitiveNordLightBoots
	handler.SetArmorDataByKey("23150___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 6, abExportToDefaults = true, abSave = false) ; IARangerBoots
	handler.SetArmorDataByKey("3434___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IARedguardKnightHeavyBoots
	handler.SetArmorDataByKey("3435___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IARedguardKnightLightBoots
	handler.SetArmorDataByKey("144112___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 21, abExportToDefaults = true, abSave = false) ; IARingmailBoots
	handler.SetArmorDataByKey("139148___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 29, abExportToDefaults = true, abSave = false) ; IARitualBoethiahBoots
	handler.SetArmorDataByKey("6188___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 21, abExportToDefaults = true, abSave = false) ; IASeadogBoots
	handler.SetArmorDataByKey("143535___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 6, abExportToDefaults = true, abSave = false) ; IAShamanLBoots
	handler.SetArmorDataByKey("536245___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 6, abExportToDefaults = true, abSave = false) ; IAShamanUBoots
	handler.SetArmorDataByKey("144119___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 18, 14, abExportToDefaults = true, abSave = false) ; IASnowBearBoots
	handler.SetArmorDataByKey("53614___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 14, abExportToDefaults = true, abSave = false) ; IASpellbinderCrimsonBoots
	handler.SetArmorDataByKey("53619___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 14, abExportToDefaults = true, abSave = false) ; IASpellbinderRunicBoots
	handler.SetArmorDataByKey("436722___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 14, abExportToDefaults = true, abSave = false) ; IAStormlordBoots
	handler.SetArmorDataByKey("143686___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalHeavyBootsBlack
	handler.SetArmorDataByKey("143687___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalHeavyBootsBlue
	handler.SetArmorDataByKey("143688___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalHeavyBootsGreen
	handler.SetArmorDataByKey("143689___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalHeavyBootsRed
	handler.SetArmorDataByKey("143690___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalHeavyBootsWhite
	handler.SetArmorDataByKey("143711___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalLightBootsBlack
	handler.SetArmorDataByKey("143712___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalLightBootsBlue
	handler.SetArmorDataByKey("143713___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalLightBootsGreen
	handler.SetArmorDataByKey("143714___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalLightBootsRed
	handler.SetArmorDataByKey("143715___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalLightBootsWhite
	handler.SetArmorDataByKey("143740___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalUnarmoredBootsBlack
	handler.SetArmorDataByKey("143741___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalUnarmoredBootsBlue
	handler.SetArmorDataByKey("143742___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalUnarmoredBootsGreen
	handler.SetArmorDataByKey("143743___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalUnarmoredBootsRed
	handler.SetArmorDataByKey("143744___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IATribunalUnarmoredBootsWhite
	handler.SetArmorDataByKey("143491___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 18, 14, abExportToDefaults = true, abSave = false) ; IATrollbaneHeavyBoots
	handler.SetArmorDataByKey("143497___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 18, 14, abExportToDefaults = true, abSave = false) ; IATrollbaneLightBoots
	handler.SetArmorDataByKey("3450___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 35, abExportToDefaults = true, abSave = false) ; IAVagabondCrimsonBoots
	handler.SetArmorDataByKey("3452___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 35, abExportToDefaults = true, abSave = false) ; IAVagabondDuskBoots
	handler.SetArmorDataByKey("3451___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 35, abExportToDefaults = true, abSave = false) ; IAVagabondLeatherBoots
	handler.SetArmorDataByKey("3459___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 21, abExportToDefaults = true, abSave = false) ; IAVanguardPlateBoots
	handler.SetArmorDataByKey("144123___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IAVvardenfellGlassBoots
	handler.SetArmorDataByKey("50834___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 12, 14, abExportToDefaults = true, abSave = false) ; IAWitchplateBoots
	handler.SetArmorDataByKey("436742___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 15, 14, abExportToDefaults = true, abSave = false) ; IAImperialKnightGreaves
	handler.SetArmorDataByKey("3474___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 21, 14, abExportToDefaults = true, abSave = false) ; IAWarchiefHeavyStompers
	handler.SetArmorDataByKey("3475___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_FEET, 21, 14, abExportToDefaults = true, abSave = false) ; IAWarchiefLightStompers


	handler.SetArmorDataByKey("145642___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; IABosmerFullCape
	handler.SetArmorDataByKey("145660___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_CLOAK, 8, 8, abExportToDefaults = true, abSave = false) ; IABosmerShoulderCape
	handler.SetArmorDataByKey("145641___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_CLOAK, 8, 8, abExportToDefaults = true, abSave = false) ; IABosmerEngravedShoulderCape
	handler.SetArmorDataByKey("436740___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; IAImperialKnightCape
	handler.SetArmorDataByKey("63308___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; IARedguardKnightCape
	handler.SetArmorDataByKey("11733___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; IASeadogCape
	handler.SetArmorDataByKey("13097___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_CLOAK, 10, 10, abExportToDefaults = true, abSave = false) ; IAApotheusScarf


	handler.SetArmorDataByKey("143495___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, abIgnore = true, abExportToDefaults = true, abSave = false) ; IATrollbaneHeavyMask		@IGNORE
	handler.SetArmorDataByKey("143502___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, abIgnore = true, abExportToDefaults = true, abSave = false) ; IATrollbaneLightMask 		@IGNORE
	handler.SetArmorDataByKey("143736___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, abIgnore = true, abExportToDefaults = true, abSave = false) ; IATribunalMaskBronze		@IGNORE
	handler.SetArmorDataByKey("143737___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, abIgnore = true, abExportToDefaults = true, abSave = false) ; IATribunalMaskEbony			@IGNORE
	handler.SetArmorDataByKey("143738___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, abIgnore = true, abExportToDefaults = true, abSave = false) ; IATribunalMaskGold			@IGNORE
	handler.SetArmorDataByKey("143739___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, abIgnore = true, abExportToDefaults = true, abSave = false) ; IATribunalMaskSilver		@IGNORE
	handler.SetArmorDataByKey("139152___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, abIgnore = true, abExportToDefaults = true, abSave = false) ; IARitualBoethiahMask		@IGNORE
	handler.SetArmorDataByKey("10329___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_MISC, abIgnore = true, abExportToDefaults = true, abSave = false) ; IASeadogEarings 				@IGNORE
	handler.SetArmorDataByKey("10335___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_MISC, abIgnore = true, abExportToDefaults = true, abSave = false) ; IASeadogEyepatch				@IGNORE
	handler.SetArmorDataByKey("145659___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, abIgnore = true, abExportToDefaults = true, abSave = false) ; IABosmerMask 				@IGNORE
	handler.SetArmorDataByKey("139153___Hothtrooper44_ArmorCompilation.esp", handler.GEARTYPE_HEAD, abIgnore = true, abExportToDefaults = true, abSave = false) ; IARitualBoethiahShroud		@IGNORE
endFunction

function SendEvent_FrostfallLoaded()
	int handle = ModEvent.Create("Frostfall_Loaded")
	if handle
		ModEvent.Send(handle)
	endif
endFunction

function RegisterCampfireSkill()
	GlobalVariable CampfireAPIVersion = Game.GetFormFromFile(0x03F1BE, "Campfire.esm") as GlobalVariable
	if CampfireAPIVersion && CampfireAPIVersion.GetValueInt() >= 4
		bool b = CampUtil.RegisterPerkTree(_Frost_PerkNodeController_Endurance, "Frostfall.esp")
	else
		debug.trace("[Campfire] ERROR: Unable to register Campfire Skill System for Frostfall.esp. Campfire was not found or the version loaded is not compatible. Expected CampUtil API 4 or higher, got " + CampfireAPIVersion.GetValueInt())
	endif
endFunction
