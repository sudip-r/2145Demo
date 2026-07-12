// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerStateRun(){
	// Stop running when shift is released or movement input stops.
	if(!keyRun || inputMagnitude == 0)
	{
		state = PlayerStateFree;
		PlayerStateFree();
		exit;
	}
	
	// Convert input direction into run-speed movement.
	hSpeed = lengthdir_x(inputMagnitude * speedRun, inputDirection);
	vSpeed = lengthdir_y(inputMagnitude * speedRun, inputDirection);

	PlayerCollision();

	// Choose run sprite while moving, otherwise fall back to idle.
	var _oldSprite = sprite_index;

	if(inputMagnitude != 0)
	{
		direction = inputDirection;
		sprite_index = spriteRun;
	} else sprite_index = spriteIdle;

	// Restart animation when changing between movement and idle sprites.
	if(_oldSprite != sprite_index) localFrame = 0;

	PlayerAnimateSprite();

	// Space first talks to nearby NPCs, then falls back to the plough action.
	if(keyActivate)
	{
		// Search in front of the moving player for an NPC interaction target.
		var _npcTarget = NpcFindInteractTarget(id);

		// If an NPC was found, leave run state and trigger their placeholder interaction.
		if(_npcTarget != noone)
		{
			state = PlayerStateFree;
			NpcInteract(_npcTarget, id);
			exit;
		}

		// No NPC interaction was found, so Space keeps its original plough behavior.
		state = PlayerStatePlough;
		moveDistanceRemaining = distancePlough;
	}
}
