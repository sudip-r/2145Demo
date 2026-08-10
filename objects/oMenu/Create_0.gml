/// Main menu setup

design_w = 1366;
design_h = 768;

menu_items = ["Start", "Options", "Exit"];
menu_selected = 0;
menu_hovered = -1;
options_open = false;
back_hovered = false;

button_x1 = 510;
button_x2 = 856;
button_y = [482, 550, 618];
button_h = 56;

// Preserve the setting if the menu is visited again during this run.
if (!variable_global_exists("music_volume"))
{
    global.music_volume = 0.7;
}

if (!variable_global_exists("music_muted"))
{
    global.music_muted = false;
}

menu_music_id = audio_play_sound(sndIntro, 0, true);

audio_sound_gain(
    menu_music_id,
    global.music_muted ? 0 : global.music_volume,
    0
);

