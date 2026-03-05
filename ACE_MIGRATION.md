# CleanPlates Ace Migration (Midnight)

## What Is Live

- Embedded Ace3 libraries in `libs/`:
  - `LibStub`, `CallbackHandler-1.0`
  - `AceAddon-3.0`, `AceEvent-3.0`, `AceConsole-3.0`
  - `AceDB-3.0`, `AceDBOptions-3.0`
  - `AceLocale-3.0`
  - `AceGUI-3.0`, `AceConfig-3.0`
- TOCs now load embedded Ace libs before addon files.
- Database backend supports AceDB:
  - Legacy `CleanPlatesDB` is migrated into Ace profile format.
  - Current settings are bound to `self.db = self.aceDB.profile`.
  - Profile callbacks trigger normalize + refresh.
- Existing profile actions (`Save/Load/Delete/Reset`) now use AceDB when available.
- Options localization is now registered via `AceLocale-3.0` with fallback:
  - `deDE` -> German
  - all others -> English
- Added `AceOptions.lua`:
  - Registers `CleanPlates (Ace)` options category.
  - Includes quick gameplay toggles and size controls.
  - Includes native Ace profile options via `AceDBOptions`.

## Why This Helps

- Profile reliability improves (AceDB handles profile keys and switching).
- Lower maintenance for profile tooling (`AceDBOptions` instead of custom-only logic).
- Locale handling is centralized and reusable.
- Better future path for modular config growth.

## Current Scope

- Main custom UI in `Options.lua` remains primary and intact.
- Ace bridge currently complements (not replaces) the custom UI.
- Midnight stability/taint protections remain unchanged and still take priority.

## Suggested Next Steps

1. Move the remaining manual options controls into full AceConfig groups.
2. Add explicit “profile copy from” UX in custom UI (backed by AceDB `CopyProfile`).
3. Add optional LSM font/media pickers through AceConfig widgets.
4. Keep taint-sensitive features guarded behind protected-safe checks.
