// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function NpcAnimateSprite(){
	// Convert the NPC's direction angle into the matching sprite row.
	var _cardinalDirection = CARDINAL_DIRECTION;
	
	// The temporary NPC sprites use the player's idle-sheet ordering.
	if(_cardinalDirection == 1) _cardinalDirection = 3;
	else if(_cardinalDirection == 3) _cardinalDirection = 1;
	
	// Each direction owns one quarter of the sprite frames.
	var _totalFrames = max(1, sprite_get_number(sprite_index) / 4);
	image_index = localFrame + (_cardinalDirection * _totalFrames);
	
	// Advance animation only while actively walking between patrol points.
	if(array_length(patrolPoints) > 1 && patrolWait <= 0)
	{
		localFrame += sprite_get_speed(sprite_index) / FRAME_RATE;

		// Loop within the current direction row.
		if(localFrame >= _totalFrames) localFrame -= _totalFrames;
	}
	else
	{
		// While idle, hold the first frame for the current facing direction.
		localFrame = 0;
	}
}
