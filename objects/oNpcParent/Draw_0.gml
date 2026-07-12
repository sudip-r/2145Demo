// Draw the NPC sprite first, then layer labels/prompts above it.
draw_self();

// Name labels help distinguish placeholder NPC sprites until real character art exists.
var _drawNameLabel = false;
var _drawInteractPrompt = false;

// Only show labels during normal gameplay so they do not compete with the dialogue box.
var _dialogueOpen = false;
if(variable_global_exists("dialogueActive"))
{
	_dialogueOpen = global.dialogueActive;
}

// Check the player distance before doing interaction-target work.
if(!_dialogueOpen && instance_exists(oPlayer))
{
	// Use the first player instance as the interaction source.
	var _player = instance_find(oPlayer, 0);
	var _playerDistance = point_distance(x, y, _player.x, _player.y);
	
	// Show the NPC's name when the player is close enough to care who they are.
	_drawNameLabel = (_playerDistance <= 160);
	
	// Ask the same helper used by the player state which NPC Space would talk to.
	var _interactTarget = NpcFindInteractTarget(_player);
	_drawInteractPrompt = (_interactTarget == id);
}

// Draw a compact name tag above nearby NPCs.
if(_drawNameLabel)
{
	// The label sits above the sprite using the sprite collision box as a rough height guide.
	var _labelText = displayName;
	var _labelPadX = 6;
	var _labelPadY = 3;
	var _labelW = string_width(_labelText) + (_labelPadX * 2);
	var _labelH = 16;
	var _labelX1 = x - (_labelW * 0.5);
	var _labelY1 = y - sprite_get_bbox_bottom(sprite_index) - 28;
	var _labelX2 = _labelX1 + _labelW;
	var _labelY2 = _labelY1 + _labelH;
	
	// Draw a dark background so white label text reads against grass and tree tiles.
	draw_set_alpha(0.82);
	draw_set_color(c_black);
	draw_roundrect(_labelX1, _labelY1, _labelX2, _labelY2, false);
	
	// Center the NPC's display name in the tag.
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(x, _labelY1 + (_labelH * 0.5), _labelText);
}

// Draw an interaction hint only over the NPC currently selected by facing/range logic.
if(_drawInteractPrompt)
{
	var _promptText = "Space";
	var _promptPadX = 7;
	var _promptW = string_width(_promptText) + (_promptPadX * 2);
	var _promptH = 16;
	var _promptX1 = x - (_promptW * 0.5);
	var _promptY1 = y - sprite_get_bbox_bottom(sprite_index) - 48;
	var _promptX2 = _promptX1 + _promptW;
	var _promptY2 = _promptY1 + _promptH;
	
	// Use a light prompt so it stands apart from the darker name label.
	draw_set_alpha(0.9);
	draw_set_color(c_white);
	draw_roundrect(_promptX1, _promptY1, _promptX2, _promptY2, false);
	draw_set_alpha(1);
	draw_set_color(c_black);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(x, _promptY1 + (_promptH * 0.5), _promptText);
}

// A positive timer means the player recently interacted with this NPC.
if(messageTimer > 0)
{
	// Calculate bubble padding and width from the current message text.
	var _padX = 8;
	var _padY = 5;
	var _textWidth = string_width(messageText);
	var _bubbleWidth = _textWidth + (_padX * 2);
	var _bubbleHeight = 20;

	// Position the bubble centered above the NPC sprite.
	var _bubbleX = x - (_bubbleWidth * 0.5);
	var _bubbleY = y - sprite_get_bbox_bottom(sprite_index) - 32;
	
	// Draw a dark rounded background so the text is readable over village tiles.
	draw_set_alpha(0.92);
	draw_set_color(c_black);
	draw_roundrect(_bubbleX, _bubbleY, _bubbleX + _bubbleWidth, _bubbleY + _bubbleHeight, false);

	// Draw the message centered inside the bubble.
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(x, _bubbleY + (_bubbleHeight * 0.5), messageText);

	// Restore common draw settings so later draw events are not affected.
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
}

// Restore common draw settings after labels, prompts, or temporary bubbles.
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
