# Generated NPC Sprite Sheets

These files are base NPC turnaround sheets for GameMaker import.

## Files

- `spr_npc_maya_base_4dir.png`
- `spr_npc_biren_base_4dir.png`
- `spr_npc_ama_base_4dir.png`
- `spr_npc_tika_base_4dir.png`
- `npc_turnaround_source.png`

## Import Settings

- Sheet size: `160x64`
- Frame size: `40x64`
- Frame count: `4`
- Layout: `4 columns x 1 row`
- Origin: bottom center, matching the player sprites
  - `xorigin = 20`
  - `yorigin = 64`

## Direction Order

The frames are ordered to match the current `CARDINAL_DIRECTION` macro:

1. `0 degrees`: facing right
2. `90 degrees`: facing up/back
3. `180 degrees`: facing left
4. `270 degrees`: facing down/front

This means the existing NPC direction logic can choose the frame directly from the direction row/index mapping.

## Notes

These are static base designs only. Add walking animation frames later by expanding each direction into multiple frames while keeping the same direction order.
