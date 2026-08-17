/// @description Dialogue, pause menu, and HUD timers

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

// Escape opens or closes the gameplay pause menu.
if(keyboard_check_pressed(vk_escape))
{
	if(global.gamePaused)
	{
		GameSetPaused(false);
	}
	else
	{
		pauseSelected = 0;
		pauseNotice = "";
		pauseNoticeTimer = 0;
		GameSetPaused(true);
	}

	// Do not let the same Escape press also operate the menu.
	exit;
}

if(global.gamePaused)
{
	var _guiW = display_get_gui_width();
	var _guiH = display_get_gui_height();
	var _buttonX1 = (_guiW * 0.5) - 150;
	var _buttonX2 = (_guiW * 0.5) + 150;
	var _buttonStartY = (_guiH * 0.5) - 72;
	var _buttonH = 50;
	var _buttonGap = 14;
	var _mouseX = device_mouse_x_to_gui(0);
	var _mouseY = device_mouse_y_to_gui(0);

	pauseHovered = -1;

	for(var _i = 0; _i < array_length(pauseItems); _i++)
	{
		var _y1 = _buttonStartY + (_i * (_buttonH + _buttonGap));
		var _y2 = _y1 + _buttonH;

		if(point_in_rectangle(
			_mouseX, _mouseY,
			_buttonX1, _y1,
			_buttonX2, _y2
		))
		{
			pauseHovered = _i;
			pauseSelected = _i;
		}
	}

	if(keyboard_check_pressed(vk_up))
	{
		pauseSelected =
			(pauseSelected - 1 + array_length(pauseItems))
			mod array_length(pauseItems);
	}

	if(keyboard_check_pressed(vk_down))
	{
		pauseSelected =
			(pauseSelected + 1)
			mod array_length(pauseItems);
	}

	var _mouseActivate =
		pauseHovered != -1 &&
		mouse_check_button_pressed(mb_left);
	var _keyboardActivate =
		keyboard_check_pressed(vk_enter) ||
		keyboard_check_pressed(vk_space);

	if(_mouseActivate || _keyboardActivate)
	{
		switch(pauseSelected)
		{
			case 0: // Resume
				GameSetPaused(false);
				break;

			case 1: // Save Game
				if(SaveGameWrite())
				{
					pauseNotice = "Game saved";
				}
				else
				{
					pauseNotice = "Save failed";
				}

				pauseNoticeTimer = FRAME_RATE * 2;
				break;

			case 2: // Main Menu
				// This does not auto-save; use Save Game first when needed.
				ReturnToMainMenu();
				exit;
		}
	}

	if(pauseNoticeTimer > 0)
	{
		pauseNoticeTimer--;
	}

	// Stop quest timers and all other oGame work while paused.
	exit;
}

// Let the quest-complete HUD toast fade out during normal gameplay.
if(global.questMeetVillagersCompleteTimer > 0)
{
	global.questMeetVillagersCompleteTimer--;
}

// Same fade-out countdown for the temple cleanup quest's completion toast.
if(global.questTempleCleanupCompleteTimer > 0)
{
	global.questTempleCleanupCompleteTimer--;
}
