// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerStateAttack(){
	// Attacking locks player movement while the swing animation progresses.
	hSpeed = 0;
	vSpeed = 0;

	// Use remaining distance as the action timer, same approach as ploughing.
	moveDistanceRemaining = max(0, moveDistanceRemaining - speedAttack);

	// Keep collision resolution active in case another script sets movement.
	var _collided = PlayerCollision();

	// Reuse the plough sprite as a temporary swing animation until dedicated weapon art exists.
	sprite_index = spritePlough;
	var _totalFrames = sprite_get_number(sprite_index) / 4;

	// Convert action progress into the frame within the selected direction row.
	image_index = (CARDINAL_DIRECTION * _totalFrames) + min(((1 - (moveDistanceRemaining / distanceAttack)) * _totalFrames), _totalFrames - 1);

	// Return to normal movement when the attack finishes.
	if(moveDistanceRemaining <= 0)
	{
		state = PlayerStateFree;
	}
}
