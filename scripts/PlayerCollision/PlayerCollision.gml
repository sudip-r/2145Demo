// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerCollision(){
	var _collision = false;
	
	// Resolve horizontal movement first so diagonal movement can slide along walls.
	var _blockedHorizontal = false;

	// Only query the tilemap if this room has a valid collision layer cached.
	if(collisionMap != noone && tilemap_get_at_pixel(collisionMap, x + hSpeed, y))
	{
		_blockedHorizontal = true;
	}

	// NPCs are checked separately from tiles because they are moving instances, not tilemap cells.
	if(PlayerBlockedByNpc(x + hSpeed, y))
	{
		_blockedHorizontal = true;
	}

	if(_blockedHorizontal)
	{
		// Tile collision snaps to grid, but NPC collision only clears speed so the player does not jump.
		if(collisionMap != noone && tilemap_get_at_pixel(collisionMap, x + hSpeed, y))
		{
			x -= x mod COLLISION_TILE_SIZE;
			if(sign(hSpeed) == 1) x += COLLISION_TILE_SIZE - 1;
		}

		hSpeed = 0;
		_collision = true;
	}
	x += hSpeed;
	
	// Resolve vertical movement after horizontal movement has updated x.
	var _blockedVertical = false;

	// Only query the tilemap if this room has a valid collision layer cached.
	if(collisionMap != noone && tilemap_get_at_pixel(collisionMap, x, y + vSpeed))
	{
		_blockedVertical = true;
	}

	// Check NPC body space on the vertical pass too, so diagonal movement can slide around NPCs.
	if(PlayerBlockedByNpc(x, y + vSpeed))
	{
		_blockedVertical = true;
	}

	if(_blockedVertical)
	{
		// Tile collision snaps to grid, but NPC collision only clears speed so the player does not jump.
		if(collisionMap != noone && tilemap_get_at_pixel(collisionMap, x, y + vSpeed))
		{
			y -= y mod COLLISION_TILE_SIZE;
			if(sign(vSpeed) == 1) y += COLLISION_TILE_SIZE - 1;
		}

		vSpeed = 0;
		_collision = true;
	}
	
	y += vSpeed; 
	
	// Let callers know whether movement touched a blocked tile.
	return _collision;
}

function PlayerBlockedByNpc(_checkX, _checkY){
	// If the room has no NPCs, there is nothing extra to block.
	if(!instance_exists(oNpcParent))
	{
		return false;
	}

	// Use player-tuned collision radii when available, otherwise fall back to safe defaults.
	var _radiusX = 18;
	var _radiusY = 12;
	if(variable_instance_exists(id, "npcCollisionRadiusX")) _radiusX = npcCollisionRadiusX;
	if(variable_instance_exists(id, "npcCollisionRadiusY")) _radiusY = npcCollisionRadiusY;

	// Compare against each NPC's feet position instead of the full sprite rectangle.
	// This keeps villagers from becoming giant invisible walls because their sprites are tall.
	for(var _i = 0; _i < instance_number(oNpcParent); _i++)
	{
		var _npc = instance_find(oNpcParent, _i);

		if(instance_exists(_npc))
		{
			var _insideBodyX = abs(_checkX - _npc.x) < _radiusX;
			var _insideBodyY = abs(_checkY - _npc.y) < _radiusY;

			if(_insideBodyX && _insideBodyY)
			{
				// If the player is already overlapping, allow movement that increases distance.
				// This prevents the player from getting trapped when loading into a crowded spot.
				var _currentlyInsideBodyX = abs(x - _npc.x) < _radiusX;
				var _currentlyInsideBodyY = abs(y - _npc.y) < _radiusY;

				if(_currentlyInsideBodyX && _currentlyInsideBodyY)
				{
					var _currentDistance = point_distance(x, y, _npc.x, _npc.y);
					var _nextDistance = point_distance(_checkX, _checkY, _npc.x, _npc.y);

					return (_nextDistance <= _currentDistance);
				}

				return true;
			}
		}
	}

	return false;
}
