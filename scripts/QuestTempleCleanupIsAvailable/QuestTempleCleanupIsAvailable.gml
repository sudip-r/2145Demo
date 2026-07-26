// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function QuestTempleCleanupIsAvailable(_dialogueId){
	// Only Ama offers the temple cleanup quest right now.
	if(_dialogueId != "ama.intro") return false;

	// Direct room testing may skip oGame's Create event, so treat missing quest state as locked.
	if(!variable_global_exists("questMeetVillagersComplete")) return false;

	// She only brings it up once every villager has been met.
	if(!global.questMeetVillagersComplete) return false;

	// Hide the marker once she has already handed out or finished the quest.
	return !global.questTempleCleanupActive && !global.questTempleCleanupComplete;
}
