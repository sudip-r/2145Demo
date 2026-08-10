/// Move story text and handle Skip

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var wrap_w = min(820, gui_w - 120);
var line_gap = 38;

// Clamp unusually long frames so the story cannot jump a large distance.
var dt = min(delta_time / 1000000, 0.05);
story_y -= story_speed * dt;

// Text measurement uses the currently selected draw font.
draw_set_font(fStory);
var story_h = string_height_ext(story_text, line_gap, wrap_w);
draw_set_font(-1);

var skip_x1 = gui_w - 210;
var skip_y1 = gui_h - 80;
var skip_x2 = gui_w - 30;
var skip_y2 = gui_h - 28;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

skip_hovered = point_in_rectangle(
    mx, my,
    skip_x1, skip_y1,
    skip_x2, skip_y2
);

if (input_delay > 0)
{
    input_delay--;
}

var skip_selected =
    input_delay <= 0 &&
    (
        (skip_hovered && mouse_check_button_pressed(mb_left)) ||
        keyboard_check_pressed(vk_escape) ||
        keyboard_check_pressed(vk_enter) ||
        keyboard_check_pressed(vk_space)
    );

var story_finished = (story_y + story_h < -32);

if (!transition_started && (skip_selected || story_finished))
{
    transition_started = true;
    room_goto(rInit);
}