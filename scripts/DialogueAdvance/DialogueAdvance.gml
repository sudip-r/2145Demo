// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DialogueAdvance(){
	// If dialogue is not open, there is nothing to advance.
	if(!global.dialogueActive) return;
	
	// If the current line is still revealing, Space finishes it instead of skipping ahead.
	if(global.dialogueVisibleChars < string_length(global.dialogueText))
	{
		global.dialogueVisibleChars = string_length(global.dialogueText);
		return;
	}
	
	// Move to the next line in the active dialogue sequence.
	global.dialogueLineIndex++;
	
	// Close the dialogue when the final line has already been shown.
	if(global.dialogueLineIndex >= array_length(global.dialogueLines))
	{
		DialogueEnd();
		return;
	}
	
	// Push the next stored line into the draw-facing text variable.
	global.dialogueText = global.dialogueLines[global.dialogueLineIndex];
	
	// Restart the typewriter reveal for the new line.
	global.dialogueVisibleChars = 0;
}
