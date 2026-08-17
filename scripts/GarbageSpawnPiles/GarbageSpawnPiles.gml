// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GarbageSpawnPiles(){
	// Read tile data straight from the room's Garbage layer instead of hand-placed instances.
	var _tilemap = layer_tilemap_get_id(layer_get_id("Garbage"));
	var _gridW = tilemap_get_width(_tilemap);
	var _gridH = tilemap_get_height(_tilemap);
	var _tileW = tilemap_get_tile_width(_tilemap);
	var _tileH = tilemap_get_tile_height(_tilemap);

	// Recount from scratch every time this runs so quest progress matches the live tiles.
	global.questGarbageTotal = 0;
	global.questGarbageCollected = 0;

	// Track visited cells so each connected clump of garbage tiles becomes one pile.
	var _visited = ds_grid_create(_gridW, _gridH);
	ds_grid_clear(_visited, 0);

	for(var _cy = 0; _cy < _gridH; _cy++)
	{
		for(var _cx = 0; _cx < _gridW; _cx++)
		{
			if(ds_grid_get(_visited, _cx, _cy))
			{
				continue;
			}

			ds_grid_set(_visited, _cx, _cy, 1);

			// Empty cell, nothing to flood fill from here.
			if(tile_get_index(tilemap_get(_tilemap, _cx, _cy)) <= 0)
			{
				continue;
			}

			// Flood fill outward (4-directional) to gather this whole connected pile of tiles.
			var _cellsX = [_cx];
			var _cellsY = [_cy];
			var _minCellX = _cx;
			var _maxCellX = _cx;
			var _minCellY = _cy;
			var _maxCellY = _cy;

			var _stack = ds_stack_create();
			ds_stack_push(_stack, [_cx, _cy]);

			while(!ds_stack_empty(_stack))
			{
				var _cell = ds_stack_pop(_stack);
				var _neighborsX = [_cell[0] + 1, _cell[0] - 1, _cell[0], _cell[0]];
				var _neighborsY = [_cell[1], _cell[1], _cell[1] + 1, _cell[1] - 1];

				for(var _n = 0; _n < 4; _n++)
				{
					var _nx = _neighborsX[_n];
					var _ny = _neighborsY[_n];

					if(_nx < 0 || _ny < 0 || _nx >= _gridW || _ny >= _gridH)
					{
						continue;
					}

					if(ds_grid_get(_visited, _nx, _ny))
					{
						continue;
					}

					ds_grid_set(_visited, _nx, _ny, 1);

					if(tile_get_index(tilemap_get(_tilemap, _nx, _ny)) <= 0)
					{
						continue;
					}

					array_push(_cellsX, _nx);
					array_push(_cellsY, _ny);
					ds_stack_push(_stack, [_nx, _ny]);

					_minCellX = min(_minCellX, _nx);
					_maxCellX = max(_maxCellX, _nx);
					_minCellY = min(_minCellY, _ny);
					_maxCellY = max(_maxCellY, _ny);
				}
			}

			ds_stack_destroy(_stack);

			// Place one collectible pile at the center of this cluster's tile bounds.
			var _boundsWidth = (_maxCellX - _minCellX + 1) * _tileW;
			var _boundsHeight = (_maxCellY - _minCellY + 1) * _tileH;
			var _centerX = (_minCellX * _tileW) + (_boundsWidth * 0.5);
			var _centerY = (_minCellY * _tileH) + (_boundsHeight * 0.5);

			var _pile = instance_create_layer(_centerX, _centerY, "Instances", oGarbagePile);
			_pile.garbageTilemap = _tilemap;
			_pile.tileCellsX = _cellsX;
			_pile.tileCellsY = _cellsY;
			_pile.boundsWidth = _boundsWidth;
			_pile.boundsHeight = _boundsHeight;
			_pile.collectRadius = max(_boundsWidth, _boundsHeight) * 0.5 + 40;
			// The room and minimum tile coordinate form a stable world-object id.
			_pile.saveId = room_get_name(room) + ":" + string(_minCellX) + ":" + string(_minCellY);

			global.questGarbageTotal++;

			// Reapply previously collected world state to the new room instance.
			if(SaveArrayContains(global.clearedGarbageIds, _pile.saveId))
			{
				for(var _savedI = 0; _savedI < array_length(_cellsX); _savedI++)
				{
					tilemap_set(_tilemap, 0, _cellsX[_savedI], _cellsY[_savedI]);
				}

				_pile.collected = true;
				global.questGarbageCollected++;
			}
		}
	}

	if(global.questGarbageTotal > 0
	&& global.questGarbageCollected >= global.questGarbageTotal)
	{
		global.questTempleCleanupCleared = true;
	}

	ds_grid_destroy(_visited);
}
