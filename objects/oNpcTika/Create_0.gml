// Load shared NPC defaults from oNpcParent first.
event_inherited();

// Tika is the roaming guide/runner NPC for early village orientation.
displayName = "Tika";
dialogueId = "tika.intro";

// Start facing right, then let patrol movement update direction naturally.
direction = 0;
patrolSpeed = 0.8;

// Looping rectangular route that makes Tika feel more active than other NPCs.
patrolPoints = [[x, y], [x + 128, y], [x + 128, y - 64], [x, y - 64]];
