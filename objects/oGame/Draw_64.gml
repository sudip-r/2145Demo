/// @description Draw pause menu above the gameplay view

if(!global.gamePaused || global.dialogueActive)
{
	exit;
}

var _guiW = display_get_gui_width();
var _guiH = display_get_gui_height();
var _centerX = _guiW * 0.5;
var _centerY = _guiH * 0.5;
var _panelX1 = _centerX - 230;
var _panelY1 = _centerY - 180;
var _panelX2 = _centerX + 230;
var _panelY2 = _centerY + 190;
var _buttonX1 = _centerX - 150;
var _buttonX2 = _centerX + 150;
var _buttonStartY = _centerY - 72;
var _buttonH = 50;
var _buttonGap = 14;

// Darken the running game behind the modal panel.
draw_set_alpha(0.62);
draw_set_color(c_black);
draw_rectangle(0, 0, _guiW, _guiH, false);

draw_set_alpha(0.96);
draw_set_color(c_black);
draw_roundrect(_panelX1, _panelY1, _panelX2, _panelY2, false);

draw_set_alpha(1);
draw_set_color(c_white);
draw_roundrect(_panelX1, _panelY1, _panelX2, _panelY2, true);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fMenu);
draw_text(_centerX, _panelY1 + 52, "PAUSED");

draw_set_font(fStory);

for(var _i = 0; _i < array_length(pauseItems); _i++)
{
	var _y1 = _buttonStartY + (_i * (_buttonH + _buttonGap));
	var _y2 = _y1 + _buttonH;
	var _active = (_i == pauseSelected);

	draw_set_alpha(_active ? 0.92 : 0.72);
	draw_set_color(c_black);
	draw_roundrect(_buttonX1, _y1, _buttonX2, _y2, false);

	draw_set_alpha(1);
	draw_set_color(_active ? c_yellow : c_white);
	draw_roundrect(_buttonX1, _y1, _buttonX2, _y2, true);
	draw_text(_centerX, (_y1 + _y2) * 0.5, pauseItems[_i]);
}

if(pauseNoticeTimer > 0)
{
	draw_set_color(c_lime);
	draw_text(_centerX, _panelY2 - 30, pauseNotice);
}
else
{
	draw_set_color(c_gray);
	draw_text(_centerX, _panelY2 - 30, "Esc: Resume");
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);
