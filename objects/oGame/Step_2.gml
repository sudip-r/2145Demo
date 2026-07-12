/// @description Toggle pause

// Dialogue owns Space/Enter while it is active, then returns control to gameplay.
if(global.dialogueActive)
{
	// Reveal the current line a few characters at a time for an RPG text-box feel.
	if(global.dialogueVisibleChars < string_length(global.dialogueText))
	{
		global.dialogueVisibleChars = min(
			string_length(global.dialogueText),
			global.dialogueVisibleChars + global.dialogueTextSpeed
		);
	}

	// Short delay prevents the opening key press from closing the same dialogue.
	if(global.dialogueInputDelay > 0)
	{
		global.dialogueInputDelay--;
	}
	else if(keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter))
	{
		// Advance through multi-line dialogue before closing the panel.
		DialogueAdvance();
	}

	exit;
}

// Let the quest-complete HUD toast fade out during normal gameplay.
if(global.questMeetVillagersCompleteTimer > 0)
{
	global.questMeetVillagersCompleteTimer--;
}

// Press Escape to pause or resume gameplay.
if (keyboard_check_pressed(vk_escape))
{
	global.gamePaused = !global.gamePaused;
	
	// Pause every instance animation by storing its current image speed.
	if(global.gamePaused)
	{
		with(all)
		{
			gamePausedImageSpeed = image_speed;
			image_speed = 0;
		}
	}
	else 
	{
		// Restore each instance's animation speed when unpausing.
		with(all)
		{
			image_speed = gamePausedImageSpeed;
		}
	}
}
