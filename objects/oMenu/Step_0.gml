var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var scale_x = gui_w / 1366;
var scale_y = gui_h / 768;

// Button bounds in the generated artwork.
var button_x1 = 460 * scale_x;
var button_y1 = 578 * scale_y;
var button_x2 = 902 * scale_x;
var button_y2 = 677 * scale_y;

var mouse_x_gui = device_mouse_x_to_gui(0);
var mouse_y_gui = device_mouse_y_to_gui(0);

button_hovered = point_in_rectangle(
    mouse_x_gui,
    mouse_y_gui,
    button_x1,
    button_y1,
    button_x2,
    button_y2
);

var mouse_selected =
    button_hovered &&
    mouse_check_button_pressed(mb_left);

var keyboard_selected =
    keyboard_check_pressed(vk_enter) ||
    keyboard_check_pressed(vk_space);

//Volume controls
// Increase volume.
if (keyboard_check_pressed(vk_up))
{
    global.music_volume = clamp(
        global.music_volume + 0.1,
        0,
        1
    );

    global.music_muted = false;
    audio_sound_gain(
        menu_music_id,
        global.music_volume,
        150
    );
}

// Decrease volume.
if (keyboard_check_pressed(vk_down))
{
    global.music_volume = clamp(
        global.music_volume - 0.1,
        0,
        1
    );

    audio_sound_gain(
        menu_music_id,
        global.music_muted ? 0 : global.music_volume,
        150
    );
}

// M toggles mute.
if (keyboard_check_pressed(ord("M")))
{
    global.music_muted = !global.music_muted;

    audio_sound_gain(
        menu_music_id,
        global.music_muted ? 0 : global.music_volume,
        150
    );
}

if (mouse_selected || keyboard_selected)
{
    if (audio_is_playing(menu_music_id))
    {
        audio_stop_sound(menu_music_id);
    }

    room_goto(rInit);
}