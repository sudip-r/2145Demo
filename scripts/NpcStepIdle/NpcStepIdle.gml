// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function NpcStepIdle(){
	// Count down any visible temporary speech bubble.
	if(messageTimer > 0) messageTimer--;
	
	// One or zero patrol points means this NPC should stand still.
	if(array_length(patrolPoints) <= 1)
	{
		NpcAnimateSprite();
		return;
	}
	
	// Wait at the current patrol point before walking to the next one.
	if(patrolWait > 0)
	{
		patrolWait--;
		NpcAnimateSprite();
		return;
	}
	
	// Read the current patrol destination from the NPC's route array.
	var _target = patrolPoints[patrolIndex];
	var _targetX = _target[0];
	var _targetY = _target[1];
	var _distance = point_distance(x, y, _targetX, _targetY);
	
	// Snap exactly onto the target when close enough to avoid tiny drift errors.
	if(_distance <= patrolSpeed)
	{
		x = _targetX;
		y = _targetY;

		// Move to the next route point, wrapping back to the first at the end.
		patrolIndex = (patrolIndex + 1) mod array_length(patrolPoints);

		// Pause for a little while so patrols look like idle behavior, not marching.
		patrolWait = irandom_range(FRAME_RATE, FRAME_RATE * 3);
		localFrame = 0;
	}
	else
	{
		// Face and move toward the patrol target at this NPC's configured speed.
		direction = point_direction(x, y, _targetX, _targetY);
		x += lengthdir_x(patrolSpeed, direction);
		y += lengthdir_y(patrolSpeed, direction);
	}
	
	// Update the displayed sprite frame after movement/wait logic is resolved.
	NpcAnimateSprite();
}
