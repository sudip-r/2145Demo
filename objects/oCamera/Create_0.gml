/// @description Set up camera

// Store the active view camera. Since this object is persistent, the camera
// handle is refreshed in Step after room changes.
cam = view_camera[0];

// Track the room as well as the camera handle because a persistent camera object
// can enter a new room where GameMaker reuses the same view_camera[0] handle.
currentRoom = room;

// Follow the player object when it exists in the current room.
follow = oPlayer;

// Cache half of the camera view size for centering and room-edge clamping.
viewWidthHalf = camera_get_view_width(cam) * 0.5;
viewHeightHalf = camera_get_view_height(cam) * 0.5;

// Target position starts at the camera controller's room start position.
xTo = xstart;
yTo = ystart;

// The camera snaps to the follow target once after entering a room.
cameraInitialized = false;

// Screen-shake values. shakeRemain is reduced each frame in Step.
shakeLength = 0;
shakeMagnitue = 0;
shakeRemain = 0;
