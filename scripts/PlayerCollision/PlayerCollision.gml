// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerCollision(){
	var _collision = false;
	
	// Some work-in-progress rooms may not have a valid collision tilemap yet.
	// In that case, move freely instead of calling tilemap_get_at_pixel on a bad id.
	if(collisionMap == noone)
	{
		x += hSpeed;
		y += vSpeed;
		return false;
	}

	// Resolve horizontal movement first so diagonal movement can slide along walls.
	if(tilemap_get_at_pixel(collisionMap, x + hSpeed, y)) 
	{
		// Snap back to the collision grid edge before clearing horizontal speed.
		x -= x mod COLLISION_TILE_SIZE;
		
		if(sign(hSpeed) == 1) x += COLLISION_TILE_SIZE - 1;
		hSpeed = 0;
		_collision = true;
	}
	x += hSpeed;
	
	// Resolve vertical movement after horizontal movement has updated x.
	if(tilemap_get_at_pixel(collisionMap, x, y + vSpeed)) 
	{
		// Snap back to the collision grid edge before clearing vertical speed.
		y -= y mod COLLISION_TILE_SIZE;
		
		if(sign(vSpeed) == 1) y += COLLISION_TILE_SIZE - 1;
		vSpeed = 0;
		_collision = true;
	}
	
	y += vSpeed; 
	
	// Let callers know whether movement touched a blocked tile.
	return _collision;
}
