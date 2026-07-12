// Load shared NPC defaults from oNpcParent first.
event_inherited();

// Ama is the elder/lore anchor who stays near the central landmark.
displayName = "Ama";
dialogueId = "ama.intro";

// Start her facing downward toward the player approach.
direction = 270;

// A speed of 0 and one patrol point makes Ama a stationary NPC.
patrolSpeed = 0;
patrolPoints = [[x, y]];
