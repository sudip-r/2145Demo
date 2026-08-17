// Read the title-screen request before normal defaults are initialized.
var _shouldLoad =
	variable_global_exists("load_requested") &&
	global.load_requested;

global.load_requested = false;

// Seed GameMaker's random number generator for non-repeatable random values.
randomize();

// Draw this persistent controller after gameplay objects so HUD/dialogue stays on top.
depth = -100000;

// Global pause flag checked by player and other gameplay scripts.
global.gamePaused = false;

// Pause menu state owned by persistent oGame.
pauseItems = ["Resume", "Save Game", "Main Menu"];
pauseSelected = 0;
pauseHovered = -1;
pauseNotice = "";
pauseNoticeTimer = 0;

// Loaded position is applied after the saved room creates oPlayer.
global.pendingLoad = undefined;

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

// Second demo quest: Ama asks the player to clear garbage from the temple grounds.
// It only becomes offerable once every villager has been met.
global.questTempleCleanupActive = false;
global.questTempleCleanupCleared = false;
global.questTempleCleanupComplete = false;
global.questTempleCleanupCompleteTimer = 0;
global.questGarbageTotal = 0;
global.questGarbageCollected = 0;

// Stable IDs of garbage piles that have already been removed.
global.clearedGarbageIds = [];

// Player stats. Strength drains from running/actions below; HP has no drain source yet (added later).
global.playerHp = 100;
global.playerHpMax = 100;
global.playerStrength = 100;
global.playerStrengthMax = 100;

// Set once strength hits 0; blocks running again until strength fully refills,
// so the player gets a clean forced walk instead of flickering between run/walk.
global.playerExhausted = false;

// Starting inventory for testing: one tool, one weapon, and a stack of food.
global.playerActiveSlot = 0;
global.playerInventorySlots = array_create(INVENTORY_SLOT_COUNT, undefined);
global.playerInventorySlots[0] = {itemId: "hoe", count: 1};
global.playerInventorySlots[1] = {itemId: "sword", count: 1};
global.playerInventorySlots[2] = {itemId: "bread", count: 3};

// Create one persistent camera controller before moving into the start room.
global.iCamera = instance_create_layer(0, 0, layer, oCamera);

// Load requests replace the defaults above, then request the saved room.
// A missing, incompatible, or corrupt save safely starts a new game.
if(_shouldLoad)
{
	if(!SaveGameLoad())
	{
		room_goto(ROOM_START);
	}
}
else
{
	room_goto(ROOM_START);
}
