// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerStateFree(){
	// Holding run while moving immediately hands control to the run state.
	if(keyRun && inputMagnitude != 0)
	{
		state = PlayerStateRun;
		PlayerStateRun();
		exit;
	}

	// Convert input direction into walk-speed movement.
	hSpeed = lengthdir_x(inputMagnitude * speedWalk, inputDirection);
	vSpeed = lengthdir_y(inputMagnitude * speedWalk, inputDirection);

	PlayerCollision();

	// Choose idle or walk sprite based on whether the player is moving.
	var _oldSprite = sprite_index;

	if(inputMagnitude != 0)
	{
		direction = inputDirection;
		sprite_index = spriteWalk;
	} else sprite_index = spriteIdle;

	// Restart animation when changing between idle and walk sprites.
	if(_oldSprite != sprite_index) localFrame = 0;

	PlayerAnimateSprite();

	// Space first talks to nearby NPCs, then falls back to the plough action.
	if(keyActivate)
	{
		// Search in front of the player for an NPC interaction target.
		var _npcTarget = NpcFindInteractTarget(id);

		// If an NPC was found, trigger their placeholder interaction and stop here.
		if(_npcTarget != noone)
		{
			NpcInteract(_npcTarget, id);
			exit;
		}

		// No NPC interaction was found, so Space keeps its original plough behavior.
		state = PlayerStatePlough;
		moveDistanceRemaining = distancePlough;
	}

}
