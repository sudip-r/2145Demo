/// @description Update camera

// Rebind to the current room's view camera.
// oCamera is persistent, so the room can change even when view_camera[0] keeps the same handle.
if(cam != view_camera[0] || currentRoom != room)
{
	currentRoom = room;
	cam = view_camera[0];
	viewWidthHalf = camera_get_view_width(cam) * 0.5;
	viewHeightHalf = camera_get_view_height(cam) * 0.5;
	cameraInitialized = false;
}

// Update destination to the follow target's position.
if (instance_exists(follow))
{
	// Resolve the object index into an actual instance before reading position.
	var _followInstance = instance_find(follow, 0);
	xTo = _followInstance.x;
	yTo = _followInstance.y;
	
	// On the first valid follow frame, snap directly to the target so the
	// player starts centered instead of easing in from the previous room.
	if(!cameraInitialized)
	{
		x = xTo;
		y = yTo;
		cameraInitialized = true;
	}
}

// Smoothly move this controller object toward the target position.
x += (xTo - x) / 15;
y += (yTo - y) / 15;

// Keep the camera center inside the room bounds.
// If a room is smaller than the view, center the camera on the room instead of using an inverted clamp range.
var _viewWidth = camera_get_view_width(cam);
var _viewHeight = camera_get_view_height(cam);

if(room_width <= _viewWidth)
{
	x = room_width * 0.5;
}
else
{
	x = clamp(x, viewWidthHalf, room_width - viewWidthHalf);
}

if(room_height <= _viewHeight)
{
	y = room_height * 0.5;
}
else
{
	y = clamp(y, viewHeightHalf, room_height - viewHeightHalf);
}

// Apply screen shake as a temporary random offset.
x += random_range(-shakeRemain, shakeRemain);
y += random_range(-shakeRemain, shakeRemain);

// Fade shake back down over its configured duration.
if(shakeLength > 0)
{
	shakeRemain = max(0, shakeRemain - ((1 / shakeLength) * shakeMagnitue));
}
else
{
	shakeRemain = 0;
}

// Move the actual view camera so this controller object's position is centered.
camera_set_view_pos(cam, x - viewWidthHalf, y - viewHeightHalf);
