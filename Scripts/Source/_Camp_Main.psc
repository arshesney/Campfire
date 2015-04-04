scriptname _Camp_Main extends Quest

import CampUtil
import _CampInternal

_Camp_Compatibility property Compatibility auto
Actor property PlayerRef auto
Quest property _Camp_FollowerQuest auto
Quest property _Camp_CampingCrimeTracking auto
Quest property CampfireObjectPlacementSystem auto
formlist property _Camp_TentActivators auto
ReferenceAlias property PlayerAlias auto
ReferenceAlias property Guard auto

event OnInit()
	if !self.IsRunning()
		self.Start()
		return
	endif
	if !_Camp_FollowerQuest.IsRunning()
		_Camp_FollowerQuest.Start()
	endif
	
	PlayerAlias.ForceRefTo(PlayerRef)
	Compatibility.RunCompatibility()
endEvent

function RegisterForEventsOnLoad()
	;pass
endFunction

function RegisterForControlsOnLoad()
	CampDebug(0, "Registering for controls!")
	RegisterForControl("Jump")
endFunction

Event OnControlDown(string control)
	if control == "Jump"
		CampDebug(0, "Got jump press, checking for tent.")
		ObjectReference tent = GetCurrentTent()
		if tent && PlayerRef.GetSitState() == 3
			CampDebug(0, "Activating tent " + tent)
			tent.Activate(PlayerRef)
		endif
	endif
endEvent