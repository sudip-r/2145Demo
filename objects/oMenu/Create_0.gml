button_hovered = false;

// Preserve the player's setting if the menu is opened again.
if (!variable_global_exists("music_volume"))
{
    global.music_volume = 0.7;
}

if (!variable_global_exists("music_muted"))
{
    global.music_muted = false;
}

// Priority 0, looping enabled.
menu_music_id = audio_play_sound(sndIntro, 0, true);

var initial_gain = global.music_muted
    ? 0
    : global.music_volume;

audio_sound_gain(menu_music_id, initial_gain, 0);