// Nothing left to do once this pile has already been cleared.
if(collected) exit;

// No player in the room means no one can be collecting garbage.
if(!instance_exists(oPlayer))
{
	playerInRange = false;
	exit;
}

var _player = instance_find(oPlayer, 0);
playerInRange = (point_distance(x, y, _player.x, _player.y) <= collectRadius);

// Hold Ctrl (oPlayer's item/collect key) while in range to fill the progress bar.
var _collecting = playerInRange && keyboard_check(vk_control) && !global.gamePaused && !global.dialogueActive;

if(_collecting)
{
	collectProgress++;

	if(collectProgress >= collectDurationFrames)
	{
		// Erase every tile that belongs to this pile so the art disappears with it.
		var _cellCount = array_length(tileCellsX);
		for(var _i = 0; _i < _cellCount; _i++)
		{
			tilemap_set(garbageTilemap, 0, tileCellsX[_i], tileCellsY[_i]);
		}

		collected = true;
		global.questGarbageCollected++;

		if(!SaveArrayContains(global.clearedGarbageIds, saveId))
		{
			array_push(global.clearedGarbageIds, saveId);
		}

		// All piles cleared - the quest giver has a thank-you waiting on the next chat.
		if(global.questGarbageCollected >= global.questGarbageTotal)
		{
			global.questTempleCleanupCleared = true;
		}
	}
}
else
{
	// Stepping away or letting go of the key drains progress instead of keeping it forever.
	collectProgress = max(0, collectProgress - 2);
}
