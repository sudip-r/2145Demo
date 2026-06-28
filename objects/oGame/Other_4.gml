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
