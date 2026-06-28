state = PlayerStateFree; 

collisionMap = layer_tilemap_get_id(layer_get_id("Col"));

image_speed = 0;
hSpeed = 0;
vSpeed = 0;
speedWalk = 4.5;
speedRun = 6.5;
speedPlough = 1.0;
distancePlough = 52;

spritePlough = sPlayerPlough;
spriteWalk = mPlayerWalk;
spriteIdle = mPlayer;
spriteRun = mPlayerWalk;
localFrame = 0;
