// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function NpcFindInteractTarget(_source){
	// Check a point slightly in front of the player so interactions feel directional.
	var _lookDistance = 48;
	var _lookX = _source.x + lengthdir_x(_lookDistance, _source.direction);
	var _lookY = _source.y + lengthdir_y(_lookDistance, _source.direction);

	// Find the closest NPC parent/child near that look point.
	var _target = instance_nearest(_lookX, _lookY, oNpcParent);
	
	// No NPC exists in the room, or none could be found by instance_nearest.
	if(_target == noone) return noone;
	
	// Compare both facing distance and direct player distance.
	var _distanceToLookPoint = point_distance(_target.x, _target.y, _lookX, _lookY);
	var _distanceToPlayer = point_distance(_target.x, _target.y, _source.x, _source.y);
	
	// Allow talking when the NPC is in front of the player or very close beside them.
	if(_distanceToLookPoint <= _target.interactRadius || _distanceToPlayer <= 56)
	{
		return _target;
	}
	
	// Returning noone tells the player state to continue with its normal action.
	return noone;
}
