/// @description Configure room layers

// Hide the collision tile layer during gameplay.
if(layer_exists("Col")) layer_set_visible("Col", false);

// Make sure gameplay art layers are visible when the room starts.
if(layer_exists("GroundAndObjects")) layer_set_visible("GroundAndObjects", true);
if(layer_exists("Ground")) layer_set_visible("Ground", true);
if(layer_exists("Trees")) layer_set_visible("Trees", true);
if(layer_exists("Buildings")) layer_set_visible("Buildings", true);
if(layer_exists("Road")) layer_set_visible("Road", true);
if(layer_exists("Objects")) layer_set_visible("Objects", true);

// Turn the Garbage tile layer into collectible piles for the temple cleanup quest.
if(layer_exists("Garbage"))
{
	GarbageSpawnPiles();
}

// Apply staged load data only after the room has created oPlayer.
if(is_struct(global.pendingLoad)
&& global.pendingLoad.active
&& instance_exists(oPlayer))
{
	var _player = instance_find(oPlayer, 0);

	_player.x = clamp(global.pendingLoad.playerX, 0, room_width);
	_player.y = clamp(global.pendingLoad.playerY, 0, room_height);
	_player.direction = global.pendingLoad.playerDirection;

	global.pendingLoad = undefined;
	global.gamePaused = false;

	// Force the persistent camera to snap to the restored position.
	if(instance_exists(oCamera))
	{
		var _camera = instance_find(oCamera, 0);
		_camera.cameraInitialized = false;
	}
}
