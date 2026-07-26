// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function NpcGetTempleQuestLines(_dialogueId){
	// Only Ama is wired to the temple cleanup quest for now.
	if(_dialogueId != "ama.intro") return undefined;

	// Direct room testing may skip oGame's Create event, so bail out until quest state exists.
	if(!variable_global_exists("questTempleCleanupActive")) return undefined;

	// Every pile is cleared - deliver the one-time thank-you and close out the quest.
	if(global.questTempleCleanupCleared && !global.questTempleCleanupComplete)
	{
		global.questTempleCleanupComplete = true;
		global.questTempleCleanupCompleteTimer = FRAME_RATE * 4;
		show_debug_message("Quest complete: Temple Cleanup");

		return [
			"You cleared every scrap from the temple grounds. Thank you.",
			"The old stones look like themselves again."
		];
	}

	// Already thanked - let her fall back to normal dialogue from here on.
	if(global.questTempleCleanupComplete) return undefined;

	// Quest accepted but piles remain - remind the player what to do.
	if(global.questTempleCleanupActive)
	{
		return [
			"The temple grounds are still scattered with garbage.",
			"Walk up to a pile and hold Ctrl until it clears."
		];
	}

	// Not the right moment to offer the quest yet - let her normal dialogue play instead.
	if(!QuestTempleCleanupIsAvailable(_dialogueId)) return undefined;

	// First qualifying interaction after the introductions - hand out the quest.
	global.questTempleCleanupActive = true;

	return [
		"Now that you know the village, I have something to ask.",
		"Garbage has piled up around the temple grounds. Would you clear it for me?",
		"Walk close to a pile and hold Ctrl until it is gone."
	];
}
