var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var volume_text;

// Stretch the 16:9 artwork to the current GUI surface.
draw_sprite_stretched(
    sMenuScreen,
    0,
    0,
    0,
    gui_w,
    gui_h
);

// Subtle button feedback.
if (button_hovered)
{
    var scale_x = gui_w / 1366;
    var scale_y = gui_h / 768;

    draw_set_alpha(0.12);
    draw_set_color(c_yellow);

    draw_rectangle(
        460 * scale_x,
        578 * scale_y,
        902 * scale_x,
        677 * scale_y,
        false
    );

    draw_set_alpha(1);
    draw_set_color(c_white);
}


if (global.music_muted)
{
    volume_text = "MUTED  [M]";
}
else
{
    volume_text =
        "VOLUME: " +
        string(round(global.music_volume * 100)) +
        "%  [UP/DOWN]  [M]";
}

draw_set_halign(fa_right);
draw_set_valign(fa_bottom);

// Small shadow for readability.
draw_set_color(c_black);
draw_text(gui_w - 23, gui_h - 23, volume_text);

draw_set_color(c_white);
draw_text(gui_w - 24, gui_h - 24, volume_text);

// Restore drawing defaults.
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);