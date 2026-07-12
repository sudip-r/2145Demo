// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DialogueStart(_speakerName, _lineData, _dialogueId){
	// Store whether the game was already paused so closing dialogue can restore correctly.
	global.dialoguePreviousPaused = global.gamePaused;
	
	// Dialogue pauses gameplay while leaving the persistent oGame controller active.
	global.gamePaused = true;
	global.dialogueActive = true;
	
	// Store the current speaker and dialogue id for the draw event and future branching.
	global.dialogueSpeaker = _speakerName;
	global.dialogueId = _dialogueId;

	// Accept either one string or an array of strings, so simple callers stay simple.
	if(is_array(_lineData))
	{
		global.dialogueLines = _lineData;
	}
	else
	{
		global.dialogueLines = [_lineData];
	}
	
	// Start from the first line every time a new dialogue opens.
	global.dialogueLineIndex = 0;
	global.dialogueText = global.dialogueLines[global.dialogueLineIndex];

	// Start the typewriter reveal from zero visible characters.
	global.dialogueVisibleChars = 0;
	
	// Prevent the same Space press that opened dialogue from also closing it immediately.
	global.dialogueInputDelay = 2;
}
