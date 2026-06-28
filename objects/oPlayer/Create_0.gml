// Start the player in the normal movement state.
state = PlayerStateFree; 

// Cache the collision tilemap so movement scripts can query blocked tiles.
collisionMap = layer_tilemap_get_id(layer_get_id("Col"));

// Sprite animation is advanced manually with localFrame.
image_speed = 0;
localFrame = 0;

// Movement speeds for each player action.
hSpeed = 0;
vSpeed = 0;
speedWalk = 4.5;
speedRun = 6.5;
speedPlough = 1.0;
distancePlough = 52;

// Sprites used by the player state scripts.
spritePlough = sPlayerPlough;
spriteWalk = mPlayerWalk;
spriteIdle = mPlayer;
spriteRun = mPlayerWalk;
