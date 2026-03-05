# Changelog

## release-prep updates (ace integration pass)

- Embedded Ace3 libs (`AceDB`, `AceLocale`, `AceConfig`, `AceDBOptions`, plus dependencies).
- Migrated profile backend to `AceDB-3.0` with legacy DB migration support.
- Rewired profile actions (`Save/Load/Delete/Reset`) to AceDB path when available.
- Added `CleanPlates (Ace)` category via `AceConfig` with quick toggles and profile controls.
- Registered options locale data with `AceLocale-3.0` (deDE German, other locales English fallback).
- Added `ACE_MIGRATION.md` with current scope and next migration steps.
- Added separate `Nameplate X Spacing` / `Nameplate Y Spacing` controls (`nameplateOverlapH` / `nameplateOverlapV`).
- Added `Extra Plate Height Multiplier` for stronger vertical plate-size control.
- Added startup info chat notice that addon is in development and feedback is welcome.
- Reworked quest marker visuals to icon-based indicators (kill/turn-in/loot heuristic), anchored left of the unit name.
- Fixed root nameplate keybind toggles (friendly/enemy players) being reverted by addon cvar reapply; addon now syncs DB state from external cvar changes.
- Hardened root-toggle sync by consuming `CVAR_UPDATE` value payload directly (prevents stale `GetCVar` fallback from re-enabling friendly players after keybind off).

## release-prep updates (midnight stability hotfix)

- Disabled direct CompactUnitFrame/NamePlate mixin update hooks on Midnight to avoid secret-value taint paths.
- Disabled direct healthbar styling writes (`SetStatusBarColor` / health texture swap) in Midnight stability mode.
- Switched aura handling to CVar/bitfield path only (no direct aura frame mutation).

## release-prep updates (ui-first slash cleanup)

- Reduced slash command surface to UI-open only:
  - `/cp`
  - `/cleanplates`
  - optional aliases: `/cp open`, `/cp options`, `/cp settings`
- Removed per-setting chat command workflow in favor of Settings UI configuration.

## release-prep updates (version stays 1.0.0)

- Added castbar state coloring (interruptible / uninterruptible / friendly).
- Added health percent text overlay with enemy-only option.
- Locked health percent feature to off on Midnight builds (Secret Values incompatibility) to avoid runtime errors.
- Added cast/health configuration controls to Settings UI.
- Added slash toggles: `hp`, `hpenemy`, `castcolors`.
- Added extra color targets: `castint`, `castlock`, `castfriendly`, `healthtext`.
- Added profile sharing commands: `export` / `import`.
- Added `Print Export` button in settings.

## v0.4.2

- Added debug toggle in options UI.
- Added `/cp debug` command.

## v0.4.1

- Added target highlight color as configurable palette color.
- Added target color swatch in options UI.
- Extended color command to support `target`.
- Added `build-mainline.ps1` for quick retail zip packaging.

## v0.4.0

- Added neutral unit color handling.
- Added slash command color API: `/cp color enemy|friendly|neutral r g b`.
- Added color swatches (enemy/friendly/neutral) with Blizzard color picker integration.
- Expanded options panel layout.

## v0.3.1

- Added `/cp status`.
- Improved restore behavior when disabling addon.

## v0.3.0

- Added presets and target highlight support.
- Improved hook coverage and CVAR reapply logic.

## v0.2.0

- Added presets and expanded options controls.

## v0.1.0

- Initial MVP.
