Scriptname _Frost_Main extends Quest
{This script handles starting the mod for the first time, setting appropriate start-up aliases, and running compatibility on startup.}

import CampUtil
import FrostUtil
import _FrostInternal

Actor property PlayerRef auto
ReferenceAlias property PlayerAlias auto
GlobalVariable property _Frost_DatastoreInitialized auto
GlobalVariable property _Frost_CheckInitialEquipment auto
GlobalVariable property GameHour auto
GlobalVariable property FrostfallRunning auto
Armor property _Frost_DummyCuirass auto
Armor property _Frost_DummyHelmet auto
Armor property _Frost_DummyGauntlets auto
Armor property _Frost_DummyBoots auto
Armor property _Frost_DummyShield auto
Message property _Frost_StartingUp auto
Message property _Frost_FirstStartup_1 auto
Message property _Frost_FirstStartup_2 auto
Message property _Frost_FirstStartup_3 auto
Message property _Frost_StartStarsMsg auto
Book property _Frost_SurvivorsGuide auto
Quest property _Frost_TrackingQuest auto

int stars_counter = 0
bool started_via_stars = false

Event OnInit()
	if _Frost_TrackingQuest.GetStage() == 0			;Kicks things off for the player
		_Frost_TrackingQuest.SetStage(10)
	endif
	RegisterForSingleUpdate(5)
EndEvent

Event OnUpdate()
	if _Frost_TrackingQuest.GetStage() == 10 && !started_via_stars
		if !IsRefInInterior(PlayerRef) && 		\
			PlayerRef.GetAngleX() <= -55.0 && 	\
			(GameHour.GetValue() > 19.0 || GameHour.GetValue() < 7.0)
			stars_counter += 1
			if stars_counter >= 2
				StartPrompt()
			endif
		endif
		RegisterForSingleUpdate(5)
	endif
EndEvent

function StartPrompt()
	int i = _Frost_StartStarsMsg.Show()
	if i == 0
		started_via_stars = true
		FrostfallRunning.SetValueInt(2)
		StartFrostfall()
	else
		stars_counter = 0
	endif
endFunction

function RegisterForModEvents()
	RegisterForModEvent("Frost_StartFrostfall", "StartFrostfall")
	RegisterForModEvent("Frost_StopFrostfall", "StopFrostfall")
endFunction

Event StartFrostfall()
	_Frost_StartingUp.Show()
	FrostDebug(1, "Starting Frostfall...")
	GetClothingDatastoreHandler().InitializeDatastore()

	; Prompt player to exit menu now.
	SendEvent_StartupAlmostDone()

	; Menu-Mode blocked functions
	if !self.IsRunning()
		self.Start()
	endif
	PlayerAlias.ForceRefTo(PlayerRef)
	StartModFirstTime()
	_Frost_TrackingQuest.SetStage(20)
	Utility.Wait(2.0)
	StartAllSystems()
	FrostUtil.GetCompatibilitySystem().RunCompatibility()
	CheckInitialEquipment()
endEvent

Event StopFrostfall()
	if self.IsRunning()
		self.Stop()
	endif
	PlayerAlias.Clear()
	StopAllSystems()
	GetInterfaceHandler().RemoveAllMeters()
endEvent

function StartAllSystems()
	GetClimateSystem().StartSystem()
	GetHeatSourceSystem().StartSystem()
	GetClothingSystem().StartSystem()
	GetRescueSystem().StartSystem()
	GetShelterSystem().StartSystem()
	GetWarmthSystem().StartSystem()
	GetCoverageSystem().StartSystem()
	GetExposureSystem().StartSystem()
	GetWetnessSystem().StartSystem()
endFunction

function StopAllSystems()
	GetClothingDatastoreHandler().StopSystem()
	GetClimateSystem().StopSystem()
	GetHeatSourceSystem().StopSystem()
	GetClothingSystem().StopSystem()
	GetRescueSystem().StopSystem()
	GetShelterSystem().StopSystem()
	GetWarmthSystem().StopSystem()
	GetCoverageSystem().StopSystem()
	GetExposureSystem().StopSystem()
	GetWetnessSystem().StopSystem()
endFunction

function CheckInitialEquipment()
	_Frost_CheckInitialEquipment.SetValue(2)
	PlayerRef.AddItem(_Frost_DummyCuirass, 1, true)
	PlayerRef.AddItem(_Frost_DummyHelmet, 1, true)
	PlayerRef.AddItem(_Frost_DummyGauntlets, 1, true)
	PlayerRef.AddItem(_Frost_DummyBoots, 1, true)
	PlayerRef.AddItem(_Frost_DummyShield, 1, true)
	PlayerRef.EquipItem(_Frost_DummyCuirass, abSilent = true)
	PlayerRef.EquipItem(_Frost_DummyHelmet, abSilent = true)
	PlayerRef.EquipItem(_Frost_DummyGauntlets, abSilent = true)
	PlayerRef.EquipItem(_Frost_DummyBoots, abSilent = true)
	PlayerRef.EquipItem(_Frost_DummyShield, abSilent = true)
	Utility.Wait(1.0)
	_Frost_CheckInitialEquipment.SetValue(1)
	PlayerRef.RemoveItem(_Frost_DummyCuirass, 1, true)
	PlayerRef.RemoveItem(_Frost_DummyHelmet, 1, true)
	PlayerRef.RemoveItem(_Frost_DummyGauntlets, 1, true)
	PlayerRef.RemoveItem(_Frost_DummyBoots, 1, true)
	PlayerRef.RemoveItem(_Frost_DummyShield, 1, true)
	Utility.Wait(1.0)
	_Frost_ClothingSystem Clothing = GetClothingSystem()
	if Clothing.initial_body
		PlayerRef.EquipItem(Clothing.initial_body, abSilent = true)
	endif
	if Clothing.initial_head
		PlayerRef.EquipItem(Clothing.initial_head, abSilent = true)
	endif
	if Clothing.initial_hands
		PlayerRef.EquipItem(Clothing.initial_hands, abSilent = true)
	endif
	if Clothing.initial_feet
		PlayerRef.EquipItem(Clothing.initial_feet, abSilent = true)
	endif
	if Clothing.initial_shield
		PlayerRef.EquipItem(Clothing.initial_shield, abSilent = true)
	endif
endFunction

function StartModFirstTime()
	if _Frost_TrackingQuest.GetStage() == 20
		return
	else
		;New game / first time user, show startup routine.
		_Frost_FirstStartup_1.Show()
		utility.wait(1)
		PlayerRef.AddItem(_Frost_SurvivorsGuide)
		utility.wait(6)
		_Frost_FirstStartup_2.Show()
		utility.wait(1)
		_Frost_FirstStartup_3.Show()
	endif
endFunction

function SendEvent_StartupAlmostDone()
    int handle = ModEvent.Create("Frost_StartupAlmostDone")
    if handle
        ModEvent.Send(handle)
    endif
endFunction