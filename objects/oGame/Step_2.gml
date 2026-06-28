/// @description Toggle pause

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
