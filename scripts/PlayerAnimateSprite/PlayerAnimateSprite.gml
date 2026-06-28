// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerAnimateSprite(){
	var _cardinalDirection = round(direction / 90);
	if(_cardinalDirection == 4) _cardinalDirection = 0;
	
	if(sprite_index == spriteIdle)
	{
		if(_cardinalDirection == 1) _cardinalDirection = 3;
		else if(_cardinalDirection == 3) _cardinalDirection = 1;
	}
	
	var _totalFrames = sprite_get_number(sprite_index) / 4;
	image_index = localFrame + (_cardinalDirection * _totalFrames);
	localFrame += sprite_get_speed(sprite_index) / FRAME_RATE;
	
	if(localFrame >= _totalFrames)
	{
		animationEnd = true;
		localFrame -= _totalFrames;
	} else animationEnd = false;
}
