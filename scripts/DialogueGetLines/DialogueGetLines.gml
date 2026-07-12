// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DialogueGetLines(_dialogueId){
	// Direct room testing may skip oGame's Create event, so create the seen map if needed.
	if(!variable_global_exists("dialogueSeen"))
	{
		global.dialogueSeen = ds_map_create();
	}
	
	// Track whether this dialogue id has already been used during the current run.
	var _hasBeenSeen = ds_map_exists(global.dialogueSeen, _dialogueId);
	
	// Mark this id as seen before returning lines so the next interaction becomes repeat dialogue.
	if(!_hasBeenSeen)
	{
		ds_map_add(global.dialogueSeen, _dialogueId, true);
	}
	
	// Intro lines are shown once. Repeat lines keep later interactions short.
	switch(_dialogueId)
	{
		case "maya.intro":
			if(!_hasBeenSeen)
			{
				return [
					"Welcome. I am Maya, and this will be the village shop.",
					"Once the shelves are stocked, you will be able to buy seeds and supplies here.",
					"For now, get used to the paths. A good village should be easy to read."
				];
			}
			
			return [
				"The shop is not open yet, but the east side is the right place for it.",
				"Come back later when we add buying and selling."
			];
		
		case "biren.intro":
			if(!_hasBeenSeen)
			{
				return [
					"These fields will need steady hands.",
					"Clear paths matter as much as pretty scenery. If a farmer snags on every corner, work gets old fast.",
					"When the village layout settles, this south edge can become the farming tutorial area."
				];
			}
			
			return [
				"South edge for fields. Keep it open, useful, and easy to reach."
			];
		
		case "ama.intro":
			if(!_hasBeenSeen)
			{
				return [
					"This old tree remembers more than we do.",
					"People should gather near landmarks. It gives the player a place to return to.",
					"Later, I can carry the village lore and first quest hints."
				];
			}
			
			return [
				"The old tree should stay important. Players remember places with a center."
			];
		
		case "tika.intro":
			if(!_hasBeenSeen)
			{
				return [
					"I know every shortcut in the village.",
					"North for homes, east for shops, south for fields. That is the shape I would give this place.",
					"If I keep moving, the village feels awake even before quests exist."
				];
			}
			
			return [
				"North homes, east shops, south fields. Easy map, easy memory."
			];
	}
	
	// Fallback dialogue protects the game if an NPC has a missing or misspelled dialogue id.
	return [
		"Dialogue is not written for this character yet."
	];
}
