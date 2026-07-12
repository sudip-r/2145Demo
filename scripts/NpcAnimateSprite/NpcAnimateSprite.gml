// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function NpcAnimateSprite(){
	// Convert the NPC's direction angle into the matching sprite row.
	var _cardinalDirection = CARDINAL_DIRECTION;
	
	// NPCs use the player walking sheet as temporary art, so direction rows match movement sprites.
	var _totalFrames = max(1, sprite_get_number(sprite_index) / 4);
	
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

	// Use an integer frame index so GameMaker never samples between animation frames.
	var _frameInDirection = clamp(floor(localFrame), 0, _totalFrames - 1);
	image_index = _frameInDirection + (_cardinalDirection * _totalFrames);
}
