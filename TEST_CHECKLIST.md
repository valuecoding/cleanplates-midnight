# CleanPlates - Midnight Test Checklist (v1.0.0 (fixed until release))

## Quick Smoke

1. Enable addon, run `/reload`, and target a dummy.
Expected: nameplate font/style changes are visible.

2. Run `/cp` to open options.
Expected: options window opens and can be moved.

3. Toggle `Enable CleanPlates styling` off and on.
Expected: Blizzard look returns when off; custom look returns when on.

## Presets + Palette (UI)

4. Click `Vivid`, `Neutral`, `Soft`.
Expected: healthbar colors + font sizes update each time.

5. Use the `Neutral` swatch and pick `255,180,40`.
Expected: neutral nameplates update color live.

6. Use the `Target Name` swatch and pick `255,210,80`.
Expected: target name highlight updates color live.

7. Increase `Target Font Boost` slider and switch targets.
Expected: current target name gets larger without changing non-targets.

8. Toggle `Use castbar state colors` and cast on enemy/friendly units.
Expected: interruptible casts, non-interruptible casts, and friendly casts use distinct colors.

9. Toggle `Show health percent on nameplates` and `Only on enemy nameplates`.
Expected: remains safely disabled on Midnight (Secret Values guard), no Lua errors.

10. In `Profiles` section, use `Fill Export`, then `Import String` with the copied value.
Expected: profile imports successfully and settings remain stable.

## Target + Combat Text

11. With `Highlight current target name` enabled, switch targets.
Expected: current target is highlighted; old target color resets.

12. Toggle `Style floating combat text font` on/off.
Expected: combat text font changes on enable and returns to Blizzard default on disable.

## API Stability

13. Change nameplate CVar settings in Blizzard UI (size/style/nameplate options).
Expected: addon reapplies style automatically without Lua errors.

## Secret/Taint Gate (Midnight)

14. Fight with multiple enemy/friendly nameplates visible, then spam target swap.
Expected: no `forbidden object` and no `tainted by` errors.

15. Test quest-related NPCs/mobs with quest marker enabled.
Expected: no `secret value` / `table index is secret` errors.

16. In `Size And Scale`, change `Extra Plate Height Multiplier` from `1.00` to `1.60`.
Expected: nameplate bars become visibly taller.

17. In `Size And Scale`, change `Nameplate X Spacing` and `Nameplate Y Spacing`.
Expected: stacked plate spacing changes horizontally/vertically without Lua errors.

18. Open options during active gameplay and toggle key settings rapidly.
Expected: no Lua error spam while nameplates keep updating.
