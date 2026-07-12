// Load shared NPC defaults from oNpcParent first.
event_inherited();

// Maya is the first shopkeeper-style NPC and will later connect to shop dialogue.
displayName = "Maya";
dialogueId = "maya.intro";

// Start her facing left, toward the village center.
direction = 180;

// Short side-to-side pacing route near her shop area.
patrolPoints = [[x, y], [x + 96, y]];
