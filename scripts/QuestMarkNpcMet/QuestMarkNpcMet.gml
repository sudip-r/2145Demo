// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function QuestMarkNpcMet(_npcKey){
	// Direct room testing may skip oGame's Create event, so create quest state if needed.
	if(!variable_global_exists("questMeetVillagersMet"))
	{
		global.questMeetVillagersMet = ds_map_create();
		global.questMeetVillagersTotal = 4;
		global.questMeetVillagersComplete = false;
		global.questMeetVillagersCompleteTimer = 0;
	}
	
	// Only count each NPC once for the meet-the-villagers objective.
	if(!ds_map_exists(global.questMeetVillagersMet, _npcKey))
	{
		ds_map_add(global.questMeetVillagersMet, _npcKey, true);
	}
	
	// Complete the objective when every planned villager has been met.
	var _metCount = QuestGetMeetVillagersCount();
	if(!global.questMeetVillagersComplete && _metCount >= global.questMeetVillagersTotal)
	{
		global.questMeetVillagersComplete = true;
		global.questMeetVillagersCompleteTimer = FRAME_RATE * 4;
		show_debug_message("Quest complete: Meet the Villagers");
	}
}
