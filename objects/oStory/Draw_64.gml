/// Draw scrolling story and fixed Skip control

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var wrap_w = min(820, gui_w - 120);
var line_gap = 38;

draw_clear(c_black);

// If a story background sprite was created, replace draw_clear above with:
// draw_sprite_stretched(sStoryBackground, 0, 0, 0, gui_w, gui_h);

draw_set_font(fStory);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text_ext(gui_w * 0.5, story_y, story_text, line_gap, wrap_w);

// Skip remains stationary while the story scrolls behind it.
var skip_x1 = gui_w - 210;
var skip_y1 = gui_h - 80;
var skip_x2 = gui_w - 30;
var skip_y2 = gui_h - 28;

draw_set_alpha(0.82);
draw_set_color(c_black);
draw_roundrect(skip_x1, skip_y1, skip_x2, skip_y2, false);
draw_set_alpha(1);
draw_set_color(skip_hovered ? c_yellow : c_white);
draw_roundrect(skip_x1, skip_y1, skip_x2, skip_y2, true);
draw_set_valign(fa_middle);
draw_text((skip_x1 + skip_x2) * 0.5, (skip_y1 + skip_y2) * 0.5, "Skip");

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);