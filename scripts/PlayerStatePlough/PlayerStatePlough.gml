// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerStatePlough(){
	// Ploughing locks player movement while the action animation progresses.
	hSpeed = 0;
	vSpeed = 0;
	
	// Use remaining distance as the action timer.
	moveDistanceRemaining = max(0, moveDistanceRemaining - speedPlough);
	
	// Keep collision resolution active in case another script sets movement.
	var _collided = PlayerCollision();
	
	// Pick the plough animation row for the current facing direction.
	sprite_index = spritePlough;
	var _totalFrames = sprite_get_number(sprite_index) / 4;
	
	// Convert action progress into the frame within the selected direction row.
	image_index = (CARDINAL_DIRECTION * _totalFrames) + min(((1 - (moveDistanceRemaining / distancePlough)) * _totalFrames), _totalFrames - 1);
	
	// Return to normal movement when the plough action finishes.
	if(moveDistanceRemaining <= 0)
	{
		state = PlayerStateFree;
	}
}
