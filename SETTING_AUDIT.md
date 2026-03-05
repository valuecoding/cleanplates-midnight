# CleanPlates Setting Audit (Midnight)

Updated: 2026-03-05

## 1) General
- `Enable CleanPlates styling`: working
- `Use class colors on player nameplates`: limited on Midnight stability mode (direct healthbar color writes disabled to prevent secret-value taint)
- `Style floating combat text font`: working
- `Use castbar colors (enemy/friendly)`: working (`locked` cast state still limited by Midnight secret cast flags)
- `Show health percent on nameplates`: unsupported on Midnight (Secret Values), disabled in UI
- `Only on enemy nameplates`: unsupported on Midnight (depends on health percent), disabled in UI
- `Highlight current target name`: currently limited (name text styling stays restricted to avoid forbidden-object taint)
- `Show quest marker on quest-related nameplates`: working
  - icon style now differentiates by heuristic: `kill` (sword), `turn-in` (quest question icon), `loot` (bag on dead quest unit)
- `Enable debug chat output`: working

## 2) Nameplate Filters
- `Show enemy/friendly nameplates`: working (root + split CVars, incl. NPC/Npc variants)
- `Enemy Pets/Guardians/Totems/Minions`: working via `nameplateShowEnemy*`
- `Friendly Pets/Guardians/Totems/Minions`: Midnight uses `nameplateShowFriendlyPlayer*` CVars (not only legacy `nameplateShowFriendly*`)
- `Enemy Minus`: mapped to enemy-minion visibility for Midnight behavior parity

## 3) Aura Display
- `Show debuffs/buffs on enemy/friendly`: fixed with dual path:
  - legacy aura CVars (`nameplateShowDebuffsOn*` / `nameplateShowBuffsOn*`)
  - Midnight bitfields (`nameplateEnemyNpcAuraDisplay`, `nameplateEnemyPlayerAuraDisplay`, `nameplateFriendlyPlayerAuraDisplay`)
- `Max Buff Icons` / `Max Debuff Icons`: CVar/bitfield-driven on Midnight stability mode (no direct frame mutation)

## 4) Typography
- `Name Font Size`: currently affects castbar/marker typography path; full name-text styling is still restricted
- `Combat Text Font Size`: working
- `Target Font Boost`: limited by name-text restriction

## 5) Size & Scale
- `Global / Width / Height Scale`: fixed with fallback sizing mode:
  - `api` mode prefers Midnight unified API (`C_NamePlate.SetNamePlateSize`), falls back to enemy/friendly APIs when needed
  - `manual` mode when APIs are missing on Midnight
- Scale writes include both lowercase and Midnight camel-case aliases (e.g. `nameplateVerticalScale` + `NamePlateVerticalScale`)
- `Extra Plate Height Multiplier`: NEW (multiplies actual plate height on top of Vertical Scale)
- `Nameplate X Spacing` / `Nameplate Y Spacing`: NEW (maps to `nameplateOverlapH` / `nameplateOverlapV`)
- `Target Scale`: working
- `Max Nameplate Distance`: working (`100` is accepted on your client)
- `Castbar Scale`: working
- `Recheck Scale` button: forces reapply and refresh
- Live status line shows effective values + `Size Mode`

## 6) Plate Art
- `Clean/Solid/Blizzard/Classic/Thin/Thick/Compact/Wide`: working
- Visual deltas are from overlay + border/backdrop + style multipliers (healthbar texture writes disabled in stability mode)
- External texture packs: optional support via `LibSharedMedia-3.0` (configured in Options UI texture fields)

## 7) Palette
- `Enemy/Friendly/Neutral` colors: applied through healthbar styling path
- `Target Name` color: limited by name-text restriction
- `Cast: Enemy/Friendly`: working
- `Cast: Locked` (uninterruptible): limited by Midnight cast-flag secrecy on some units
- `Health Text` color: limited because health-percent text is disabled on Midnight

## Quick verify order (tomorrow)
1. `/reload`
2. Open settings with `/cp`
3. Test `Show debuffs on enemy nameplates` + `Max Debuff Icons`
4. Test `Global/Width/Height` sliders + `Extra Plate Height Multiplier` (watch `Size Mode` live status in UI)
5. Test `Nameplate X Spacing` and `Nameplate Y Spacing`
6. Test root filters (`Show friendly nameplates` and enemy/friendly sub-toggles)

## API research notes (source links)
- Midnight API changes note (includes secret value restrictions and addon-impact context):
  - https://www.inven.co.kr/board/wow/1896/56029
- Midnight cvar casing behavior (`NPCs` vs `Npcs`) discussed with working examples:
  - https://us.forums.blizzard.com/en/wow/t/nameplate-cvar-wrong-casing-nameplateshowfriendlynpcs-vs-nameplateshowfriendlynpcs/2122324

## Taint guard checklist (for next addons)
- Avoid direct per-frame `SetScale/SetSize` on CompactUnitFrame nameplates in Midnight.
- Prefer CVar/API size writes; fallback mode should stay `cvar` if API size calls fail.
- In hooks (`CompactUnitFrame_*` / `NamePlateUnitFrameMixin`), defer addon styling with `C_Timer.After(0, ...)` instead of mutating immediately in secure update flow.
- Never index Lua tables with potentially secret unit tokens; use safe GUID cache keys.
- Treat frame booleans (e.g. `unitFrame.isFriend`) as potentially secret: sanitize first, do not `not` directly.
- Prefer event-driven reapply over direct hooks into `CompactUnitFrame_*` and `NamePlateUnitFrameMixin` update functions on Midnight.
