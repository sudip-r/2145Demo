/// @description Update camera

// Rebind to the current room's view camera.
// oCamera is persistent, so view_camera[0] can change after room_goto().
if(cam != view_camera[0])
{
	cam = view_camera[0];
	viewWidthHalf = camera_get_view_width(cam) * 0.5;
	viewHeightHalf = camera_get_view_height(cam) * 0.5;
	cameraInitialized = false;
}

// Update destination to the follow target's position.
if (instance_exists(follow))
{
	xTo = follow.x;
	yTo = follow.y;
	
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
x = clamp(x, viewWidthHalf, room_width - viewWidthHalf);
y = clamp(y, viewHeightHalf, room_height - viewHeightHalf);

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
