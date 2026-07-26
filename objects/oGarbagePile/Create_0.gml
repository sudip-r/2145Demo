// A garbage pile is cleared by holding the collect key while standing nearby.
// GarbageSpawnPiles() overwrites the values below right after creating this instance.
collected = false;
collectProgress = 0;
collectDurationFrames = FRAME_RATE * 3;

// Tilemap id and tile cells this pile erases from the Garbage layer once collected.
garbageTilemap = noone;
tileCellsX = [];
tileCellsY = [];

// World-space size of this pile's tile cluster, used to place UI above it.
boundsWidth = TILE_SIZE;
boundsHeight = TILE_SIZE;
collectRadius = 64;

// True while the player is close enough to collect, read by the Draw event.
playerInRange = false;
