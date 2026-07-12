// Seed GameMaker's random number generator for non-repeatable random values.
randomize();

// Global pause flag checked by player and other gameplay scripts.
global.gamePaused = false;

// Dialogue globals are initialized here because oGame persists across rooms.
global.dialogueActive = false;
global.dialoguePreviousPaused = false;
global.dialogueSpeaker = "";
global.dialogueText = "";
global.dialogueId = "";
global.dialogueLines = [];
global.dialogueLineIndex = 0;
global.dialogueInputDelay = 0;

// Typewriter values control how much of the current dialogue line is visible.
global.dialogueVisibleChars = 0;
global.dialogueTextSpeed = 1.25;

// This map remembers which dialogue ids have already shown their intro lines.
global.dialogueSeen = ds_map_create();

// First demo quest: encourage the player to speak with every current villager.
global.questMeetVillagersMet = ds_map_create();
global.questMeetVillagersTotal = 4;
global.questMeetVillagersComplete = false;
global.questMeetVillagersCompleteTimer = 0;

// Create one persistent camera controller before moving into the start room.
global.iCamera = instance_create_layer(0, 0, layer, oCamera);

// Leave the init room and start the playable room.
room_goto(ROOM_START);
