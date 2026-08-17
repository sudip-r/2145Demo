/// @description Release manually allocated data when oGame is destroyed

if(variable_global_exists("dialogueSeen")
&& ds_exists(global.dialogueSeen, ds_type_map))
{
	ds_map_destroy(global.dialogueSeen);
	global.dialogueSeen = -1;
}

if(variable_global_exists("questMeetVillagersMet")
&& ds_exists(global.questMeetVillagersMet, ds_type_map))
{
	ds_map_destroy(global.questMeetVillagersMet);
	global.questMeetVillagersMet = -1;
}
