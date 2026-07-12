// Default identity values. Child NPC objects override these in their Create events.
displayName = "Villager";
dialogueId = "villager.default";
placeholderLine = "Dialogue coming soon.";

// Interaction range controls how close the player must be to talk to this NPC.
interactRadius = 64;

// Patrol values define the NPC's simple idle movement route.
patrolSpeed = 0.6;
patrolWait = irandom_range(FRAME_RATE, FRAME_RATE * 2);
patrolIndex = 0;
patrolPoints = [[x, y]];

// NPC animation is advanced manually so it can stay in sync with patrol state.
sprite_index = mPlayerWalk;
image_speed = 0;
localFrame = 0;

// Temporary speech bubble state used until the full dialogue UI exists.
messageText = "";
messageTimer = 0;

// Default facing direction. GameMaker directions use 0=right, 90=up, 180=left, 270=down.
direction = 270;
