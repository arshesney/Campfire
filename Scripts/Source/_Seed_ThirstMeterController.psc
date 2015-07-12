scriptname _Seed_ThirstMeterController extends Quest

; Tested as working under the following criteria:
; meter.Height = -20
; meter.Width = 265.75

GlobalVariable property _Seed_AttributeThirst auto
GlobalVariable property _Seed_DebugMetersAlwaysOn auto

;/_DE_WetMeter property WetMeter auto
_DE_Compatibility property Compatibility auto
_DE_EPMonitor_1_6 property Frostfall auto
GlobalVariable property _DE_FireDistance auto
GlobalVariable property _DE_ExposureMeterDisplay_Contextual auto
GlobalVariable property _DE_ExposureMeter_Opacity auto
GlobalVariable property _DE_WMColor_Light auto
GlobalVariable property _DE_WMColor_Dark auto
GlobalVariable property _DE_MeterDisplayTime auto
Formlist property _DE_SleepObjects auto
Actor property PlayerRef auto

int iDisplayIterationsRemaining
float fLastWet
/;


Event OnInit()
	Utility.wait(1)
	StartUpdating()
endEvent

Event OnGameReload()
	StartUpdating()
endEvent

Event OnUpdate()
	; @TODO: Add compatibility system integration
	;if Compatibility.isSKYUILoaded
	;	if Frostfall.pSetting_IsRunning == false || Frostfall.ShutdownState == true
	;		WetMeter.Alpha = 0.0
	;	else
	;		UpdateMeter()
	;	endif
	;endif
	UpdateMeter()
	RegisterForSingleUpdate(4)
endEvent

function StartUpdating()
	RegisterForSingleUpdate(4)
endFunction


function UpdateMeter(bool bSkipDisplayHandling = false)
	_Seed_ThirstMeter meter = ((self as Quest) as _Seed_ThirstMeter)
	
	meter.HAnchor = "left"
	meter.VAnchor = "bottom"
	meter.FillDirection = "right"
	meter.X = 1194.25
	meter.Y = 717.5
	meter.Height = -22.0
	meter.Width = 292.0
	meter.PrimaryColor = 0x2196F3
	meter.SecondaryColor = 0x1976D2
	
	;meter.Width = 235 ;shorter option
	

	float thirst = _Seed_AttributeThirst.GetValue()

	if _Seed_DebugMetersAlwaysOn.GetValueInt() == 2
		meter.Alpha = 100.0
		meter.SetPercent(thirst / 120.0)
	endif

	;meter.StartFlash()

	;/if _DE_ExposureMeterDisplay_Contextual.GetValueInt() == 1
		WetMeter.Alpha = _DE_ExposureMeter_Opacity.GetValue()
	elseif _DE_ExposureMeterDisplay_Contextual.GetValueInt() == 2 || bSkipDisplayHandling
		ContextualDisplay(fThisWet)
	elseif _DE_ExposureMeterDisplay_Contextual.GetValueInt() == 0 && iDisplayIterationsRemaining == 0
		WetMeter.Alpha = 0.0
		return
	endif

	WetMeter.SetPercent(fThisWet / 750.0)
	WetMeter.SetColors(_DE_WMColor_Light.GetValueInt(), _DE_WMColor_Dark.GetValueInt())
	fLastWet = fThisWet

	if iDisplayIterationsRemaining > 0
		iDisplayIterationsRemaining -= 1
		if iDisplayIterationsRemaining <= 0
			iDisplayIterationsRemaining = 0
			if _DE_ExposureMeterDisplay_Contextual.GetValueInt() != 1
				WetMeter.FadeTo(0.0, 3.0)
			endif
		endif
	elseif iDisplayIterationsRemaining == 0
		if WetMeter.Alpha == _DE_ExposureMeter_Opacity.GetValue()
			if _DE_ExposureMeterDisplay_Contextual.GetValueInt() != 1
				WetMeter.FadeTo(0.0, 3.0)
			endif
		endif
	else
		;keep it on
	endif
	/;

endFunction

;/
function ContextualDisplay(float fThisWet, bool bSkipDisplayHandling = false)
	;debug.trace("[Frostfall] " + fThisWet + " " + fLastWet + " " + iDisplayIterationsRemaining)

	if bSkipDisplayHandling
		iDisplayIterationsRemaining = _DE_MeterDisplayTime.GetValueInt()
		return
	endif

	bool GoingUp = fLastWet < fThisWet
	if GoingUp && fThisWet >= 550.0
		WetMeter.FadeTo(_DE_ExposureMeter_Opacity.GetValue(), 2.0)
		iDisplayIterationsRemaining = _DE_MeterDisplayTime.GetValueInt()
	elseif GoingUp && fLastWet < 200.0 && fThisWet >= 200.0
		WetMeter.FadeTo(_DE_ExposureMeter_Opacity.GetValue(), 2.0)
		iDisplayIterationsRemaining = _DE_MeterDisplayTime.GetValueInt()
	elseif GoingUp && fLastWet < 400.0 && fThisWet >= 400.0
		WetMeter.FadeTo(_DE_ExposureMeter_Opacity.GetValue(), 2.0)
		iDisplayIterationsRemaining = _DE_MeterDisplayTime.GetValueInt()
	elseif !GoingUp && fLastWet != fThisWet && fThisWet > 0.0 && (_DE_FireDistance.GetValue() != -1 || Game.FindClosestReferenceOfAnyTypeInListFromRef(_DE_SleepObjects, PlayerRef,  600.0) != None)
		WetMeter.FadeTo(_DE_ExposureMeter_Opacity.GetValue(), 2.0)
		iDisplayIterationsRemaining = -1
	elseif (fLastWet > 0.0 && fThisWet <= 0.0) || (_DE_FireDistance.GetValue() == -1 && fThisWet < 550.0)
		if iDisplayIterationsRemaining == -1
			iDisplayIterationsRemaining = _DE_MeterDisplayTime.GetValueInt()
		endif
	endif

endFunction

function ForceDisplayAndUpdate(bool bSkipDisplayHandling = true)
	if Compatibility.isSKYUILoaded
		;Called by spells that change exposure.
		iDisplayIterationsRemaining = _DE_MeterDisplayTime.GetValueInt()
		WetMeter.FadeTo(_DE_ExposureMeter_Opacity.GetValue(), 1.0)
		UpdateMeter(bSkipDisplayHandling)
	endif
endFunction
/;