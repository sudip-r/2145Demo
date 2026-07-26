// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ItemGetDefinition(_itemId){
	// Central item database, similar in spirit to DialogueGetLines for NPC lines.
	switch(_itemId)
	{
		case "hoe":
			return {
				id: "hoe",
				displayName: "Hoe",
				category: "tool",
				restoreHp: 0,
				maxStack: 1
			};

		case "sword":
			return {
				id: "sword",
				displayName: "Sword",
				category: "weapon",
				restoreHp: 0,
				maxStack: 1
			};

		case "bread":
			return {
				id: "bread",
				displayName: "Bread",
				category: "food",
				restoreHp: 20,
				maxStack: 9
			};
	}

	// Fallback keeps an unknown item id from crashing inventory code.
	return {
		id: _itemId,
		displayName: "Unknown",
		category: "misc",
		restoreHp: 0,
		maxStack: 1
	};
}
