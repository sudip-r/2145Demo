/// Main menu input

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var scale_x = gui_w / design_w;
var scale_y = gui_h / design_h;

// Convert the actual GUI mouse position back into the 1366 x 768 design space.
var mx = device_mouse_x_to_gui(0) / scale_x;
var my = device_mouse_y_to_gui(0) / scale_y;

if (options_open)
{
    // Slider bounds in design space.
    var slider_x1 = 533;
    var slider_x2 = 833;
    var slider_y1 = 345;
    var slider_y2 = 385;

    var back_x1 = 590;
    var back_y1 = 435;
    var back_x2 = 776;
    var back_y2 = 487;

    back_hovered = point_in_rectangle(
        mx, my,
        back_x1, back_y1,
        back_x2, back_y2
    );

    // Click or drag anywhere on the slider track.
    if (mouse_check_button(mb_left) &&
        point_in_rectangle(mx, my, slider_x1, slider_y1, slider_x2, slider_y2))
    {
        global.music_volume = clamp(
            (mx - slider_x1) / (slider_x2 - slider_x1),
            0,
            1
        );

        global.music_muted = false;
        audio_sound_gain(menu_music_id, global.music_volume, 100);
    }

    if (keyboard_check_pressed(vk_left))
    {
        global.music_volume = max(0, global.music_volume - 0.1);
        global.music_muted = false;
        audio_sound_gain(menu_music_id, global.music_volume, 100);
    }

    if (keyboard_check_pressed(vk_right))
    {
        global.music_volume = min(1, global.music_volume + 0.1);
        global.music_muted = false;
        audio_sound_gain(menu_music_id, global.music_volume, 100);
    }

    if (keyboard_check_pressed(ord("M")))
    {
        global.music_muted = !global.music_muted;
        audio_sound_gain(
            menu_music_id,
            global.music_muted ? 0 : global.music_volume,
            100
        );
    }

    // The modal consumes input; underlying menu items cannot activate.
    if ((back_hovered && mouse_check_button_pressed(mb_left)) ||
        keyboard_check_pressed(vk_escape))
    {
        options_open = false;
    }

    exit;
}

// Find which menu item is under the mouse.
menu_hovered = -1;

for (var i = 0; i < array_length(menu_items); i++)
{
    if (point_in_rectangle(
        mx, my,
        button_x1, button_y[i],
        button_x2, button_y[i] + button_h
    ))
    {
        menu_hovered = i;
        menu_selected = i;
    }
}

// Keyboard navigation.
if (keyboard_check_pressed(vk_up))
{
    menu_selected = (menu_selected - 1 + array_length(menu_items))
        mod array_length(menu_items);
}

if (keyboard_check_pressed(vk_down))
{
    menu_selected = (menu_selected + 1)
        mod array_length(menu_items);
}

var mouse_selected =
    menu_hovered != -1 &&
    mouse_check_button_pressed(mb_left);

var keyboard_selected =
    keyboard_check_pressed(vk_enter) ||
    keyboard_check_pressed(vk_space);

if (mouse_selected || keyboard_selected)
{
    switch (menu_selected)
    {
        case 0: // Start
            room_goto(rStory);
            break;

        case 1: // Options
            options_open = true;
            break;

        case 2: // Exit
            game_end();
            break;
    }
}