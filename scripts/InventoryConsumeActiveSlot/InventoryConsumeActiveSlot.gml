// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function InventoryConsumeActiveSlot(){
	var _slotIndex = global.playerActiveSlot;
	var _slot = global.playerInventorySlots[_slotIndex];

	if(_slot == undefined) return;

	_slot.count -= 1;

	// Remove the item entirely once the stack is empty.
	if(_slot.count <= 0)
	{
		global.playerInventorySlots[_slotIndex] = undefined;
	}
}
