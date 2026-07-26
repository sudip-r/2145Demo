// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerUseActiveItem(){
	// Called from the player's own state scripts, so self is always the player.
	var _slot = global.playerInventorySlots[global.playerActiveSlot];

	// Nothing equipped in the active slot, so the action button has nothing to do.
	if(_slot == undefined) return;

	var _itemDef = ItemGetDefinition(_slot.itemId);

	switch(_itemDef.category)
	{
		// Tools (currently just the hoe) trigger the existing plough action.
		case "tool":
			state = PlayerStatePlough;
			moveDistanceRemaining = distancePlough;
			global.playerStrength = max(0, global.playerStrength - strengthCostAction);
			break;

		// Weapons trigger a short attack swing.
		case "weapon":
			state = PlayerStateAttack;
			moveDistanceRemaining = distanceAttack;
			global.playerStrength = max(0, global.playerStrength - strengthCostAction);
			break;

		// Food is eaten immediately instead of starting an action state.
		case "food":
			global.playerHp = min(global.playerHpMax, global.playerHp + _itemDef.restoreHp);
			InventoryConsumeActiveSlot();
			break;
	}
}
