// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerStatePlough(){
	//Movement 
	hSpeed = 0;
	vSpeed = 0;
	
	moveDistanceRemaining = max(0, moveDistanceRemaining - speedPlough);
	
	var _collided = PlayerCollision();
	
	sprite_index = spritePlough;
	var _totalFrames = sprite_get_number(sprite_index) / 4;
	
	image_index = (CARDINAL_DIR * _totalFrames) + min(((1 - (moveDistanceRemaining / distancePlough)) * _totalFrames), _totalFrames - 1);
	
	//Change State
	if(moveDistanceRemaining <= 0)
	{
		state = PlayerStateFree;
	}
}