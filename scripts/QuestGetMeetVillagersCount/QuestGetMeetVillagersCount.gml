// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function QuestGetMeetVillagersCount(){
	// If quest state does not exist yet, no villagers have been met.
	if(!variable_global_exists("questMeetVillagersMet"))
	{
		return 0;
	}
	
	// The met map only stores unique NPC keys, so its size is the current progress.
	return ds_map_size(global.questMeetVillagersMet);
}
