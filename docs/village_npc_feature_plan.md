# Village and NPC Feature Plan

## Current Baseline

The demo is a GameMaker 2D RPG/farming prototype with movement, collision, camera follow, and basic farming action groundwork already in place.

- `rVillage` is the current playable room and starts from `ROOM_START`.
- `oPlayer` already reads movement, run, and Space activation input.
- Collision is tilemap based through the `Col` layer and `tCol`.
- Existing map layers include `Ground`, `River`, `Beach`, `Trees`, `Trees2`, `Trees3`, `PlayerUpperLayer`, `Instances`, and `Col`.
- Existing visual resources include player idle/walk/plough sprites, general tiles, houses, tree tiles, a center tree object, and collision tiles.

This plan focuses on adding a believable village and functional NPC foundation first. Dialogue content and branching conversations should come next, after the world has interactable residents placed in meaningful locations.

## Goals

1. Make `rVillage` feel like an intentional small village instead of a loose test map.
2. Add NPCs as interactable world characters with idle presence and simple schedules.
3. Add or expand sprites and tiles where the current asset set cannot support the village layout.
4. Prepare the code structure for dialogue without committing to final dialogue writing yet.
5. Keep the implementation compatible with the existing player, camera, collision, and room layer setup.

## Proposed Village Design

The village should be built around a readable hub layout so players always understand where they are.

- **Central square:** Use the existing center tree as the main landmark. Add paths around it, benches, notice board, small market props, flower beds, and walkable open space.
- **North residential row:** Add 3-4 homes with fenced yards, gardens, mailboxes, and signs. Use `tHouses1` first, then create missing detail tiles only where needed.
- **East craft/shop area:** Add a blacksmith/workshop, general store frontage, crates, barrels, stall tables, and a wider path for NPC movement.
- **South farm edge:** Add tilled plots, scarecrow, water trough, sheds, and transition space toward future farming systems.
- **West river/park edge:** Use the existing river and beach layers as a quieter social area with fishing spots, bridge or stepping stones, and trees.
- **Road network:** Use 2-tile-wide main paths and 1-tile-wide side paths. The paths should connect all NPC destinations clearly and avoid tight collision corners.

## Tile and Sprite Needs

Reuse existing `tTiles`, `tHouses1`, `tTreeMain`, and `tCenterTreeBase` first. Create new resources only for gaps that affect readability or interaction.

### New Tiles

- `sVillageProps` / `tVillageProps`
  - Notice board
  - Signposts
  - Benches
  - Crates and barrels
  - Fences and gates
  - Flower beds
  - Mailboxes
  - Market stall tops
  - Well or water pump

- `sVillagePaths` / `tVillagePaths`, only if existing path tiles are insufficient
  - Dirt path center
  - Dirt path edges and corners
  - Stone plaza tile
  - Bridge or stepping stone pieces

### New NPC Sprites

Start with compact, readable 4-direction sprites matching the player's scale.

- `sNpcMaya`
  - Role: general store owner
  - Location: east shop area
  - Personality target: warm, practical, early-game guide

- `sNpcBiren`
  - Role: farmer/carpenter neighbor
  - Location: south farm edge
  - Personality target: grounded, teaches village routines

- `sNpcAma`
  - Role: elder/story anchor
  - Location: central tree or west park
  - Personality target: gentle, hints at lore

- `sNpcTika`
  - Role: courier/child/errand runner
  - Location: roaming between square and homes
  - Personality target: energetic, points player toward places

Minimum animation set for each NPC:

- Idle down/up/left/right
- Walk down/up/left/right, 2-4 frames per direction

## NPC System Plan

### Resources To Add

- `oNpcParent`
  - Shared object for name, facing direction, interact radius, schedule state, and dialogue id.
  - Handles simple idle/wander behavior.
  - Exposes an `Interact()` method or script call for player activation.

- `oNpcMaya`, `oNpcBiren`, `oNpcAma`, `oNpcTika`
  - Child objects or configured instances based on `oNpcParent`.
  - Each stores its sprite, display name, home/work anchors, and future dialogue key.

- `scrNpcCreate`
  - Initializes shared NPC variables.

- `scrNpcStepIdle`
  - Handles standing, facing, short pacing, and schedule wait timers.

- `scrNpcFindInteractTarget`
  - Used by the player when Space is pressed.
  - Finds the closest NPC in front of or near the player.

### Interaction Flow

1. Player presses Space while in `PlayerStateFree`.
2. Player checks for an NPC target before starting ploughing.
3. If an NPC is found, pause player movement and call the NPC interaction hook.
4. For this phase, show a placeholder one-line debug/message bubble or set a placeholder interaction state.
5. If no NPC is found, continue current behavior and allow plough action.

This keeps Space as the main interaction key but prevents farming actions from stealing NPC interactions.

## Room Integration Plan

### `rVillage` Layers

Keep the existing layer names where possible and add only what helps authoring.

- `Ground`: base grass, paths, plaza, shore transitions.
- `River` and `Beach`: water/shore polish.
- `Trees`, `Trees2`, `Trees3`: existing tree depth layering.
- `VillagePropsBack`: non-overlapping props behind the player.
- `Instances`: player, NPCs, object props, interactables.
- `PlayerUpperLayer`: roof fronts, tree canopies, high props that should draw above player.
- `Col`: collision for water, houses, trees, fences, props, and map boundaries.

### First NPC Placement

- Maya: outside the east shop, short pacing route near storefront.
- Biren: south farm edge, idle near plots and shed.
- Ama: near the central tree or bench.
- Tika: simple route between residential row and central square.

Use fixed positions first. Add schedules after the base interaction loop is stable.

## Implementation Phases

### Phase 1: Village Blockout

- Rework `rVillage` into central square, residential row, shop/craft area, farm edge, and river/park edge.
- Use existing tilesets for all rough layout.
- Update `Col` to match new buildings, trees, water, fences, and props.
- Verify the player can walk all major routes without snagging on corners.

### Phase 2: Village Prop Assets

- Add `sVillageProps` and `tVillageProps` if existing tiles do not cover the needed props.
- Place signs, benches, fences, mailboxes, market props, and garden details.
- Keep collision simple: block solid props, leave decorative ground clutter walkable.

### Phase 3: NPC Foundation

- Add `oNpcParent`.
- Add four NPC objects or room-configured NPC instances.
- Add idle facing and simple pacing.
- Place NPCs in `rVillage`.
- Ensure NPCs respect collision or stay on fixed safe routes.

### Phase 4: Player Interaction Hook

- Update `PlayerStateFree` so Space checks NPC interaction before ploughing.
- Add a placeholder response path, such as a temporary text bubble or debug message.
- Set `global.gamePaused` only if an interaction UI is active.

### Phase 5: Dialogue Readiness

- Add dialogue ids to NPCs, but keep final writing for the next planning pass.
- Define a future data format, likely one struct or JSON-like table per NPC.
- Prepare for portraits, nameplates, typewriter text, choices, and relationship flags.

## Dialogue Planning Preview

The next document should define:

- Dialogue box UI layout and controls.
- Dialogue data format.
- NPC portrait requirements.
- Conversation states: first meeting, daily line, tutorial line, quest line.
- Relationship flags and simple quest hooks.
- How dialogue pauses movement and resumes gameplay.

## Acceptance Checklist

- `rVillage` has clear districts and routes.
- Player can navigate from spawn to every village area.
- Collision blocks buildings, water, trees, and major props.
- At least four NPCs are visible in the village.
- NPCs idle or pace without disrupting player movement.
- Pressing Space near an NPC triggers an interaction placeholder.
- Pressing Space away from NPCs still allows existing plough behavior.
- New sprite/tile resources are named consistently and registered in the GameMaker project.

## Risks and Notes

- GameMaker `.yy` files are sensitive to resource ids and project registration. New sprites, tilesets, objects, and scripts should be created through GameMaker when possible, or edited carefully with matching project resource entries.
- Directly editing compressed tile data in `rVillage.yy` is brittle. Major map redesign is safer inside the GameMaker room editor.
- NPC pathing can start fixed and simple. Full pathfinding is unnecessary for the first village pass unless schedules require crossing complex routes.
- Dialogue should be planned separately after NPC placement, because the final dialogue structure depends on how interaction objects and UI are implemented.
