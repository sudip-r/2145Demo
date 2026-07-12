// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DialogueEnd(){
	// Mark the dialogue panel as closed.
	global.dialogueActive = false;
	
	// Clear the displayed text so stale dialogue cannot flash on the next open.
	global.dialogueSpeaker = "";
	global.dialogueText = "";
	global.dialogueId = "";
	global.dialogueLines = [];
	global.dialogueLineIndex = 0;
	global.dialogueInputDelay = 0;
	global.dialogueVisibleChars = 0;
	
	// Restore the pause state that existed before this dialogue started.
	global.gamePaused = global.dialoguePreviousPaused;
}
