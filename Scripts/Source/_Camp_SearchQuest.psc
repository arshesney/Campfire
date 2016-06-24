scriptname _Camp_SearchQuest extends Quest

ReferenceAlias property Alias1 auto
ReferenceAlias property Alias2 auto
ReferenceAlias property Alias3 auto
ReferenceAlias property Alias4 auto
ReferenceAlias property Alias5 auto
ReferenceAlias property Alias6 auto
ReferenceAlias property Alias7 auto
ReferenceAlias property Alias8 auto
ReferenceAlias property Alias9 auto
ReferenceAlias property Alias10 auto

Event InstinctsStartSearch()
	debug.trace("Starting quest.")
	self.Start()
	debug.trace("Quest started.")
	int i = 0
	while !IsReadyToStart() && i < 20
		Utility.Wait(0.2)
		i += 1
	endWhile
	SendEvent_InstinctsRunAliases()
	debug.trace("Event sent.")
endEvent

Event InstinctsStopSearch()
	self.Stop()
endEvent

bool function IsReadyToStart()
	if SearchAlias(Alias1).initialized &&	\
	   SearchAlias(Alias2).initialized &&	\
	   SearchAlias(Alias3).initialized &&	\
	   SearchAlias(Alias4).initialized &&	\
	   SearchAlias(Alias5).initialized &&	\
	   SearchAlias(Alias6).initialized &&	\
	   SearchAlias(Alias7).initialized &&	\
	   SearchAlias(Alias8).initialized &&	\
	   SearchAlias(Alias9).initialized &&	\
	   SearchAlias(Alias10).initialized
	   	return true
	else
		return false
	endif
endFunction

function SendEvent_InstinctsRunAliases()
	int handle = ModEvent.Create("Campfire_InstinctsRunAliases")
	if handle
		ModEvent.Send(handle)
	endif
endFunction

_Camp_SearchAliasBase function SearchAlias(ReferenceAlias akAlias)
	return akAlias as _Camp_SearchAliasBase
endFunction