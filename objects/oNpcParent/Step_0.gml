// NPCs should stop moving while the global pause flag is active.
if(!global.gamePaused)
{
	// Run the shared idle/patrol behavior for all NPC children.
	NpcStepIdle();
}
