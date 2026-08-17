/// Draw main menu and modal Options panel

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var scale_x = gui_w / design_w;
var scale_y = gui_h / design_h;

draw_sprite_stretched(sMenuBackground, 0, 0, 0, gui_w, gui_h);

draw_set_font(fMenu);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

for (var i = 0; i < array_length(menu_items); i++)
{
    var x1 = button_x1 * scale_x;
    var y1 = button_y[i] * scale_y;
    var x2 = button_x2 * scale_x;
    var y2 = (button_y[i] + button_h) * scale_y;
    var active = (i == menu_selected);
    var enabled = (i != 1) || load_available;

    draw_set_alpha(active ? 0.92 : 0.76);
    draw_set_color(c_black);
    draw_roundrect(x1, y1, x2, y2, false);

    draw_set_alpha(1);

    if(!enabled)
    {
        draw_set_color(c_gray);
    }
    else
    {
        draw_set_color(active ? c_yellow : c_white);
    }

    draw_roundrect(x1, y1, x2, y2, true);
    draw_text((x1 + x2) * 0.5, (y1 + y2) * 0.5, menu_items[i]);
}

if (options_open)
{
    // Dim the menu behind the modal so Options clearly owns the input.
    draw_set_alpha(0.55);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);

    var panel_x1 = 433 * scale_x;
    var panel_y1 = 245 * scale_y;
    var panel_x2 = 933 * scale_x;
    var panel_y2 = 523 * scale_y;

    draw_set_alpha(0.96);
    draw_set_color(c_black);
    draw_roundrect(panel_x1, panel_y1, panel_x2, panel_y2, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_roundrect(panel_x1, panel_y1, panel_x2, panel_y2, true);

    draw_set_font(fStory);
    draw_text(gui_w * 0.5, 285 * scale_y, "OPTIONS");

    var volume_label = global.music_muted
        ? "Volume: Muted"
        : "Volume: " + string(round(global.music_volume * 100)) + "%";
    draw_text(gui_w * 0.5, 325 * scale_y, volume_label);

    // Volume track and knob.
    var slider_x1 = 533 * scale_x;
    var slider_x2 = 833 * scale_x;
    var slider_y = 365 * scale_y;
    var knob_x = lerp(slider_x1, slider_x2, global.music_volume);

    draw_set_color(c_gray);
    draw_rectangle(slider_x1, slider_y - 4, slider_x2, slider_y + 4, false);
    draw_set_color(c_yellow);
    draw_rectangle(slider_x1, slider_y - 4, knob_x, slider_y + 4, false);
    draw_circle(knob_x, slider_y, 12 * min(scale_x, scale_y), false);

    var bx1 = 590 * scale_x;
    var by1 = 435 * scale_y;
    var bx2 = 776 * scale_x;
    var by2 = 487 * scale_y;

    draw_set_color(back_hovered ? c_yellow : c_white);
    draw_roundrect(bx1, by1, bx2, by2, true);
    draw_text((bx1 + bx2) * 0.5, (by1 + by2) * 0.5, "Back");
    draw_text(gui_w * 0.5, 505 * scale_y, "Left/Right: Adjust    M: Mute    Esc: Back");
}

if(menu_notice_timer > 0)
{
    draw_set_font(fStory);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(gui_w * 0.5, gui_h - 34, menu_notice);
}

// Restore defaults for later Draw GUI events.
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(-1);
