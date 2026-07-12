// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function NpcInteract(_npc, _source){
	// Guard against bad calls so player state code can safely ask to interact.
	if(_npc == noone) return false;
	
	// Copy the player's position before entering the NPC scope.
	var _sourceX = _source.x;
	var _sourceY = _source.y;
	
	// Run the response inside the NPC so its own variables are updated.
	with(_npc)
	{
		// Face the player during the interaction for readable staging.
		direction = point_direction(x, y, _sourceX, _sourceY);

		// Pull dialogue from the database so NPC objects stay focused on identity and movement.
		var _lines = DialogueGetLines(dialogueId);
		
		// Mark this villager as met for the first demo quest.
		QuestMarkNpcMet(dialogueId);
		
		// Open the dialogue panel using the current first-time or repeat lines.
		DialogueStart(displayName, _lines, dialogueId);

		// Also print to the debug console to make interaction testing obvious.
		show_debug_message(displayName + " dialogue started: " + dialogueId);
	}
	
	// Returning true lets callers know an NPC interaction happened.
	return true;
}
