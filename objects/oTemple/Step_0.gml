var _targetAlpha = templeSolidAlpha;
var _baseY = y - templeBaseDepthOffset;
var _targetDepth = -floor(_baseY);

if(instance_exists(oPlayer))
{
	var _player = instance_find(oPlayer, 0);
	var _spriteLeft = x - sprite_get_xoffset(sprite_index);
	var _spriteTop = y - sprite_get_yoffset(sprite_index);
	var _spriteRight = _spriteLeft + sprite_get_width(sprite_index);
	var _spriteBottom = _spriteTop + sprite_get_height(sprite_index);
	var _playerOverlapsTempleMask =
		_player.bbox_right >= bbox_left &&
		_player.bbox_left <= bbox_right &&
		_player.bbox_bottom >= bbox_top &&
		_player.bbox_top <= bbox_bottom;
	var _playerOverlapsTempleSprite =
		_player.bbox_right >= _spriteLeft &&
		_player.bbox_left <= _spriteRight &&
		_player.bbox_bottom >= _spriteTop &&
		_player.bbox_top <= _spriteBottom;
	var _playerOnTempleSteps = _playerOverlapsTempleSprite && !_playerOverlapsTempleMask && _player.bbox_bottom >= bbox_bottom;

	if(_playerOverlapsTempleMask)
	{
		_targetAlpha = templeFadeAlpha;
	}

	if(_playerOnTempleSteps)
	{
		_targetDepth = -floor(_player.y) + 1;
	}
}

image_alpha = lerp(image_alpha, _targetAlpha, templeFadeLerp);

// Sort the temple by its base so the player can appear behind it or in front of it.
depth = _targetDepth;
