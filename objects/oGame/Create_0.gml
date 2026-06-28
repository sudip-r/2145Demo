// Seed GameMaker's random number generator for non-repeatable random values.
randomize();

// Global pause flag checked by player and other gameplay scripts.
global.gamePaused = false;

// Create one persistent camera controller before moving into the start room.
global.iCamera = instance_create_layer(0, 0, layer, oCamera);

// Leave the init room and start the playable room.
room_goto(ROOM_START);
