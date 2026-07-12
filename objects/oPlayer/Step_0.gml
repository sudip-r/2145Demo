// Read movement input and one-shot action presses.
keyLeft = keyboard_check(vk_left); // or keyboard_check(ord("A")); //for letter
keyRight = keyboard_check(vk_right);
keyUp = keyboard_check(vk_up);
keyDown = keyboard_check(vk_down);

// Space is pressed-only so NPC talk/plough actions trigger once per key press.
keyActivate = keyboard_check_pressed(vk_space);
keyRun = keyboard_check(vk_shift);
keyAttack = keyboard_check(vk_shift);
keyItem = keyboard_check(vk_control);

// Convert arrow-key input into a direction angle and movement flag.
inputDirection = point_direction(0,0, keyRight - keyLeft, keyDown - keyUp);
inputMagnitude = (keyRight - keyLeft != 0) || (keyDown - keyUp != 0);


// Run the active player state while gameplay is not paused.
if(!global.gamePaused) script_execute(state);
