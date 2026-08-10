/// Scrolling prologue setup

story_text =
    "A few weeks have passed since Aarav lost his parent."
    + "\n\n"
    + "The village still stands, but it no longer feels like the place he remembers. Some houses are damaged. Fields have been neglected. Food is running low, and Bijaya's soldiers occasionally enter the village to collect supplies for themselves."
    + "\n\n"
    + "Aarav has learned not to be noticed."
	+ "\n\n"
    + "Every morning, he wakes in the small house that now feels too large for him, straps his father's old sword to his back, and walks into the village."
	+ "\n\n"
    + "He cannot fight the soldiers."
	+ "\n\n"
    + "Not yet.";

// Pixels per second. Try values between 30 and 50.
story_speed = 38;

// Begin with the complete text block below the bottom edge.
story_y = display_get_gui_height() + 32;

// Prevent the Enter/Space used on Start from immediately skipping this room.
input_delay = 12;
skip_hovered = false;
transition_started = false;

menu_music_id = audio_play_sound(sndStory, 0, true);

audio_sound_gain(
    menu_music_id,
    global.music_muted ? 0 : global.music_volume,
    0
);