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
	
	// Restore draw state after the quest tracker.
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	draw_set_alpha(1);
}
