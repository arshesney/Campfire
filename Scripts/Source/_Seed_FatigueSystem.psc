scriptname _Seed_FatigueSystem extends Quest

;@TODO: Catch shock spell damage, which reduces magicka
;@TODO: Look for other sources of magicka damage

import Utility

GlobalVariable property _Seed_VitalitySystemEnabled auto
GlobalVariable property _Seed_AttributeFatigue auto
GlobalVariable property _Seed_FatigueRate auto 							; Default - 1.66
GlobalVariable property _Seed_FatigueActionRateMasterSpells auto 		; Default - 10.0
GlobalVariable property _Seed_FatigueActionRateExpertSpells auto 		; Default - 2.0
GlobalVariable property _Seed_FatigueActionRateAdeptSpells auto 		; Default - 1.0
GlobalVariable property _Seed_FatigueActionRateApprenticeSpells auto 	; Default - 0.5
GlobalVariable property _Seed_Setting_VampireBehavior auto
Actor property PlayerRef auto
Keyword property ActorTypeUndead auto
Keyword property ImmuneParalysis auto

float property MAX_FATIGUE = 120.0 autoReadOnly
float property MIN_FATIGUE = 0.0 autoReadOnly
float property SLEEP_RESTORE_RATE = 3.0 autoReadOnly

float property update_interval = 1.0 auto hidden
float property last_update_time auto hidden
bool property was_sleeping = false auto hidden
float last_sleep_duration
int locks_picked

Event OnInit()
	Initialize()
EndEvent

function Initialize()
    RegisterForSingleUpdateGameTime(update_interval)
    last_update_time = GetCurrentGameTime() * 24.0
    RegisterForSleep()

    ; Increase fatigue on archery attacks and lockpicking.
    RegisterForTrackedStatsEvent()
    RegisterForActorAction(6)
endFunction

Event OnTrackedStatsEvent(string arStatName, int aiStatValue)
	if arStatName == "Locks Picked" && aiStatValue > locks_picked
		debug.trace("[Seed] (Fatigue) Lock Picked")
		locks_picked = aiStatValue
		IncreaseFatigue(1.0)
	endif
EndEvent

Event OnActorAction(int actionType, Actor akActor, Form source, int slot)
	if akActor == PlayerRef
		debug.trace("[Seed] (Fatigue) Archery Attack")
		IncreaseFatigue(0.2)
	endif
EndEvent

Event OnUpdateGameTime()
	if was_sleeping
		was_sleeping = false
		return
	endif

	if _Seed_Setting_VampireBehavior.GetValueInt() == 2 && IsUndead()
		return
	endif

	float rate = _Seed_FatigueRate.GetValue()
	float this_time = GetCurrentGameTime() * 24.0
	int cycles = Math.Floor((this_time - last_update_time))
	float fatigue_increase = rate * cycles
	
    IncreaseFatigue(fatigue_increase)
    last_update_time = this_time
    if _Seed_VitalitySystemEnabled.GetValueInt() == 2
        RegisterForSingleUpdateGameTime(update_interval)
    endif
EndEvent

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
	was_sleeping = true
	last_sleep_duration = (afDesiredSleepEndTime - afSleepStartTime) * 24.0
EndEvent

Event OnSleepStop(bool abInterrupted)
	;@TODO: Modify by current hunger and thirst.
	float fatigue_decrease = last_sleep_duration * SLEEP_RESTORE_RATE
	DecreaseFatigue(fatigue_decrease)
EndEvent

function SpellCast(Spell akSpell)
	;@TODO: Player ReferenceAlias needs to call this from OnSpellCast().
	;@TODO: Increase Fatigue during concentration spell cast.
	if akSpell
		int mag_level = (akSpell.GetNthEffectMagicEffect(akSpell.GetCostliestEffectIndex())).GetSkillLevel()
		if mag_level >= 100
			IncreaseFatigue(_Seed_FatigueActionRateMasterSpells.GetValue())
		elseif mag_level >= 75
			IncreaseFatigue(_Seed_FatigueActionRateExpertSpells.GetValue())
		elseif mag_level >= 50
			IncreaseFatigue(_Seed_FatigueActionRateAdeptSpells.GetValue())
		elseif mag_level >= 25
			IncreaseFatigue(_Seed_FatigueActionRateApprenticeSpells.GetValue())
		else
			return
		endif
	endif
endFunction

function IncreaseFatigue(float amount)
	float current_fatigue = _Seed_AttributeFatigue.GetValue()
	if current_fatigue + amount >= MAX_FATIGUE
		_Seed_AttributeFatigue.SetValue(MAX_FATIGUE)
	else
		_Seed_AttributeFatigue.SetValue(current_fatigue + amount)
	endif
endFunction

function DecreaseFatigue(float amount)
	float current_fatigue = _Seed_AttributeFatigue.GetValue()
	if current_fatigue - amount <= MIN_FATIGUE
		_Seed_AttributeFatigue.SetValue(MIN_FATIGUE)
	else
		_Seed_AttributeFatigue.SetValue(current_fatigue - amount)
	endif
endFunction

function ModFatigue(float amount)
	float current_fatigue = _Seed_AttributeFatigue.GetValue()
	if current_fatigue + amount >= MAX_FATIGUE
		_Seed_AttributeFatigue.SetValue(MAX_FATIGUE)
	elseif current_fatigue + amount <= MIN_FATIGUE
		_Seed_AttributeFatigue.SetValue(MIN_FATIGUE)
	else
		_Seed_AttributeFatigue.SetValue(current_fatigue + amount)
	endif
endFunction

bool function IsUndead()
	; Is player humanoid Vampire, undead, or transformed Vampire Lord?
	if PlayerRef.GetRace().HasKeyword(ActorTypeUndead) || PlayerRef.GetRace().HasKeyword(ImmuneParalysis)
		return true
	else
		return false
	endif
endFunction