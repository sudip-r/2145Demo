//Get player input
keyLeft = keyboard_check(vk_left); // or keyboard_check(ord("A")); //for letter
keyRight = keyboard_check(vk_right);
keyUp = keyboard_check(vk_up);
keyDown = keyboard_check(vk_down);
keyActivate = keyboard_check(vk_space);
keyRun = keyboard_check(vk_shift);
keyAttack = keyboard_check(vk_shift);
keyItem = keyboard_check(vk_control);

inputDirection = point_direction(0,0, keyRight - keyLeft, keyDown - keyUp);
inputMagnitude = (keyRight - keyLeft != 0) || (keyDown - keyUp != 0);


if(!global.gamePaused) script_execute(state);
