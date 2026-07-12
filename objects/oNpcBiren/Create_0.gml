// Load shared NPC defaults from oNpcParent first.
event_inherited();

// Biren represents the farm/carpentry side of the village.
displayName = "Biren";
dialogueId = "biren.intro";

// Start him facing upward, as if looking over the farm edge.
direction = 90;

// Small vertical route to make the farm area feel occupied.
patrolPoints = [[x, y], [x, y + 96]];
