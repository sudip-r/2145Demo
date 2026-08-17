#macro SAVE_FILE_NAME "savegame.json"
#macro SAVE_FORMAT_VERSION 1

/// @function SaveGameExists()
/// @description Returns true when the single save slot exists.
function SaveGameExists()
{
	return file_exists(SAVE_FILE_NAME);
}

/// @function SaveArrayContains(array, value)
/// @description Compatibility helper used for stable world-object IDs.
function SaveArrayContains(_array, _value)
{
	for(var _i = 0; _i < array_length(_array); _i++)
	{
		if(_array[_i] == _value)
		{
			return true;
		}
	}

	return false;
}

/// @function SaveMapKeys(map)
/// @description Converts a ds_map's keys to a JSON-safe array.
function SaveMapKeys(_map)
{
	var _keys = [];
	var _key = ds_map_find_first(_map);

	while(!is_undefined(_key))
	{
		array_push(_keys, _key);
		_key = ds_map_find_next(_map, _key);
	}

	return _keys;
}

/// @function SaveMapLoadKeys(map, keys)
/// @description Rebuilds an existing ds_map from an array of keys.
function SaveMapLoadKeys(_map, _keys)
{
	ds_map_clear(_map);

	if(!is_array(_keys))
	{
		return;
	}

	for(var _i = 0; _i < array_length(_keys); _i++)
	{
		ds_map_add(_map, _keys[_i], true);
	}
}

/// @function SaveInventoryToArray()
/// @description Converts undefined inventory slots into JSON-safe empty records.
function SaveInventoryToArray()
{
	var _result = [];

	for(var _i = 0; _i < INVENTORY_SLOT_COUNT; _i++)
	{
		var _slot = global.playerInventorySlots[_i];

		if(is_undefined(_slot))
		{
			array_push(_result, {itemId: "", count: 0});
		}
		else
		{
			array_push(_result, {
				itemId: _slot.itemId,
				count: _slot.count
			});
		}
	}

	return _result;
}

/// @function SaveInventoryFromArray(saved_inventory)
/// @description Converts save records back into the project's inventory format.
function SaveInventoryFromArray(_savedInventory)
{
	var _result = array_create(INVENTORY_SLOT_COUNT, undefined);

	if(!is_array(_savedInventory))
	{
		return _result;
	}

	var _count = min(INVENTORY_SLOT_COUNT, array_length(_savedInventory));

	for(var _i = 0; _i < _count; _i++)
	{
		var _savedSlot = _savedInventory[_i];

		if(is_struct(_savedSlot)
		&& struct_exists(_savedSlot, "itemId")
		&& struct_exists(_savedSlot, "count")
		&& is_string(_savedSlot.itemId)
		&& _savedSlot.itemId != ""
		&& _savedSlot.count > 0)
		{
			_result[_i] = {
				itemId: _savedSlot.itemId,
				count: max(1, floor(_savedSlot.count))
			};
		}
	}

	return _result;
}

/// @function SaveRoomNameToAsset(room_name)
/// @description Whitelist of rooms supported by save format version 1.
function SaveRoomNameToAsset(_roomName)
{
	switch(_roomName)
	{
		case "rVillage": return rVillage;
	}

	return noone;
}

/// @function SaveGameWrite()
/// @description Writes the current rVillage state to the single save slot.
function SaveGameWrite()
{
	if(room != rVillage || !instance_exists(oPlayer))
	{
		show_debug_message("Save failed: saving is only enabled in rVillage.");
		return false;
	}

	var _player = instance_find(oPlayer, 0);
	var _saveData = {
		saveVersion: SAVE_FORMAT_VERSION,
		roomName: room_get_name(room),

		player: {
			x: _player.x,
			y: _player.y,
			direction: _player.direction,
			hp: global.playerHp,
			hpMax: global.playerHpMax,
			strength: global.playerStrength,
			strengthMax: global.playerStrengthMax,
			exhausted: global.playerExhausted
		},

		activeInventorySlot: global.playerActiveSlot,
		inventory: SaveInventoryToArray(),

		quests: {
			dialogueSeen: SaveMapKeys(global.dialogueSeen),
			villagersMet: SaveMapKeys(global.questMeetVillagersMet),
			meetVillagersTotal: global.questMeetVillagersTotal,
			meetVillagersComplete: global.questMeetVillagersComplete,
			templeCleanupActive: global.questTempleCleanupActive,
			templeCleanupCleared: global.questTempleCleanupCleared,
			templeCleanupComplete: global.questTempleCleanupComplete
		},

		world: {
			clearedGarbageIds: global.clearedGarbageIds
		}
	};

	var _json = json_stringify(_saveData);
	var _file = file_text_open_write(SAVE_FILE_NAME);

	if(_file < 0)
	{
		show_debug_message("Save failed: GameMaker could not open the save file.");
		return false;
	}

	file_text_write_string(_file, _json);
	file_text_close(_file);

	show_debug_message("Game saved to " + SAVE_FILE_NAME);
	return true;
}

/// @function SaveGameLoad()
/// @description Restores global state and requests the saved gameplay room.
function SaveGameLoad()
{
	if(!SaveGameExists())
	{
		show_debug_message("Load failed: no save file exists.");
		return false;
	}

	var _file = file_text_open_read(SAVE_FILE_NAME);

	if(_file < 0)
	{
		show_debug_message("Load failed: GameMaker could not open the save file.");
		return false;
	}

	var _json = "";

	while(!file_text_eof(_file))
	{
		_json += file_text_read_string(_file);
		file_text_readln(_file);
	}

	file_text_close(_file);

	try
	{
		var _data = json_parse(_json);

		if(!is_struct(_data)
		|| !struct_exists(_data, "saveVersion")
		|| _data.saveVersion != SAVE_FORMAT_VERSION)
		{
			show_debug_message("Load failed: unsupported save version.");
			return false;
		}

		if(!struct_exists(_data, "roomName")
		|| !struct_exists(_data, "player")
		|| !struct_exists(_data, "activeInventorySlot")
		|| !struct_exists(_data, "inventory")
		|| !struct_exists(_data, "quests")
		|| !struct_exists(_data, "world")
		|| !is_struct(_data.player)
		|| !is_array(_data.inventory)
		|| !is_struct(_data.quests)
		|| !is_struct(_data.world))
		{
			show_debug_message("Load failed: save data is incomplete.");
			return false;
		}

		var _playerData = _data.player;
		var _questData = _data.quests;
		var _playerValid =
			struct_exists(_playerData, "x")
			&& struct_exists(_playerData, "y")
			&& struct_exists(_playerData, "direction")
			&& struct_exists(_playerData, "hp")
			&& struct_exists(_playerData, "hpMax")
			&& struct_exists(_playerData, "strength")
			&& struct_exists(_playerData, "strengthMax")
			&& struct_exists(_playerData, "exhausted");
		var _questsValid =
			struct_exists(_questData, "dialogueSeen")
			&& struct_exists(_questData, "villagersMet")
			&& struct_exists(_questData, "meetVillagersTotal")
			&& struct_exists(_questData, "meetVillagersComplete")
			&& struct_exists(_questData, "templeCleanupActive")
			&& struct_exists(_questData, "templeCleanupCleared")
			&& struct_exists(_questData, "templeCleanupComplete");

		if(!_playerValid || !_questsValid)
		{
			show_debug_message("Load failed: player or quest data is incomplete.");
			return false;
		}

		var _savedRoom = SaveRoomNameToAsset(_data.roomName);

		if(_savedRoom == noone)
		{
			show_debug_message("Load failed: the saved room is not supported.");
			return false;
		}

		// Restore persistent player data.
		global.playerHpMax = max(1, _playerData.hpMax);
		global.playerHp = clamp(_playerData.hp, 0, global.playerHpMax);
		global.playerStrengthMax = max(1, _playerData.strengthMax);
		global.playerStrength = clamp(_playerData.strength, 0, global.playerStrengthMax);
		global.playerExhausted = _playerData.exhausted;

		global.playerInventorySlots = SaveInventoryFromArray(_data.inventory);
		global.playerActiveSlot = clamp(
			floor(_data.activeInventorySlot),
			0,
			INVENTORY_SLOT_COUNT - 1
		);

		// Rebuild the ds_maps created by oGame's Create event.
		SaveMapLoadKeys(global.dialogueSeen, _questData.dialogueSeen);
		SaveMapLoadKeys(global.questMeetVillagersMet, _questData.villagersMet);

		global.questMeetVillagersTotal = max(1, floor(_questData.meetVillagersTotal));
		global.questMeetVillagersComplete = _questData.meetVillagersComplete;
		global.questMeetVillagersCompleteTimer = 0;

		global.questTempleCleanupActive = _questData.templeCleanupActive;
		global.questTempleCleanupCleared = _questData.templeCleanupCleared;
		global.questTempleCleanupComplete = _questData.templeCleanupComplete;
		global.questTempleCleanupCompleteTimer = 0;

		// Garbage totals are recomputed from rVillage's tile layer.
		if(struct_exists(_data.world, "clearedGarbageIds")
		&& is_array(_data.world.clearedGarbageIds))
		{
			global.clearedGarbageIds = _data.world.clearedGarbageIds;
		}
		else
		{
			global.clearedGarbageIds = [];
		}

		// oPlayer does not exist until the saved room has been created.
		global.pendingLoad = {
			active: true,
			playerX: _playerData.x,
			playerY: _playerData.y,
			playerDirection: _playerData.direction
		};

		global.gamePaused = false;
		global.dialogueActive = false;

		room_goto(_savedRoom);
		show_debug_message("Game loaded from " + SAVE_FILE_NAME);
		return true;
	}
	catch(_error)
	{
		show_debug_message("Load failed: " + string(_error));
		return false;
	}
}

/// @function GameSetPaused(paused)
/// @description Freezes or restores instance animation and gameplay input.
function GameSetPaused(_paused)
{
	global.gamePaused = _paused;

	if(_paused)
	{
		with(all)
		{
			gamePausedImageSpeed = image_speed;
			image_speed = 0;
		}
	}
	else
	{
		with(all)
		{
			if(variable_instance_exists(id, "gamePausedImageSpeed"))
			{
				image_speed = gamePausedImageSpeed;
			}
		}
	}
}

/// @function ReturnToMainMenu()
/// @description Removes persistent gameplay controllers before opening rMenu.
function ReturnToMainMenu()
{
	GameSetPaused(false);
	room_goto(rMenu);

	with(oCamera)
	{
		instance_destroy();
	}

	with(oGame)
	{
		instance_destroy();
	}
}
