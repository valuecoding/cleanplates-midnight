# CleanPlates

CleanPlates is a lightweight Midnight (Retail) addon that restyles nameplates and floating combat text.

## Features

- Nameplate font styling
- Castbar texture restyling
- Plate art visual overlays (healthbar texture writes are disabled on Midnight stability mode)
- Player class color support on nameplates
- Enemy/Friendly/Neutral palette customization
- Target name highlight with custom color
- Target font boost slider
- Castbar state colors (interruptible / uninterruptible / friendly)
- Health percentage text on nameplates
  - Midnight currently blocks this via Secret Values, so the toggle is kept disabled safely.
- Floating combat text font styling
- Quick presets: `Vivid`, `Neutral`, `Soft`
- Plate Art modes (`Clean`, `Solid`, `Blizzard`, `Classic`, `Thin`, `Thick`, `Compact`, `Wide`) with visible border/backdrop + texture differences
- Optional external statusbar packs via `LibSharedMedia-3.0` (if installed)
- Ace3-backed profile system (`AceDB-3.0`) with in-game profile switching/reset
- Embedded Ace options bridge (`AceConfig-3.0`) including `AceDBOptions` profile controls
- Separate plate spacing controls (`nameplateOverlapH` / `nameplateOverlapV`) for X/Y layout tuning
- Extra plate height multiplier for stronger vertical size changes
- Quest indicators on nameplates with icon heuristic (`kill`, `turn-in`, `loot`)

## Commands

- `/cp` -> open/toggle options window
- `/cleanplates` -> open/toggle options window
- Optional aliases: `/cp open`, `/cp options`, `/cp settings`
- All feature configuration is UI-first inside Blizzard Settings (no per-setting slash command matrix).

## Settings UI

- Main UI: `CleanPlates` registers in Blizzard Settings under `Options -> AddOns`.
- Ace bridge UI: additional `CleanPlates (Ace)` category with fast toggles and Ace profile tools.
- Locale behavior:
  - `deDE` client -> German strings
  - all other clients -> English strings
- `LibSharedMedia-3.0` remains optional (external texture packs).

## Files

- `CleanPlates_Mainline.toc` (Retail / Midnight)
- `Core.lua`
- `Options.lua`
- `AceOptions.lua`
- `libs/` (embedded Ace3 + LibStub/CallbackHandler)
- `build-mainline.ps1`
- `deploy-retail.ps1`

## Build

- Build zip package:
  - `powershell -ExecutionPolicy Bypass -File .\build-mainline.ps1`
- Output:
  - `dist/CleanPlates-mainline-v<version>.zip`

## Deploy to Retail

- Deploy current working files directly into Retail AddOns:
  - `powershell -ExecutionPolicy Bypass -File .\deploy-retail.ps1`
