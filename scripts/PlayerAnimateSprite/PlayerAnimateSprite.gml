// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerAnimateSprite(){
	// Convert facing direction into the matching row of the 4-direction sprite sheet.
	var _cardinalDirection = CARDINAL_DIRECTION;
	
	// Idle sprites store left/right rows in the opposite order from movement sprites.
	if(sprite_index == spriteIdle)
	{
		if(_cardinalDirection == 1) _cardinalDirection = 3;
		else if(_cardinalDirection == 3) _cardinalDirection = 1;
	}
	
	// Each direction owns one quarter of the sprite frames.
	var _totalFrames = sprite_get_number(sprite_index) / 4;
	image_index = localFrame + (_cardinalDirection * _totalFrames);
	
	// Advance the local frame manually because image_speed is disabled.
	localFrame += sprite_get_speed(sprite_index) / FRAME_RATE;
	
	// Loop back to the start of this direction row when the animation finishes.
	if(localFrame >= _totalFrames)
	{
		animationEnd = true;
		localFrame -= _totalFrames;
	} else animationEnd = false;
}
