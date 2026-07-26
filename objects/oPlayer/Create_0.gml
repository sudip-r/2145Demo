// Start the player in the normal movement state.
state = PlayerStateFree; 

// Cache the collision tilemap so movement scripts can query blocked tiles.
// If a test room has no Col layer, movement should still work without crashing.
collisionMap = noone;
if(layer_exists("Col"))
{
	collisionMap = layer_tilemap_get_id(layer_get_id("Col"));
}

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

// Attack (weapon) action timing, mirroring the plough action above.
speedAttack = 1.6;
distanceAttack = 40;

// Strength (stamina) tuning: running and tool/weapon use both cost strength.
strengthDrainRun = 0.15;
strengthRegenPerFrame = 0.1;
strengthCostAction = 8;

// Sprites used by the player state scripts.
spritePlough = sPlayerPlough;
spriteWalk = sPlayerWalk;
spriteIdle = sPlayer;
spriteRun = sPlayerWalk;
