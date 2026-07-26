// Nothing to draw once the pile has been cleared away.
if(collected) exit;

// Show a "hold to collect" hint only while the player is close enough to act.
if(playerInRange && collectProgress <= 0)
{
	var _hintText = "Hold Ctrl";
	var _hintPadX = 7;
	var _hintW = string_width(_hintText) + (_hintPadX * 2);
	var _hintH = 16;
	var _hintX1 = x - (_hintW * 0.5);
	var _hintY1 = y - (boundsHeight * 0.5) - 24;

	draw_set_alpha(0.9);
	draw_set_color(c_white);
	draw_roundrect(_hintX1, _hintY1, _hintX1 + _hintW, _hintY1 + _hintH, false);
	draw_set_alpha(1);
	draw_set_color(c_black);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(x, _hintY1 + (_hintH * 0.5), _hintText);
}

// Draw a small fill-up progress bar while the player is actively collecting.
if(collectProgress > 0)
{
	var _barWidth = 40;
	var _barHeight = 6;
	var _barX1 = x - (_barWidth * 0.5);
	var _barY1 = y - (boundsHeight * 0.5) - 16;
	var _progressRatio = collectProgress / collectDurationFrames;

	draw_set_alpha(0.85);
	draw_set_color(c_black);
	draw_rectangle(_barX1, _barY1, _barX1 + _barWidth, _barY1 + _barHeight, false);

	draw_set_alpha(1);
	draw_set_color(c_lime);
	draw_rectangle(_barX1, _barY1, _barX1 + (_barWidth * _progressRatio), _barY1 + _barHeight, false);
}

// Restore common draw settings so later draw events are not affected.
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
