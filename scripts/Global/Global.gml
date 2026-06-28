#macro FRAME_RATE 60
#macro TILE_SIZE 64
#macro COLLISION_TILE_SIZE 8

// Converts the current direction angle into a sprite row index.
// The modulo wrap keeps 360 degrees mapped back to 0.
#macro CARDINAL_DIRECTION ((round(direction / 90) + 4) mod 4)
#macro ROOM_START rVillage
