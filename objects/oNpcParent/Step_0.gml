// NPCs should stop moving while the global pause flag is active.
if(!global.gamePaused)
{
	// Run the shared idle/patrol behavior for all NPC children.
	NpcStepIdle();
}

// Keep draw order tied to the NPC's feet after any patrol movement.
// This lets the player stand in front of an NPC when the player's y is lower on screen.
depth = -floor(y);
