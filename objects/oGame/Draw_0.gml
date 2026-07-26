/// @description Draw dialogue UI

// Only draw the panel while an NPC dialogue is active.
if(global.dialogueActive)
{
	// Draw in world coordinates, anchored to the current camera view.
	var _cam = view_camera[0];
	var _viewX = camera_get_view_x(_cam);
	var _viewY = camera_get_view_y(_cam);
	var _viewW = camera_get_view_width(_cam);
	var _viewH = camera_get_view_height(_cam);
	
	// Keep the dialogue box inside the visible camera area.
	var _margin = 24;
	var _boxH = 96;
	var _boxX1 = _viewX + _margin;
	var _boxY1 = _viewY + _viewH - _boxH - _margin;
	var _boxX2 = _viewX + _viewW - _margin;
	var _boxY2 = _viewY + _viewH - _margin;
	
	// Draw the main dark panel and a thin readable border.
	draw_set_alpha(0.92);
	draw_set_color(c_black);
	draw_roundrect(_boxX1, _boxY1, _boxX2, _boxY2, false);
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_roundrect(_boxX1, _boxY1, _boxX2, _boxY2, true);
	
	// Draw the speaker name as a small label at the top of the panel.
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(_boxX1 + 16, _boxY1 + 10, global.dialogueSpeaker);
	
	// Draw only the revealed part of the current line for the typewriter effect.
	var _visibleText = string_copy(global.dialogueText, 1, floor(global.dialogueVisibleChars));
	draw_text_ext(_boxX1 + 16, _boxY1 + 36, _visibleText, 18, (_boxX2 - _boxX1) - 32);
	
	// Build a small progress hint so multi-line conversations are easy to read.
	var _lineProgress = string(global.dialogueLineIndex + 1) + "/" + string(array_length(global.dialogueLines));
	var _isLineComplete = (global.dialogueVisibleChars >= string_length(global.dialogueText));
	var _continueAction = "Skip";
	if(_isLineComplete) _continueAction = "Next";
	var _continueHint = _lineProgress + "  Space: " + _continueAction;
	
	// Draw a small continue hint in the bottom-right corner.
	draw_set_halign(fa_right);
	draw_set_valign(fa_bottom);
	draw_text(_boxX2 - 16, _boxY2 - 10, _continueHint);
	
	// Restore default draw settings for anything drawn after this object.
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	draw_set_alpha(1);
}
else
{
	// Draw the lightweight quest tracker only while dialogue is not covering the screen.
	var _camQuest = view_camera[0];
	var _questX = camera_get_view_x(_camQuest) + 24;
	var _questY = camera_get_view_y(_camQuest) + 24;
	var _questW = 220;
	var _questH = 54;
	
	// Show active progress until all villagers have been met.
	if(!global.questMeetVillagersComplete)
	{
		var _metCount = QuestGetMeetVillagersCount();
		var _questText = "Meet the Villagers";
		var _progressText = string(_metCount) + "/" + string(global.questMeetVillagersTotal) + " introductions";
		
		draw_set_alpha(0.82);
		draw_set_color(c_black);
		draw_roundrect(_questX, _questY, _questX + _questW, _questY + _questH, false);
		draw_set_alpha(1);
		draw_set_color(c_white);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text(_questX + 12, _questY + 8, _questText);
		draw_text(_questX + 12, _questY + 30, _progressText);
	}
	else if(global.questMeetVillagersCompleteTimer > 0)
	{
		// Show a short completion toast once the objective is done.
		draw_set_alpha(0.9);
		draw_set_color(c_black);
		draw_roundrect(_questX, _questY, _questX + _questW, _questY + _questH, false);
		draw_set_alpha(1);
		draw_set_color(c_lime);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text(_questX + 12, _questY + 8, "Quest Complete");
		draw_set_color(c_white);
		draw_text(_questX + 12, _questY + 30, "Meet the Villagers");
	}

	// Draw the temple cleanup tracker underneath, once Ama has handed out the quest.
	if(global.questTempleCleanupActive)
	{
		var _templeY = _questY + _questH + 12;

		if(!global.questTempleCleanupComplete)
		{
			var _templeText = "Temple Cleanup";
			var _templeProgress = string(global.questGarbageCollected) + "/" + string(global.questGarbageTotal) + " garbage cleared";

			draw_set_alpha(0.82);
			draw_set_color(c_black);
			draw_roundrect(_questX, _templeY, _questX + _questW, _templeY + _questH, false);
			draw_set_alpha(1);
			draw_set_color(c_white);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_text(_questX + 12, _templeY + 8, _templeText);
			draw_text(_questX + 12, _templeY + 30, _templeProgress);
		}
		else if(global.questTempleCleanupCompleteTimer > 0)
		{
			// Show a short completion toast once Ama has thanked the player.
			draw_set_alpha(0.9);
			draw_set_color(c_black);
			draw_roundrect(_questX, _templeY, _questX + _questW, _templeY + _questH, false);
			draw_set_alpha(1);
			draw_set_color(c_lime);
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			draw_text(_questX + 12, _templeY + 8, "Quest Complete");
			draw_set_color(c_white);
			draw_text(_questX + 12, _templeY + 30, "Temple Cleanup");
		}
	}

	// Restore draw state after the quest tracker.
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	draw_set_alpha(1);

	// Draw the player HUD (HP, Strength, inventory hotbar) anchored to the bottom-left of the view.
	var _hudMargin = 24;
	var _hudX = camera_get_view_x(_camQuest) + _hudMargin;
	var _hudBottom = camera_get_view_y(_camQuest) + camera_get_view_height(_camQuest) - _hudMargin;

	var _barWidth = 160;
	var _barHeight = 14;
	var _slotSize = 40;
	var _slotGap = 6;

	var _strengthBarY = _hudBottom - _barHeight;
	var _hpBarY = _strengthBarY - _barHeight - 6;
	var _hotbarY = _hpBarY - _slotSize - 10;

	// HP bar background and red fill.
	draw_set_alpha(0.85);
	draw_set_color(c_black);
	draw_rectangle(_hudX, _hpBarY, _hudX + _barWidth, _hpBarY + _barHeight, false);
	draw_set_alpha(1);
	draw_set_color(c_red);
	draw_rectangle(_hudX, _hpBarY, _hudX + (_barWidth * (global.playerHp / global.playerHpMax)), _hpBarY + _barHeight, false);
	draw_set_color(c_white);
	draw_rectangle(_hudX, _hpBarY, _hudX + _barWidth, _hpBarY + _barHeight, true);

	// Strength bar background and yellow fill.
	draw_set_alpha(0.85);
	draw_set_color(c_black);
	draw_rectangle(_hudX, _strengthBarY, _hudX + _barWidth, _strengthBarY + _barHeight, false);
	draw_set_alpha(1);
	draw_set_color(c_yellow);
	draw_rectangle(_hudX, _strengthBarY, _hudX + (_barWidth * (global.playerStrength / global.playerStrengthMax)), _strengthBarY + _barHeight, false);
	draw_set_color(c_white);
	draw_rectangle(_hudX, _strengthBarY, _hudX + _barWidth, _strengthBarY + _barHeight, true);

	// Inventory hotbar: one box per slot, highlighting the active slot and showing item/count.
	for(var _slotIndex = 0; _slotIndex < INVENTORY_SLOT_COUNT; _slotIndex++)
	{
		var _slotX = _hudX + (_slotIndex * (_slotSize + _slotGap));
		var _isActiveSlot = (_slotIndex == global.playerActiveSlot);

		draw_set_alpha(0.85);
		draw_set_color(c_black);
		draw_rectangle(_slotX, _hotbarY, _slotX + _slotSize, _hotbarY + _slotSize, false);

		draw_set_alpha(1);
		draw_set_color(_isActiveSlot ? c_yellow : c_white);
		draw_rectangle(_slotX, _hotbarY, _slotX + _slotSize, _hotbarY + _slotSize, true);

		var _slot = global.playerInventorySlots[_slotIndex];

		if(_slot != undefined)
		{
			var _itemDef = ItemGetDefinition(_slot.itemId);

			draw_set_color(c_white);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_text(_slotX + (_slotSize * 0.5), _hotbarY + (_slotSize * 0.5) - 6, string_char_at(_itemDef.displayName, 1));

			// Only show a count for stackable items carrying more than one.
			if(_slot.count > 1)
			{
				draw_text(_slotX + (_slotSize * 0.5), _hotbarY + (_slotSize * 0.5) + 10, string(_slot.count));
			}
		}
	}

	// Restore draw state after the HUD.
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	draw_set_alpha(1);
}
