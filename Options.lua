local _, ns = ...

local CleanPlates = ns.CleanPlates
if not CleanPlates then
    return
end

local SETTINGS_ICON_TEXTURE = "Interface\\Icons\\INV_Misc_Map_01"
local CLIENT_LOCALE = (type(GetLocale) == "function" and GetLocale()) or "enUS"

local STRINGS_EN = {
    addon_title = "CleanPlates",
    addon_subtitle = "Midnight settings (profiles, filters, size, style)",
    section_general = "General",
    section_filters = "Nameplate Filters",
    section_aura = "Aura Display",
    section_typography = "Typography",
    section_size = "Size And Scale",
    section_plate_art = "Plate Art",
    section_external_textures = "External Textures (LSM)",
    section_presets = "Quick Presets",
    section_palette = "Palette",
    active_preset = "Active Preset: %s",
    active_style = "Active Style: %s",
    resolved_textures = "Resolved: health=%s   cast=%s",
    typography_active = "Name font controls are active.",
    typography_disabled = "Midnight stability mode: name font controls are disabled to prevent taint.",
    scale_status_pending = "Live CVar G/H/V/T/D: n/a / n/a / n/a / n/a / n/a   Size Mode: pending",
    scale_status = "Live CVar G/H/V/T/D: %s / %s / %s / %s / %s   (Effective: %.2f / %.2f / %.2f / %.2f / %d)   Size Mode: %s",
    scale_extra = "Height Mult / X/Y Spacing: %.2f / %.2f / %.2f",
    check_enabled = "Enable CleanPlates styling",
    check_class_color = "Use class colors on player nameplates",
    check_combat_text = "Style floating combat text font",
    check_cast_colors = "Use castbar colors (enemy/friendly)",
    check_health_percent = "Show health percent on nameplates",
    check_health_percent_enemy_only = "Only on enemy nameplates",
    check_target_highlight = "Highlight current target name",
    check_quest_marker = "Show quest marker on quest-related nameplates",
    check_debug = "Enable debug chat output",
    check_show_enemy = "Show enemy nameplates",
    check_show_friendly = "Show friendly nameplates",
    check_enemy_pets = "Enemy Pets",
    check_enemy_guardians = "Enemy Guardians",
    check_enemy_totems = "Enemy Totems",
    check_enemy_minions = "Enemy Minions",
    check_friendly_pets = "Friendly Pets",
    check_friendly_guardians = "Friendly Guardians",
    check_friendly_totems = "Friendly Totems",
    check_friendly_minions = "Friendly Minions",
    check_debuff_enemy = "Show debuffs on enemy nameplates",
    check_buff_enemy = "Show buffs on enemy nameplates",
    check_debuff_friendly = "Show debuffs on friendly nameplates",
    check_buff_friendly = "Show buffs on friendly nameplates",
    slider_max_buffs = "Max Buff Icons",
    slider_max_debuffs = "Max Debuff Icons",
    slider_name_size = "Name Font Size",
    slider_combat_size = "Combat Text Font Size",
    slider_target_boost = "Target Font Boost",
    slider_global_scale = "Global Scale",
    slider_width_scale = "Plate Width Scale (actual size)",
    slider_height_scale = "Plate Height Scale (actual size)",
    slider_height_multiplier = "Extra Plate Height Multiplier",
    slider_x_spacing = "Nameplate X Spacing",
    slider_y_spacing = "Nameplate Y Spacing",
    slider_target_scale = "Target Scale",
    slider_max_distance = "Max Nameplate Distance",
    slider_cast_scale = "Castbar Scale",
    btn_recheck_scale = "Recheck Scale",
    texture_info = "Optional: use a LibSharedMedia statusbar name or a direct texture path.",
    health_texture = "Health Texture",
    cast_texture = "Cast Texture",
    btn_apply_textures = "Apply Textures",
    btn_reset_textures = "Reset Textures",
    btn_list_lsm = "List LSM",
    btn_vivid = "Vivid",
    btn_neutral = "Neutral",
    btn_soft = "Soft",
    preset_vivid = "Vivid",
    preset_neutral = "Neutral",
    preset_soft = "Soft",
    style_clean = "Clean",
    style_solid = "Solid",
    style_blizzard = "Blizzard",
    style_classic = "Classic",
    style_thin = "Thin",
    style_thick = "Thick",
    style_compact = "Compact",
    style_wide = "Wide",
    palette_hint = "Click swatches to customize",
    btn_apply_now = "Apply Now",
    btn_reset_defaults = "Reset Defaults",
    options_hint = "/cp opens this page. Categories, Profiles, and Info are in AddOns -> CleanPlates.",
    color_enemy = "Enemy",
    color_friendly = "Friendly",
    color_neutral = "Neutral",
    color_target = "Target Name",
    color_cast_enemy = "Cast: Enemy",
    color_cast_locked = "Cast: Locked (unused)",
    color_cast_friendly = "Cast: Friendly",
    color_health_text = "Health Text",
    profiles_title = "CleanPlates - Profiles",
    profiles_subtitle = "Manage named profiles, import/export, and reset.",
    profiles_active = "Active Profile: %s",
    profile_name = "Profile Name",
    btn_save_update = "Save/Update",
    btn_load = "Load",
    btn_delete = "Delete",
    btn_reset_active = "Reset Active",
    saved_profiles = "Saved Profiles",
    import_export = "Import / Export String",
    btn_fill_export = "Fill Export",
    btn_import_string = "Import String",
    btn_clear = "Clear",
    io_hint = "Use Fill Export to generate a share string. Paste a string and press Import String to load it into the active profile.",
    info_title = "CleanPlates - Info",
    info_body = "Version: %s\nAuthor: enjoymygripz\n\nThis addon is currently in development.\nFeatures and behavior can change between updates.\n\nMidnight stability mode:\n- Nameplate frame styling is restricted to prevent taint.\n- Health percent is disabled due to Secret Values.\n\nFeedback is welcome via CurseForge comments or by PN.\n\nUse /cp or /cleanplates to open settings.",
    nav_general = "General",
    nav_filters = "Filters",
    nav_aura = "Aura",
    nav_typography = "Typography",
    nav_size = "Size & Scale",
    nav_plate_art = "Plate Art",
    nav_palette = "Palette",
    nav_profiles = "Profiles",
    nav_info = "Info",
    nav_desc_general = "Core addon toggles and behavior.",
    nav_desc_filters = "Enemy/Friendly visibility and unit type filters.",
    nav_desc_aura = "Aura visibility and max buff/debuff settings.",
    nav_desc_typography = "Name and combat text font sizing.",
    nav_desc_size = "Global size, width, height, target scaling, and distance.",
    nav_desc_plate_art = "Visual style presets for plate shape/texture look.",
    nav_desc_palette = "Color swatches for enemy/friendly/target/cast text.",
    nav_desc_profiles = "Named profile save/load/import/export controls.",
    nav_desc_info = "Addon status and release notes summary.",
    section_opening = "Opening section...",
    msg_color_picker_unavailable = "Color picker API is unavailable on this client.",
    msg_health_percent_unavailable = "Health %% is unavailable in Midnight (Secret Values).",
    msg_no_texture_change = "No texture change applied.",
    msg_no_lsm_textures = "No external LSM textures found.",
    msg_lsm_textures = "LSM statusbar textures (%d): %s",
    msg_defaults_restored = "Defaults restored.",
    msg_profile_saved = "Profile saved: %s",
    msg_profile_save_failed = "Save failed: %s",
    msg_profile_loaded = "Profile loaded: %s",
    msg_profile_load_failed = "Load failed: %s",
    msg_profile_deleted = "Profile deleted: %s",
    msg_profile_delete_failed = "Delete failed: %s",
    msg_profile_reset = "Profile reset: %s",
    msg_profile_reset_failed = "Reset failed: %s",
    msg_profile_export_failed = "Could not export profile.",
    msg_profile_imported = "Profile imported.",
    msg_profile_import_failed = "Import failed: %s",
}

local STRINGS_DE = {
    addon_subtitle = "Midnight-Einstellungen (Profile, Filter, Groesse, Stil)",
    section_general = "Allgemein",
    section_filters = "Namensleisten-Filter",
    section_aura = "Aura-Anzeige",
    section_typography = "Typografie",
    section_size = "Groesse und Skalierung",
    section_plate_art = "Leistenstil",
    section_external_textures = "Externe Texturen (LSM)",
    section_presets = "Schnell-Presets",
    section_palette = "Farbpalette",
    active_preset = "Aktives Preset: %s",
    active_style = "Aktiver Stil: %s",
    resolved_textures = "Aufgeloest: Leben=%s   Zauber=%s",
    typography_active = "Namensschrift-Steuerung ist aktiv.",
    typography_disabled = "Midnight-Stabilitaetsmodus: Namensschrift-Steuerung ist deaktiviert (Taint-Schutz).",
    scale_status_pending = "Live-CVar G/H/V/T/D: n/a / n/a / n/a / n/a / n/a   Groessenmodus: ausstehend",
    scale_status = "Live-CVar G/H/V/T/D: %s / %s / %s / %s / %s   (Effektiv: %.2f / %.2f / %.2f / %.2f / %d)   Groessenmodus: %s",
    scale_extra = "Hoehen-Mult / X/Y-Abstand: %.2f / %.2f / %.2f",
    check_enabled = "CleanPlates-Styling aktivieren",
    check_class_color = "Klassenfarben fuer Spieler-Namensleisten nutzen",
    check_combat_text = "Schrift fuer schwebenden Kampftext stylen",
    check_cast_colors = "Zauberleisten-Farben nutzen (feindlich/freundlich)",
    check_health_percent = "Lebensprozente auf Namensleisten anzeigen",
    check_health_percent_enemy_only = "Nur auf feindlichen Namensleisten",
    check_target_highlight = "Aktuelles Ziel hervorheben",
    check_quest_marker = "Questmarker auf questrelevanten Namensleisten anzeigen",
    check_debug = "Debug-Ausgabe im Chat aktivieren",
    check_show_enemy = "Feindliche Namensleisten anzeigen",
    check_show_friendly = "Freundliche Namensleisten anzeigen",
    check_enemy_pets = "Feindliche Begleiter",
    check_enemy_guardians = "Feindliche Begleiterwesen",
    check_enemy_totems = "Feindliche Totems",
    check_enemy_minions = "Feindliche Diener",
    check_friendly_pets = "Freundliche Begleiter",
    check_friendly_guardians = "Freundliche Begleiterwesen",
    check_friendly_totems = "Freundliche Totems",
    check_friendly_minions = "Freundliche Diener",
    check_debuff_enemy = "Debuffs auf feindlichen Namensleisten anzeigen",
    check_buff_enemy = "Buffs auf feindlichen Namensleisten anzeigen",
    check_debuff_friendly = "Debuffs auf freundlichen Namensleisten anzeigen",
    check_buff_friendly = "Buffs auf freundlichen Namensleisten anzeigen",
    slider_max_buffs = "Max. Buff-Symbole",
    slider_max_debuffs = "Max. Debuff-Symbole",
    slider_name_size = "Namensschrift-Groesse",
    slider_combat_size = "Kampftext-Schriftgroesse",
    slider_target_boost = "Zielschrift-Verstaerkung",
    slider_global_scale = "Globale Skalierung",
    slider_width_scale = "Leistenbreite-Skalierung (echte Groesse)",
    slider_height_scale = "Leistenhoehe-Skalierung (echte Groesse)",
    slider_height_multiplier = "Zusaetzlicher Leistenhoehen-Multiplikator",
    slider_x_spacing = "Namensleisten-X-Abstand",
    slider_y_spacing = "Namensleisten-Y-Abstand",
    slider_target_scale = "Ziel-Skalierung",
    slider_max_distance = "Max. Namensleisten-Distanz",
    slider_cast_scale = "Zauberleisten-Skalierung",
    btn_recheck_scale = "Skalierung neu pruefen",
    texture_info = "Optional: LibSharedMedia-Statusbar-Name oder direkter Texturpfad.",
    health_texture = "Lebensleisten-Textur",
    cast_texture = "Zauberleisten-Textur",
    btn_apply_textures = "Texturen anwenden",
    btn_reset_textures = "Texturen zuruecksetzen",
    btn_list_lsm = "LSM-Liste",
    btn_vivid = "Kraeftig",
    btn_neutral = "Neutral",
    btn_soft = "Weich",
    preset_vivid = "Kraeftig",
    preset_neutral = "Neutral",
    preset_soft = "Weich",
    style_clean = "Klar",
    style_solid = "Solid",
    style_blizzard = "Blizzard",
    style_classic = "Klassisch",
    style_thin = "Duenn",
    style_thick = "Dick",
    style_compact = "Kompakt",
    style_wide = "Breit",
    palette_hint = "Farbfelder anklicken zum Anpassen",
    btn_apply_now = "Jetzt anwenden",
    btn_reset_defaults = "Standardwerte zuruecksetzen",
    options_hint = "/cp oeffnet diese Seite. Kategorien, Profile und Info sind unter AddOns -> CleanPlates.",
    color_enemy = "Feindlich",
    color_friendly = "Freundlich",
    color_neutral = "Neutral",
    color_target = "Zielname",
    color_cast_enemy = "Zauber: Feindlich",
    color_cast_locked = "Zauber: Gesperrt (ungenutzt)",
    color_cast_friendly = "Zauber: Freundlich",
    color_health_text = "Lebens-Text",
    profiles_title = "CleanPlates - Profile",
    profiles_subtitle = "Benannte Profile verwalten, importieren/exportieren und zuruecksetzen.",
    profiles_active = "Aktives Profil: %s",
    profile_name = "Profilname",
    btn_save_update = "Speichern/Aktualisieren",
    btn_load = "Laden",
    btn_delete = "Loeschen",
    btn_reset_active = "Aktives zuruecksetzen",
    saved_profiles = "Gespeicherte Profile",
    import_export = "Import-/Export-String",
    btn_fill_export = "Export fuellen",
    btn_import_string = "String importieren",
    btn_clear = "Leeren",
    io_hint = "Mit \"Export fuellen\" einen Share-String erzeugen. String einfuegen und \"String importieren\" klicken.",
    info_title = "CleanPlates - Info",
    info_body = "Version: %s\nAutor: enjoymygripz\n\nDieses Addon ist aktuell in Entwicklung.\nFunktionen und Verhalten koennen sich zwischen Updates aendern.\n\nMidnight-Stabilitaetsmodus:\n- Namensleisten-Frame-Styling ist wegen Taint-Schutz eingeschraenkt.\n- Lebensprozente sind wegen Secret Values deaktiviert.\n\nFeedback gerne als CurseForge-Kommentar oder per PN.\n\nMit /cp oder /cleanplates oeffnest du die Einstellungen.",
    nav_general = "Allgemein",
    nav_filters = "Filter",
    nav_aura = "Aura",
    nav_typography = "Typografie",
    nav_size = "Groesse & Skalierung",
    nav_plate_art = "Leistenstil",
    nav_palette = "Palette",
    nav_profiles = "Profile",
    nav_info = "Info",
    nav_desc_general = "Grundlegende Addon-Schalter und Verhalten.",
    nav_desc_filters = "Sichtbarkeit fuer Feind/Freund und Einheitstypen.",
    nav_desc_aura = "Aura-Sichtbarkeit und maximale Buff/Debuff-Anzahl.",
    nav_desc_typography = "Schriftgroesse fuer Name und Kampftext.",
    nav_desc_size = "Globale Groesse, Breite, Hoehe, Ziel-Skalierung und Distanz.",
    nav_desc_plate_art = "Visuelle Stil-Presets fuer Leistenform/-optik.",
    nav_desc_palette = "Farbfelder fuer Feind/Freund/Ziel/Zaubertext.",
    nav_desc_profiles = "Benannte Profile speichern/laden/importieren/exportieren.",
    nav_desc_info = "Addon-Status und kurze Release-Hinweise.",
    section_opening = "Abschnitt wird geoeffnet...",
    msg_color_picker_unavailable = "Color-Picker-API ist auf diesem Client nicht verfuegbar.",
    msg_health_percent_unavailable = "Lebens%% ist in Midnight nicht verfuegbar (Secret Values).",
    msg_no_texture_change = "Keine Texturaenderung angewendet.",
    msg_no_lsm_textures = "Keine externen LSM-Texturen gefunden.",
    msg_lsm_textures = "LSM-Statusbar-Texturen (%d): %s",
    msg_defaults_restored = "Standardwerte wiederhergestellt.",
    msg_profile_saved = "Profil gespeichert: %s",
    msg_profile_save_failed = "Speichern fehlgeschlagen: %s",
    msg_profile_loaded = "Profil geladen: %s",
    msg_profile_load_failed = "Laden fehlgeschlagen: %s",
    msg_profile_deleted = "Profil geloescht: %s",
    msg_profile_delete_failed = "Loeschen fehlgeschlagen: %s",
    msg_profile_reset = "Profil zurueckgesetzt: %s",
    msg_profile_reset_failed = "Zuruecksetzen fehlgeschlagen: %s",
    msg_profile_export_failed = "Profil konnte nicht exportiert werden.",
    msg_profile_imported = "Profil importiert.",
    msg_profile_import_failed = "Import fehlgeschlagen: %s",
}

local function buildLocaleTable()
    local fallback = CLIENT_LOCALE == "deDE" and setmetatable(STRINGS_DE, { __index = STRINGS_EN }) or STRINGS_EN
    local aceLocaleLib = nil
    if (type(LibStub) == "table" or type(LibStub) == "function") then
        local ok, lib = pcall(LibStub, "AceLocale-3.0", true)
        if ok then
            aceLocaleLib = lib
        end
    end
    if not aceLocaleLib then
        return fallback
    end

    local enLocale = aceLocaleLib:NewLocale("CleanPlates", "enUS", true)
    if enLocale then
        for key, value in pairs(STRINGS_EN) do
            enLocale[key] = value
        end
    end

    local deLocale = aceLocaleLib:NewLocale("CleanPlates", "deDE")
    if deLocale then
        for key, value in pairs(STRINGS_DE) do
            deLocale[key] = value
        end
    end

    local active = aceLocaleLib:GetLocale("CleanPlates", true)
    if type(active) == "table" then
        return setmetatable(active, { __index = STRINGS_EN })
    end
    return fallback
end

local ACTIVE_STRINGS = buildLocaleTable()
local function L(key, ...)
    local template = ACTIVE_STRINGS[key] or STRINGS_EN[key] or key
    if select("#", ...) > 0 then
        return string.format(template, ...)
    end
    return template
end

local colorFieldToTarget = {
    enemyColor = "enemy",
    friendlyColor = "friendly",
    neutralColor = "neutral",
    targetColor = "target",
    castInterruptibleColor = "castint",
    castUninterruptibleColor = "castlock",
    castFriendlyColor = "castfriendly",
    healthTextColor = "healthtext",
}

local function trim(text)
    if type(text) ~= "string" then
        return ""
    end
    return (text:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function setCheckLabel(checkButton, text)
    local label = _G[checkButton:GetName() .. "Text"]
    if label then
        label:SetText(text)
    end
end

local function setCheckEnabled(checkButton, enabled)
    if not checkButton then
        return
    end

    checkButton:SetEnabled(enabled)
    local label = _G[checkButton:GetName() .. "Text"]
    if label then
        if enabled then
            label:SetTextColor(1, 0.82, 0)
        else
            label:SetTextColor(0.5, 0.5, 0.5)
        end
    end
end

local function setSliderEnabled(slider, enabled)
    if not slider then
        return
    end

    slider:SetEnabled(enabled)
    local baseName = slider:GetName()
    if not baseName then
        return
    end

    local text = _G[baseName .. "Text"]
    local low = _G[baseName .. "Low"]
    local high = _G[baseName .. "High"]
    local r, g, b = 1, 0.82, 0
    if not enabled then
        r, g, b = 0.5, 0.5, 0.5
    end

    if text then
        text:SetTextColor(r, g, b)
    end
    if low then
        low:SetTextColor(r, g, b)
    end
    if high then
        high:SetTextColor(r, g, b)
    end
end

local function to255(value)
    return math.floor((value * 255) + 0.5)
end

local function applySettingsCategoryIcon(category)
    if not category then
        return
    end

    if type(category.SetIcon) == "function" then
        pcall(category.SetIcon, category, SETTINGS_ICON_TEXTURE)
        return
    end

    if type(category.SetIconTexture) == "function" then
        pcall(category.SetIconTexture, category, SETTINGS_ICON_TEXTURE)
    end
end

local function createSlider(name, parent, title, minValue, maxValue, step)
    local slider = CreateFrame("Slider", name, parent, "OptionsSliderTemplate")
    slider:SetWidth(250)
    slider:SetHeight(16)
    slider:SetMinMaxValues(minValue, maxValue)
    slider:SetValueStep(step)
    slider:SetObeyStepOnDrag(true)

    _G[name .. "Low"]:SetText(tostring(minValue))
    _G[name .. "High"]:SetText(tostring(maxValue))
    _G[name .. "Text"]:SetText(title)

    return slider
end

local function getCVarText(cvarName)
    if C_CVar and type(C_CVar.GetCVar) == "function" then
        local ok, value = pcall(C_CVar.GetCVar, cvarName)
        if ok and value ~= nil then
            return tostring(value)
        end
    end

    if type(GetCVar) == "function" then
        local ok, value = pcall(GetCVar, cvarName)
        if ok and value ~= nil then
            return tostring(value)
        end
    end

    local aliases = {
        nameplateGlobalScale = { "NamePlateGlobalScale" },
        nameplateHorizontalScale = { "NamePlateHorizontalScale" },
        nameplateVerticalScale = { "NamePlateVerticalScale" },
    }
    local candidates = aliases[cvarName]
    if type(candidates) == "table" then
        for i = 1, #candidates do
            local aliasName = candidates[i]
            if C_CVar and type(C_CVar.GetCVar) == "function" then
                local ok, value = pcall(C_CVar.GetCVar, aliasName)
                if ok and value ~= nil then
                    return tostring(value)
                end
            end

            if type(GetCVar) == "function" then
                local ok, value = pcall(GetCVar, aliasName)
                if ok and value ~= nil then
                    return tostring(value)
                end
            end
        end
    end

    return nil
end

local function getCVarNumber(cvarName)
    local value = tonumber(getCVarText(cvarName))
    if not value or value ~= value then
        return nil
    end
    return value
end

local function formatOptionalNumber(value, precision)
    if type(value) ~= "number" then
        return "n/a"
    end
    return string.format("%." .. tostring(precision or 2) .. "f", value)
end

local function updateColorControl(control, color)
    if not control or not color then
        return
    end

    if control.swatch then
        control.swatch:SetColorTexture(color.r, color.g, color.b, 1)
    end

    if control.value then
        control.value:SetText(string.format("%d,%d,%d", to255(color.r), to255(color.g), to255(color.b)))
    end
end

local function openColorPicker(fieldName)
    if not CleanPlates or not CleanPlates.db then
        return
    end

    local target = colorFieldToTarget[fieldName]
    local color = CleanPlates.db[fieldName]
    if not target or not color then
        return
    end

    if not ColorPickerFrame or type(ColorPickerFrame.SetupColorPickerAndShow) ~= "function" then
        CleanPlates:Print(L("msg_color_picker_unavailable"))
        return
    end

    local function applyFromPicker()
        local r, g, b = ColorPickerFrame:GetColorRGB()
        if not r or not g or not b then
            return
        end

        if CleanPlates:SetPaletteColor(target, r, g, b) then
            CleanPlates:Refresh()
            CleanPlates:RefreshOptions()
        end
    end

    local info = {
        r = color.r,
        g = color.g,
        b = color.b,
        hasOpacity = false,
        swatchFunc = applyFromPicker,
        cancelFunc = function(previousValues)
            if not previousValues then
                return
            end

            if CleanPlates:SetPaletteColor(target, previousValues.r, previousValues.g, previousValues.b) then
                CleanPlates:Refresh()
                CleanPlates:RefreshOptions()
            end
        end,
    }

    ColorPickerFrame:SetupColorPickerAndShow(info)
end

local function createColorControl(parent, x, y, labelText, fieldName)
    local control = CreateFrame("Frame", nil, parent)
    control:SetSize(240, 24)
    control:SetPoint("TOPLEFT", parent, "TOPLEFT", x, y)

    control.button = CreateFrame("Button", nil, control)
    control.button:SetSize(20, 20)
    control.button:SetPoint("LEFT", 0, 0)

    control.border = control.button:CreateTexture(nil, "BACKGROUND")
    control.border:SetAllPoints()
    control.border:SetColorTexture(0, 0, 0, 1)

    control.swatch = control.button:CreateTexture(nil, "ARTWORK")
    control.swatch:SetPoint("TOPLEFT", 1, -1)
    control.swatch:SetPoint("BOTTOMRIGHT", -1, 1)
    control.swatch:SetColorTexture(1, 1, 1, 1)

    control.label = control:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    control.label:SetPoint("LEFT", control.button, "RIGHT", 8, 0)
    control.label:SetText(labelText)

    control.value = control:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    control.value:SetPoint("LEFT", control.label, "RIGHT", 8, 0)
    control.value:SetText("0,0,0")

    control.button:SetScript("OnClick", function()
        openColorPicker(fieldName)
    end)

    return control
end

function CleanPlates:RefreshOptions()
    if not self.optionsFrame or not self.db then
        return
    end

    local frame = self.optionsFrame
    frame.syncing = true

    frame.controls.enabled:SetChecked(self.db.enabled)
    frame.controls.classColor:SetChecked(self.db.classColorPlayers)
    frame.controls.combatText:SetChecked(self.db.styleCombatText)
    frame.controls.castColors:SetChecked(self.db.enableCastStateColors)
    frame.controls.healthPercent:SetChecked(self.db.showHealthPercent)
    frame.controls.healthPercentEnemyOnly:SetChecked(self.db.healthPercentEnemiesOnly)
    frame.controls.targetHighlight:SetChecked(self.db.targetHighlight)
    frame.controls.questMarker:SetChecked(self.db.showQuestMarker)
    frame.controls.debug:SetChecked(self.db.debug)

    frame.controls.showEnemyPlates:SetChecked(self.db.showEnemyPlates)
    frame.controls.showFriendlyPlates:SetChecked(self.db.showFriendlyPlates)
    frame.controls.showEnemyPets:SetChecked(self.db.showEnemyPets)
    frame.controls.showEnemyGuardians:SetChecked(self.db.showEnemyGuardians)
    frame.controls.showEnemyTotems:SetChecked(self.db.showEnemyTotems)
    frame.controls.showEnemyMinions:SetChecked(self.db.showEnemyMinions)
    frame.controls.showFriendlyPets:SetChecked(self.db.showFriendlyPets)
    frame.controls.showFriendlyGuardians:SetChecked(self.db.showFriendlyGuardians)
    frame.controls.showFriendlyTotems:SetChecked(self.db.showFriendlyTotems)
    frame.controls.showFriendlyMinions:SetChecked(self.db.showFriendlyMinions)

    frame.controls.showDebuffsOnEnemy:SetChecked(self.db.showDebuffsOnEnemy)
    frame.controls.showBuffsOnEnemy:SetChecked(self.db.showBuffsOnEnemy)
    frame.controls.showDebuffsOnFriendly:SetChecked(self.db.showDebuffsOnFriendly)
    frame.controls.showBuffsOnFriendly:SetChecked(self.db.showBuffsOnFriendly)

    frame.controls.nameSize:SetValue(self.db.nameFontSize)
    frame.controls.combatSize:SetValue(self.db.combatTextFontSize)
    frame.controls.targetBoost:SetValue(self.db.targetFontBoost)
    frame.controls.maxBuffs:SetValue(self.db.maxBuffs)
    frame.controls.maxDebuffs:SetValue(self.db.maxDebuffs)
    frame.controls.globalScale:SetValue(self.db.nameplateGlobalScale)
    frame.controls.horizontalScale:SetValue(self.db.nameplateHorizontalScale)
    frame.controls.verticalScale:SetValue(self.db.nameplateVerticalScale)
    frame.controls.heightMultiplier:SetValue(self.db.nameplateHeightMultiplier)
    frame.controls.xSpacing:SetValue(self.db.nameplateXSpacing)
    frame.controls.ySpacing:SetValue(self.db.nameplateYSpacing)
    frame.controls.selectedScale:SetValue(self.db.nameplateSelectedScale)
    frame.controls.maxDistance:SetValue(self.db.nameplateMaxDistance)
    frame.controls.castBarScale:SetValue(self.db.castBarScale)

    if frame.sliderLabelUpdaters then
        frame.sliderLabelUpdaters.nameSize(self.db.nameFontSize)
        frame.sliderLabelUpdaters.combatSize(self.db.combatTextFontSize)
        frame.sliderLabelUpdaters.targetBoost(self.db.targetFontBoost)
        frame.sliderLabelUpdaters.maxBuffs(self.db.maxBuffs)
        frame.sliderLabelUpdaters.maxDebuffs(self.db.maxDebuffs)
        frame.sliderLabelUpdaters.globalScale(self.db.nameplateGlobalScale)
        frame.sliderLabelUpdaters.horizontalScale(self.db.nameplateHorizontalScale)
        frame.sliderLabelUpdaters.verticalScale(self.db.nameplateVerticalScale)
        frame.sliderLabelUpdaters.heightMultiplier(self.db.nameplateHeightMultiplier)
        frame.sliderLabelUpdaters.xSpacing(self.db.nameplateXSpacing)
        frame.sliderLabelUpdaters.ySpacing(self.db.nameplateYSpacing)
        frame.sliderLabelUpdaters.selectedScale(self.db.nameplateSelectedScale)
        frame.sliderLabelUpdaters.maxDistance(self.db.nameplateMaxDistance)
        frame.sliderLabelUpdaters.castBarScale(self.db.castBarScale)
    end

    if frame.controls.scaleLiveStatus then
        local style = self.GetPlateArtStyleConfig and self:GetPlateArtStyleConfig() or nil
        local function styleMult(key)
            local value = style and style[key]
            if type(value) ~= "number" then
                return 1
            end
            return value
        end
        local targetGlobal = math.min(2.0, math.max(0.6, self.db.nameplateGlobalScale * styleMult("globalScaleMult")))
        local targetHorizontal = math.min(1.8, math.max(0.6, self.db.nameplateHorizontalScale * styleMult("horizontalScaleMult")))
        local targetVertical = math.min(2.5, math.max(0.6, (self.db.nameplateVerticalScale * styleMult("verticalScaleMult")) * (self.db.nameplateHeightMultiplier or 1)))
        local targetSelected = math.min(2.5, math.max(1.0, self.db.nameplateSelectedScale * styleMult("selectedScaleMult")))
        local liveGlobal = getCVarNumber("nameplateGlobalScale")
        local liveHorizontal = getCVarNumber("nameplateHorizontalScale")
        local liveVertical = getCVarNumber("nameplateVerticalScale")
        local liveSelected = getCVarNumber("nameplateSelectedScale")
        local liveDistance = getCVarNumber("nameplateMaxDistance")
        local requestedDistance = math.floor((self.db.nameplateMaxDistance or 0) + 0.5)
        local sizeMode = tostring(self.nameplateSizeMode or "unknown")
        local statusLine = string.format(
            L("scale_status"),
            formatOptionalNumber(liveGlobal, 2),
            formatOptionalNumber(liveHorizontal, 2),
            formatOptionalNumber(liveVertical, 2),
            formatOptionalNumber(liveSelected, 2),
            formatOptionalNumber(liveDistance, 0),
            targetGlobal,
            targetHorizontal,
            targetVertical,
            targetSelected,
            requestedDistance,
            sizeMode
        )
        frame.controls.scaleLiveStatus:SetText(statusLine .. "\n" .. L(
            "scale_extra",
            self.db.nameplateHeightMultiplier or 1,
            self.db.nameplateXSpacing or 0.8,
            self.db.nameplateYSpacing or 1.1
        ))
    end

    frame.controls.activePreset:SetText(L("active_preset", self:GetActivePreset()))
    frame.controls.activeStyle:SetText(L("active_style", tostring(self.db.plateArtStyle or "clean")))
    if frame.controls.healthTextureBox and (not frame.controls.healthTextureBox.HasFocus or not frame.controls.healthTextureBox:HasFocus()) then
        frame.controls.healthTextureBox:SetText(tostring(self.db.healthTexture or ""))
    end
    if frame.controls.castTextureBox and (not frame.controls.castTextureBox.HasFocus or not frame.controls.castTextureBox:HasFocus()) then
        frame.controls.castTextureBox:SetText(tostring(self.db.castTexture or ""))
    end
    if frame.controls.textureResolved then
        local resolvedHealth = self.GetResolvedHealthTexture and self:GetResolvedHealthTexture() or tostring(self.db.healthTexture or "")
        local resolvedCast = self.GetResolvedCastTexture and self:GetResolvedCastTexture() or tostring(self.db.castTexture or "")
        frame.controls.textureResolved:SetText(L("resolved_textures", tostring(resolvedHealth), tostring(resolvedCast)))
    end

    updateColorControl(frame.controls.enemyColor, self.db.enemyColor)
    updateColorControl(frame.controls.friendlyColor, self.db.friendlyColor)
    updateColorControl(frame.controls.neutralColor, self.db.neutralColor)
    updateColorControl(frame.controls.targetColor, self.db.targetColor)
    updateColorControl(frame.controls.castInterruptibleColor, self.db.castInterruptibleColor)
    updateColorControl(frame.controls.castUninterruptibleColor, self.db.castUninterruptibleColor)
    updateColorControl(frame.controls.castFriendlyColor, self.db.castFriendlyColor)
    updateColorControl(frame.controls.healthTextColor, self.db.healthTextColor)

    -- Midnight blocks safe health values on nameplates ("Secret Values"), keep controls visibly disabled.
    setCheckEnabled(frame.controls.healthPercent, false)
    setCheckEnabled(frame.controls.healthPercentEnemyOnly, false)
    setCheckEnabled(frame.controls.showEnemyPets, self.db.showEnemyPlates)
    setCheckEnabled(frame.controls.showEnemyGuardians, self.db.showEnemyPlates)
    setCheckEnabled(frame.controls.showEnemyTotems, self.db.showEnemyPlates)
    setCheckEnabled(frame.controls.showEnemyMinions, self.db.showEnemyPlates)
    setCheckEnabled(frame.controls.showFriendlyPets, self.db.showFriendlyPlates)
    setCheckEnabled(frame.controls.showFriendlyGuardians, self.db.showFriendlyPlates)
    setCheckEnabled(frame.controls.showFriendlyTotems, self.db.showFriendlyPlates)
    setCheckEnabled(frame.controls.showFriendlyMinions, self.db.showFriendlyPlates)
    setCheckEnabled(frame.controls.showDebuffsOnEnemy, self.db.showEnemyPlates)
    setCheckEnabled(frame.controls.showBuffsOnEnemy, self.db.showEnemyPlates)
    setCheckEnabled(frame.controls.showDebuffsOnFriendly, self.db.showFriendlyPlates)
    setCheckEnabled(frame.controls.showBuffsOnFriendly, self.db.showFriendlyPlates)

    local auraControlsEnabled = self.db.showEnemyPlates or self.db.showFriendlyPlates
    setSliderEnabled(frame.controls.maxBuffs, auraControlsEnabled)
    setSliderEnabled(frame.controls.maxDebuffs, auraControlsEnabled)

    local nameStylingSupported = self.IsNameStylingSupported and self:IsNameStylingSupported() or false
    setSliderEnabled(frame.controls.nameSize, nameStylingSupported)
    setSliderEnabled(frame.controls.targetBoost, nameStylingSupported)
    if frame.controls.typographyHint then
        if nameStylingSupported then
            frame.controls.typographyHint:SetText(L("typography_active"))
            frame.controls.typographyHint:SetTextColor(0.65, 1.0, 0.65)
        else
            frame.controls.typographyHint:SetText(L("typography_disabled"))
            frame.controls.typographyHint:SetTextColor(1.0, 0.45, 0.35)
        end
    end

    local activeStyle = tostring(self.db.plateArtStyle or "clean")
    if frame.controls.styleButtonsByName then
        for styleName, button in pairs(frame.controls.styleButtonsByName) do
            local isActiveStyle = styleName == activeStyle
            button:SetEnabled(not isActiveStyle)
            local label = button:GetFontString()
            if label then
                if isActiveStyle then
                    label:SetTextColor(1, 0.82, 0)
                else
                    label:SetTextColor(1, 1, 1)
                end
            end
        end
    end

    frame.syncing = false

    if self.RefreshProfilesOptions then
        self:RefreshProfilesOptions()
    end
end

function CleanPlates:CreateOptions()
    if self.optionsFrame then
        return self.optionsFrame
    end

    local frame = CreateFrame("Frame", "CleanPlatesSettingsCanvas", UIParent)
    frame:SetSize(820, 620)
    frame:Hide()

    frame.title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    frame.title:SetPoint("TOPLEFT", 16, -16)
    frame.title:SetText(L("addon_title"))

    frame.subtitle = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.subtitle:SetPoint("TOPLEFT", frame.title, "BOTTOMLEFT", 0, -4)
    frame.subtitle:SetText(L("addon_subtitle"))

    local scrollFrame = CreateFrame("ScrollFrame", "CleanPlatesSettingsScrollFrame", frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -52)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 12)

    local content = CreateFrame("Frame", "CleanPlatesSettingsScrollContent", scrollFrame)
    content:SetSize(760, 1800)
    scrollFrame:SetScrollChild(content)

    frame.content = content
    frame.scrollFrame = scrollFrame
    frame.sectionOffsets = {}

    frame:SetScript("OnSizeChanged", function(_, width)
        local contentWidth = math.max(width - 52, 620)
        content:SetWidth(contentWidth)
    end)

    local baseX = 18
    local y = -16

    local function addSectionHeader(sectionKey, text)
        local key = sectionKey or text
        local header = content:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
        header:SetPoint("TOPLEFT", content, "TOPLEFT", baseX, y)
        header:SetText(text)
        frame.sectionOffsets[key] = math.max(0, (-y) - 8)
        y = y - 28
        return header
    end

    local function addCheckButton(globalName, labelText, onClick, indent)
        local check = CreateFrame("CheckButton", globalName, content, "UICheckButtonTemplate")
        check:SetPoint("TOPLEFT", content, "TOPLEFT", baseX + (indent or 0), y)
        setCheckLabel(check, labelText)
        check:SetScript("OnClick", onClick)
        y = y - 24
        return check
    end

    local function addSliderWithLabel(name, title, minValue, maxValue, step, precision, applyValue)
        local slider = createSlider(name, content, title, minValue, maxValue, step)
        slider:SetPoint("TOPLEFT", content, "TOPLEFT", baseX + 6, y)

        local textObject = _G[name .. "Text"]
        local function updateText(value)
            if precision == 0 then
                textObject:SetText(string.format("%s: %d", title, math.floor(value + 0.5)))
            else
                textObject:SetText(string.format("%s: %." .. precision .. "f", title, value))
            end
        end

        slider:SetScript("OnValueChanged", function(_, value)
            if precision == 0 then
                value = math.floor(value + 0.5)
            else
                local scale = 10 ^ precision
                value = math.floor((value * scale) + 0.5) / scale
            end
            updateText(value)
            if frame.syncing then
                return
            end
            applyValue(value)
            CleanPlates:Refresh()
        end)

        y = y - 54
        return slider, updateText
    end

    addSectionHeader("General", L("section_general"))

    local enabled = addCheckButton("CleanPlatesOptionEnabled", L("check_enabled"), function(button)
        CleanPlates.db.enabled = button:GetChecked() and true or false
        CleanPlates:Refresh()
    end)

    local classColor = addCheckButton("CleanPlatesOptionClassColor", L("check_class_color"), function(button)
        CleanPlates.db.classColorPlayers = button:GetChecked() and true or false
        CleanPlates:Refresh()
    end)

    local combatText = addCheckButton("CleanPlatesOptionCombatText", L("check_combat_text"), function(button)
        CleanPlates.db.styleCombatText = button:GetChecked() and true or false
        CleanPlates:Refresh()
    end)

    local castColors = addCheckButton("CleanPlatesOptionCastColors", L("check_cast_colors"), function(button)
        CleanPlates.db.enableCastStateColors = button:GetChecked() and true or false
        CleanPlates:Refresh()
    end)

    local healthPercent = addCheckButton("CleanPlatesOptionHealthPercent", L("check_health_percent"), function(button)
        local wantsEnabled = button:GetChecked() and true or false
        if wantsEnabled then
            CleanPlates.db.showHealthPercent = false
            CleanPlates.healthPercentBlocked = true
            CleanPlates:Print(L("msg_health_percent_unavailable"))
        else
            CleanPlates.db.showHealthPercent = false
        end
        CleanPlates:Refresh()
        CleanPlates:RefreshOptions()
    end)

    local healthPercentEnemyOnly = addCheckButton("CleanPlatesOptionHealthPercentEnemyOnly", L("check_health_percent_enemy_only"), function(button)
        CleanPlates.db.healthPercentEnemiesOnly = button:GetChecked() and true or false
        CleanPlates:Refresh()
    end, 14)

    local targetHighlight = addCheckButton("CleanPlatesOptionTargetHighlight", L("check_target_highlight"), function(button)
        CleanPlates.db.targetHighlight = button:GetChecked() and true or false
        CleanPlates:Refresh()
    end)

    local questMarker = addCheckButton("CleanPlatesOptionQuestMarker", L("check_quest_marker"), function(button)
        CleanPlates.db.showQuestMarker = button:GetChecked() and true or false
        CleanPlates:Refresh()
    end)

    local debug = addCheckButton("CleanPlatesOptionDebug", L("check_debug"), function(button)
        CleanPlates.db.debug = button:GetChecked() and true or false
    end)

    y = y - 12
    addSectionHeader("Nameplate Filters", L("section_filters"))

    local showEnemyPlates = addCheckButton("CleanPlatesOptionShowEnemyPlates", L("check_show_enemy"), function(button)
        CleanPlates.db.showEnemyPlates = button:GetChecked() and true or false
        CleanPlates:RefreshOptions()
        CleanPlates:Refresh()
    end)

    local showEnemyPets = addCheckButton("CleanPlatesOptionShowEnemyPets", L("check_enemy_pets"), function(button)
        CleanPlates.db.showEnemyPets = button:GetChecked() and true or false
        CleanPlates:Refresh()
    end, 14)

    local showEnemyGuardians = addCheckButton("CleanPlatesOptionShowEnemyGuardians", L("check_enemy_guardians"), function(button)
        CleanPlates.db.showEnemyGuardians = button:GetChecked() and true or false
        CleanPlates:Refresh()
    end, 14)

    local showEnemyTotems = addCheckButton("CleanPlatesOptionShowEnemyTotems", L("check_enemy_totems"), function(button)
        CleanPlates.db.showEnemyTotems = button:GetChecked() and true or false
        CleanPlates:Refresh()
    end, 14)

    local showEnemyMinions = addCheckButton("CleanPlatesOptionShowEnemyMinions", L("check_enemy_minions"), function(button)
        CleanPlates.db.showEnemyMinions = button:GetChecked() and true or false
        CleanPlates:Refresh()
    end, 14)

    local showFriendlyPlates = addCheckButton("CleanPlatesOptionShowFriendlyPlates", L("check_show_friendly"), function(button)
        CleanPlates.db.showFriendlyPlates = button:GetChecked() and true or false
        CleanPlates:RefreshOptions()
        CleanPlates:Refresh()
    end)

    local showFriendlyPets = addCheckButton("CleanPlatesOptionShowFriendlyPets", L("check_friendly_pets"), function(button)
        CleanPlates.db.showFriendlyPets = button:GetChecked() and true or false
        CleanPlates:Refresh()
    end, 14)

    local showFriendlyGuardians = addCheckButton("CleanPlatesOptionShowFriendlyGuardians", L("check_friendly_guardians"), function(button)
        CleanPlates.db.showFriendlyGuardians = button:GetChecked() and true or false
        CleanPlates:Refresh()
    end, 14)

    local showFriendlyTotems = addCheckButton("CleanPlatesOptionShowFriendlyTotems", L("check_friendly_totems"), function(button)
        CleanPlates.db.showFriendlyTotems = button:GetChecked() and true or false
        CleanPlates:Refresh()
    end, 14)

    local showFriendlyMinions = addCheckButton("CleanPlatesOptionShowFriendlyMinions", L("check_friendly_minions"), function(button)
        CleanPlates.db.showFriendlyMinions = button:GetChecked() and true or false
        CleanPlates:Refresh()
    end, 14)

    y = y - 12
    addSectionHeader("Aura Display", L("section_aura"))

    local showDebuffsOnEnemy = addCheckButton("CleanPlatesOptionDebuffsEnemy", L("check_debuff_enemy"), function(button)
        CleanPlates.db.showDebuffsOnEnemy = button:GetChecked() and true or false
        CleanPlates:Refresh()
    end)

    local showBuffsOnEnemy = addCheckButton("CleanPlatesOptionBuffsEnemy", L("check_buff_enemy"), function(button)
        CleanPlates.db.showBuffsOnEnemy = button:GetChecked() and true or false
        CleanPlates:Refresh()
    end)

    local showDebuffsOnFriendly = addCheckButton("CleanPlatesOptionDebuffsFriendly", L("check_debuff_friendly"), function(button)
        CleanPlates.db.showDebuffsOnFriendly = button:GetChecked() and true or false
        CleanPlates:Refresh()
    end)

    local showBuffsOnFriendly = addCheckButton("CleanPlatesOptionBuffsFriendly", L("check_buff_friendly"), function(button)
        CleanPlates.db.showBuffsOnFriendly = button:GetChecked() and true or false
        CleanPlates:Refresh()
    end)

    y = y - 18
    local maxBuffs, updateMaxBuffs = addSliderWithLabel(
        "CleanPlatesMaxBuffsSlider",
        L("slider_max_buffs"),
        0,
        8,
        1,
        0,
        function(value)
            CleanPlates.db.maxBuffs = value
        end
    )

    local maxDebuffs, updateMaxDebuffs = addSliderWithLabel(
        "CleanPlatesMaxDebuffsSlider",
        L("slider_max_debuffs"),
        0,
        8,
        1,
        0,
        function(value)
            CleanPlates.db.maxDebuffs = value
        end
    )

    y = y - 12
    addSectionHeader("Typography", L("section_typography"))

    local typographyHint = content:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    typographyHint:SetPoint("TOPLEFT", content, "TOPLEFT", baseX + 4, y)
    typographyHint:SetWidth(700)
    typographyHint:SetJustifyH("LEFT")
    typographyHint:SetText("")
    y = y - 18

    local nameSize, updateNameSize = addSliderWithLabel(
        "CleanPlatesNameSizeSlider",
        L("slider_name_size"),
        8,
        24,
        1,
        0,
        function(value)
            CleanPlates.db.nameFontSize = value
        end
    )

    local combatSize, updateCombatSize = addSliderWithLabel(
        "CleanPlatesCombatSizeSlider",
        L("slider_combat_size"),
        16,
        40,
        1,
        0,
        function(value)
            CleanPlates.db.combatTextFontSize = value
        end
    )

    local targetBoost, updateTargetBoost = addSliderWithLabel(
        "CleanPlatesTargetBoostSlider",
        L("slider_target_boost"),
        0,
        8,
        1,
        0,
        function(value)
            CleanPlates.db.targetFontBoost = value
        end
    )

    y = y - 12
    addSectionHeader("Size And Scale", L("section_size"))

    local globalScale, updateGlobalScale = addSliderWithLabel(
        "CleanPlatesGlobalScaleSlider",
        L("slider_global_scale"),
        0.60,
        2.00,
        0.01,
        2,
        function(value)
            CleanPlates.db.nameplateGlobalScale = value
        end
    )

    local horizontalScale, updateHorizontalScale = addSliderWithLabel(
        "CleanPlatesHorizontalScaleSlider",
        L("slider_width_scale"),
        0.60,
        1.80,
        0.01,
        2,
        function(value)
            CleanPlates.db.nameplateHorizontalScale = value
        end
    )

    local verticalScale, updateVerticalScale = addSliderWithLabel(
        "CleanPlatesVerticalScaleSlider",
        L("slider_height_scale"),
        0.60,
        2.00,
        0.01,
        2,
        function(value)
            CleanPlates.db.nameplateVerticalScale = value
        end
    )

    local heightMultiplier, updateHeightMultiplier = addSliderWithLabel(
        "CleanPlatesHeightMultiplierSlider",
        L("slider_height_multiplier"),
        0.50,
        2.50,
        0.01,
        2,
        function(value)
            CleanPlates.db.nameplateHeightMultiplier = value
        end
    )

    local xSpacing, updateXSpacing = addSliderWithLabel(
        "CleanPlatesXSpacingSlider",
        L("slider_x_spacing"),
        0.05,
        2.00,
        0.01,
        2,
        function(value)
            CleanPlates.db.nameplateXSpacing = value
        end
    )

    local ySpacing, updateYSpacing = addSliderWithLabel(
        "CleanPlatesYSpacingSlider",
        L("slider_y_spacing"),
        0.05,
        2.00,
        0.01,
        2,
        function(value)
            CleanPlates.db.nameplateYSpacing = value
        end
    )

    local selectedScale, updateSelectedScale = addSliderWithLabel(
        "CleanPlatesSelectedScaleSlider",
        L("slider_target_scale"),
        1.00,
        2.50,
        0.01,
        2,
        function(value)
            CleanPlates.db.nameplateSelectedScale = value
        end
    )

    local maxDistance, updateMaxDistance = addSliderWithLabel(
        "CleanPlatesMaxDistanceSlider",
        L("slider_max_distance"),
        20,
        100,
        1,
        0,
        function(value)
            CleanPlates.db.nameplateMaxDistance = value
        end
    )

    local castBarScale, updateCastBarScale = addSliderWithLabel(
        "CleanPlatesCastbarScaleSlider",
        L("slider_cast_scale"),
        0.60,
        2.00,
        0.01,
        2,
        function(value)
            CleanPlates.db.castBarScale = value
        end
    )

    local scaleLiveStatus = content:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    scaleLiveStatus:SetPoint("TOPLEFT", content, "TOPLEFT", baseX + 4, y + 8)
    scaleLiveStatus:SetWidth(700)
    scaleLiveStatus:SetJustifyH("LEFT")
    scaleLiveStatus:SetText(L("scale_status_pending"))
    y = y - 22

    local recheckScaleButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    recheckScaleButton:SetSize(130, 22)
    recheckScaleButton:SetPoint("TOPLEFT", content, "TOPLEFT", baseX, y)
    recheckScaleButton:SetText(L("btn_recheck_scale"))
    recheckScaleButton:SetScript("OnClick", function()
        CleanPlates.forceCVarReapply = true
        CleanPlates:Refresh()
        CleanPlates:RefreshOptions()
    end)
    y = y - 32

    y = y - 12
    addSectionHeader("Plate Art", L("section_plate_art"))

    local activeStyle = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    activeStyle:SetPoint("TOPLEFT", content, "TOPLEFT", baseX + 4, y)
    activeStyle:SetText(L("active_style", "clean"))
    y = y - 26

    local styleLabels = {
        clean = L("style_clean"),
        solid = L("style_solid"),
        blizzard = L("style_blizzard"),
        classic = L("style_classic"),
        thin = L("style_thin"),
        thick = L("style_thick"),
        compact = L("style_compact"),
        wide = L("style_wide"),
    }

    local styleOrder = CleanPlates.GetPlateArtStyleNames and CleanPlates:GetPlateArtStyleNames() or {
        "clean", "solid", "blizzard", "classic", "thin", "thick", "compact", "wide",
    }
    local styleButtons = {}
    local styleButtonsByName = {}
    local styleColumns = 4
    local buttonWidth = 90
    local buttonHeight = 22
    local spacingX = 8
    local spacingY = 6

    for i = 1, #styleOrder do
        local styleName = styleOrder[i]
        local row = math.floor((i - 1) / styleColumns)
        local col = (i - 1) % styleColumns

        local button = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
        button:SetSize(buttonWidth, buttonHeight)
        button:SetPoint(
            "TOPLEFT",
            content,
            "TOPLEFT",
            baseX + (col * (buttonWidth + spacingX)),
            y - (row * (buttonHeight + spacingY))
        )
        button:SetText(styleLabels[styleName] or styleName)
        button:SetScript("OnClick", function()
            CleanPlates:SetPlateArtStyle(styleName)
        end)
        styleButtons[#styleButtons + 1] = button
        styleButtonsByName[styleName] = button
    end

    local styleRows = math.max(1, math.ceil(#styleOrder / styleColumns))
    y = y - (styleRows * (buttonHeight + spacingY)) - 8

    addSectionHeader("External Textures (LSM)", L("section_external_textures"))

    local textureInfo = content:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    textureInfo:SetPoint("TOPLEFT", content, "TOPLEFT", baseX + 4, y)
    textureInfo:SetText(L("texture_info"))
    y = y - 24

    local healthTextureLabel = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    healthTextureLabel:SetPoint("TOPLEFT", content, "TOPLEFT", baseX + 4, y)
    healthTextureLabel:SetText(L("health_texture"))
    y = y - 20

    local healthTextureBox = CreateFrame("EditBox", "CleanPlatesHealthTextureBox", content, "InputBoxTemplate")
    healthTextureBox:SetSize(360, 22)
    healthTextureBox:SetPoint("TOPLEFT", content, "TOPLEFT", baseX, y)
    healthTextureBox:SetAutoFocus(false)
    healthTextureBox:SetScript("OnEscapePressed", function(editBox)
        editBox:ClearFocus()
    end)
    y = y - 30

    local castTextureLabel = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    castTextureLabel:SetPoint("TOPLEFT", content, "TOPLEFT", baseX + 4, y)
    castTextureLabel:SetText(L("cast_texture"))
    y = y - 20

    local castTextureBox = CreateFrame("EditBox", "CleanPlatesCastTextureBox", content, "InputBoxTemplate")
    castTextureBox:SetSize(360, 22)
    castTextureBox:SetPoint("TOPLEFT", content, "TOPLEFT", baseX, y)
    castTextureBox:SetAutoFocus(false)
    castTextureBox:SetScript("OnEscapePressed", function(editBox)
        editBox:ClearFocus()
    end)
    y = y - 34

    local applyTexturesButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    applyTexturesButton:SetSize(110, 22)
    applyTexturesButton:SetPoint("TOPLEFT", content, "TOPLEFT", baseX, y)
    applyTexturesButton:SetText(L("btn_apply_textures"))
    applyTexturesButton:SetScript("OnClick", function()
        local healthTexture = trim(healthTextureBox:GetText() or "")
        local castTexture = trim(castTextureBox:GetText() or "")
        local changed = false

        if healthTexture ~= "" then
            local ok = CleanPlates:SetTextureSelection("health", healthTexture)
            changed = changed or ok
        end
        if castTexture ~= "" then
            local ok = CleanPlates:SetTextureSelection("cast", castTexture)
            changed = changed or ok
        end

        if changed then
            CleanPlates:RefreshOptions()
        else
            CleanPlates:Print(L("msg_no_texture_change"))
        end
    end)

    local resetTexturesButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    resetTexturesButton:SetSize(120, 22)
    resetTexturesButton:SetPoint("LEFT", applyTexturesButton, "RIGHT", 8, 0)
    resetTexturesButton:SetText(L("btn_reset_textures"))
    resetTexturesButton:SetScript("OnClick", function()
        CleanPlates:SetTextureSelection("health", "default")
        CleanPlates:SetTextureSelection("cast", "default")
        CleanPlates:RefreshOptions()
    end)

    local listTexturesButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    listTexturesButton:SetSize(90, 22)
    listTexturesButton:SetPoint("LEFT", resetTexturesButton, "RIGHT", 8, 0)
    listTexturesButton:SetText(L("btn_list_lsm"))
    listTexturesButton:SetScript("OnClick", function()
        local names = CleanPlates:GetAvailableStatusBarTextures()
        if #names == 0 then
            CleanPlates:Print(L("msg_no_lsm_textures"))
            return
        end
        CleanPlates:Print(L("msg_lsm_textures", #names, table.concat(names, ", ")))
    end)

    y = y - 28
    local textureResolved = content:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    textureResolved:SetPoint("TOPLEFT", content, "TOPLEFT", baseX + 4, y)
    textureResolved:SetWidth(700)
    textureResolved:SetJustifyH("LEFT")
    textureResolved:SetText(L("resolved_textures", "<default>", "<default>"))
    y = y - 22

    addSectionHeader("Quick Presets", L("section_presets"))

    local activePreset = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    activePreset:SetPoint("TOPLEFT", content, "TOPLEFT", baseX + 4, y)
    activePreset:SetText(L("active_preset", "-"))
    y = y - 26

    local vividButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    vividButton:SetSize(90, 22)
    vividButton:SetPoint("TOPLEFT", content, "TOPLEFT", baseX, y)
    vividButton:SetText(L("preset_vivid"))
    vividButton:SetScript("OnClick", function()
        CleanPlates:ApplyPreset("vivid")
    end)

    local neutralButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    neutralButton:SetSize(90, 22)
    neutralButton:SetPoint("LEFT", vividButton, "RIGHT", 8, 0)
    neutralButton:SetText(L("preset_neutral"))
    neutralButton:SetScript("OnClick", function()
        CleanPlates:ApplyPreset("neutral")
    end)

    local softButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    softButton:SetSize(90, 22)
    softButton:SetPoint("LEFT", neutralButton, "RIGHT", 8, 0)
    softButton:SetText(L("preset_soft"))
    softButton:SetScript("OnClick", function()
        CleanPlates:ApplyPreset("soft")
    end)

    y = y - 38
    addSectionHeader("Palette", L("section_palette"))

    local colorHint = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    colorHint:SetPoint("TOPLEFT", content, "TOPLEFT", baseX + 4, y)
    colorHint:SetText(L("palette_hint"))
    y = y - 28

    local enemyColor = createColorControl(content, baseX, y, L("color_enemy"), "enemyColor")
    y = y - 30
    local friendlyColor = createColorControl(content, baseX, y, L("color_friendly"), "friendlyColor")
    y = y - 30
    local neutralColor = createColorControl(content, baseX, y, L("color_neutral"), "neutralColor")
    y = y - 30
    local targetColor = createColorControl(content, baseX, y, L("color_target"), "targetColor")
    y = y - 30
    local castInterruptibleColor = createColorControl(content, baseX, y, L("color_cast_enemy"), "castInterruptibleColor")
    y = y - 30
    local castUninterruptibleColor = createColorControl(content, baseX, y, L("color_cast_locked"), "castUninterruptibleColor")
    y = y - 30
    local castFriendlyColor = createColorControl(content, baseX, y, L("color_cast_friendly"), "castFriendlyColor")
    y = y - 30
    local healthTextColor = createColorControl(content, baseX, y, L("color_health_text"), "healthTextColor")
    y = y - 40

    local applyButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    applyButton:SetSize(110, 24)
    applyButton:SetPoint("TOPLEFT", content, "TOPLEFT", baseX, y)
    applyButton:SetText(L("btn_apply_now"))
    applyButton:SetScript("OnClick", function()
        CleanPlates:Refresh()
    end)

    local resetButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    resetButton:SetSize(130, 24)
    resetButton:SetPoint("LEFT", applyButton, "RIGHT", 10, 0)
    resetButton:SetText(L("btn_reset_defaults"))
    resetButton:SetScript("OnClick", function()
        CleanPlates:ResetToDefaults()
        CleanPlates:RefreshOptions()
        CleanPlates:Refresh()
        CleanPlates:Print(L("msg_defaults_restored"))
    end)

    local hint = content:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    hint:SetPoint("TOPLEFT", applyButton, "BOTTOMLEFT", 0, -10)
    hint:SetText(L("options_hint"))

    y = y - 110
    content:SetHeight(math.max(1800, -y))

    frame.controls = {
        enabled = enabled,
        classColor = classColor,
        combatText = combatText,
        castColors = castColors,
        healthPercent = healthPercent,
        healthPercentEnemyOnly = healthPercentEnemyOnly,
        targetHighlight = targetHighlight,
        questMarker = questMarker,
        debug = debug,
        showEnemyPlates = showEnemyPlates,
        showFriendlyPlates = showFriendlyPlates,
        showEnemyPets = showEnemyPets,
        showEnemyGuardians = showEnemyGuardians,
        showEnemyTotems = showEnemyTotems,
        showEnemyMinions = showEnemyMinions,
        showFriendlyPets = showFriendlyPets,
        showFriendlyGuardians = showFriendlyGuardians,
        showFriendlyTotems = showFriendlyTotems,
        showFriendlyMinions = showFriendlyMinions,
        showDebuffsOnEnemy = showDebuffsOnEnemy,
        showBuffsOnEnemy = showBuffsOnEnemy,
        showDebuffsOnFriendly = showDebuffsOnFriendly,
        showBuffsOnFriendly = showBuffsOnFriendly,
        typographyHint = typographyHint,
        nameSize = nameSize,
        combatSize = combatSize,
        targetBoost = targetBoost,
        maxBuffs = maxBuffs,
        maxDebuffs = maxDebuffs,
        globalScale = globalScale,
        horizontalScale = horizontalScale,
        verticalScale = verticalScale,
        heightMultiplier = heightMultiplier,
        xSpacing = xSpacing,
        ySpacing = ySpacing,
        selectedScale = selectedScale,
        maxDistance = maxDistance,
        castBarScale = castBarScale,
        scaleLiveStatus = scaleLiveStatus,
        recheckScaleButton = recheckScaleButton,
        activePreset = activePreset,
        activeStyle = activeStyle,
        healthTextureBox = healthTextureBox,
        castTextureBox = castTextureBox,
        textureResolved = textureResolved,
        styleButtons = styleButtons,
        styleButtonsByName = styleButtonsByName,
        enemyColor = enemyColor,
        friendlyColor = friendlyColor,
        neutralColor = neutralColor,
        targetColor = targetColor,
        castInterruptibleColor = castInterruptibleColor,
        castUninterruptibleColor = castUninterruptibleColor,
        castFriendlyColor = castFriendlyColor,
        healthTextColor = healthTextColor,
    }

    frame.sliderLabelUpdaters = {
        nameSize = updateNameSize,
        combatSize = updateCombatSize,
        targetBoost = updateTargetBoost,
        maxBuffs = updateMaxBuffs,
        maxDebuffs = updateMaxDebuffs,
        globalScale = updateGlobalScale,
        horizontalScale = updateHorizontalScale,
        verticalScale = updateVerticalScale,
        heightMultiplier = updateHeightMultiplier,
        xSpacing = updateXSpacing,
        ySpacing = updateYSpacing,
        selectedScale = updateSelectedScale,
        maxDistance = updateMaxDistance,
        castBarScale = updateCastBarScale,
    }

    frame.OnRefresh = function()
        CleanPlates:RefreshOptions()
    end

    frame.OnDefault = function()
        CleanPlates:ResetToDefaults()
        CleanPlates:RefreshOptions()
        CleanPlates:Refresh()
    end

    self.optionsFrame = frame
    self:RefreshOptions()
    return frame
end

function CleanPlates:ScrollOptionsToSection(sectionName)
    if type(sectionName) ~= "string" or sectionName == "" then
        return false
    end

    local frame = self.optionsFrame
    if not frame then
        frame = self:CreateOptions()
    end
    if not frame or not frame.scrollFrame or not frame.sectionOffsets then
        return false
    end

    local offset = frame.sectionOffsets[sectionName]
    if type(offset) ~= "number" then
        return false
    end

    local maxScroll = 0
    if frame.content and frame.scrollFrame.GetHeight and frame.content.GetHeight then
        maxScroll = math.max(0, frame.content:GetHeight() - frame.scrollFrame:GetHeight())
    end

    frame.scrollFrame:SetVerticalScroll(math.min(math.max(0, offset), maxScroll))
    return true
end

function CleanPlates:OpenOptionsSection(sectionName)
    if self.OpenAceOptions and self:OpenAceOptions(sectionName) then
        return
    end

    if self.InitializeSettingsCategory then
        self:InitializeSettingsCategory()
    end

    local function scrollLater()
        C_Timer.After(0, function()
            self:ScrollOptionsToSection(sectionName)
        end)
    end

    if self.settingsCategoryID and Settings and type(Settings.OpenToCategory) == "function" then
        Settings.OpenToCategory(self.settingsCategoryID)
        C_Timer.After(0, function()
            if Settings and type(Settings.OpenToCategory) == "function" then
                Settings.OpenToCategory(self.settingsCategoryID)
            end
            scrollLater()
        end)
        return
    end

    self:ToggleOptions()
    scrollLater()
end

function CleanPlates:RefreshProfilesOptions()
    if not self.profilesOptionsFrame or not self.profilesOptionsFrame.controls or not self.db then
        return
    end

    local frame = self.profilesOptionsFrame
    local controls = frame.controls
    local activeProfileName = self.GetActiveProfileName and self:GetActiveProfileName() or "Default"
    controls.activeProfile:SetText(L("profiles_active", activeProfileName))

    if controls.profileNameBox and (not controls.profileNameBox.HasFocus or not controls.profileNameBox:HasFocus()) then
        controls.profileNameBox:SetText(activeProfileName)
    end

    local names = self.GetProfileNames and self:GetProfileNames() or { activeProfileName }
    local buttons = frame.profileButtons or {}
    frame.profileButtons = buttons

    for i = 1, #names do
        local button = buttons[i]
        if not button then
            button = CreateFrame("Button", nil, controls.listContent, "UIPanelButtonTemplate")
            button:SetSize(210, 22)
            buttons[i] = button
        end

        local profileName = names[i]
        button:ClearAllPoints()
        button:SetPoint("TOPLEFT", controls.listContent, "TOPLEFT", 0, -((i - 1) * 24))
        button:SetText(profileName)
        button:SetScript("OnClick", function()
            controls.profileNameBox:SetText(profileName)
            controls.profileNameBox:HighlightText()
            controls.profileNameBox:SetFocus()
        end)

        local label = button:GetFontString()
        if label then
            if profileName == activeProfileName then
                label:SetTextColor(1, 0.82, 0)
            else
                label:SetTextColor(1, 1, 1)
            end
        end

        button:Show()
    end

    for i = #names + 1, #buttons do
        buttons[i]:Hide()
    end

    controls.listContent:SetHeight(math.max(24, #names * 24))
end

function CleanPlates:CreateProfilesOptions()
    if self.profilesOptionsFrame then
        return self.profilesOptionsFrame
    end

    local frame = CreateFrame("Frame", "CleanPlatesProfilesCanvas", UIParent)
    frame:SetSize(820, 620)
    frame:Hide()

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText(L("profiles_title"))

    local subtitle = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -4)
    subtitle:SetText(L("profiles_subtitle"))

    local scrollFrame = CreateFrame("ScrollFrame", "CleanPlatesProfilesScrollFrame", frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -52)
    scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 12)

    local content = CreateFrame("Frame", "CleanPlatesProfilesScrollContent", scrollFrame)
    content:SetSize(760, 860)
    scrollFrame:SetScrollChild(content)

    local activeProfile = content:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    activeProfile:SetPoint("TOPLEFT", 18, -16)
    activeProfile:SetText(L("profiles_active", "-"))

    local nameLabel = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    nameLabel:SetPoint("TOPLEFT", activeProfile, "BOTTOMLEFT", 0, -16)
    nameLabel:SetText(L("profile_name"))

    local profileNameBox = CreateFrame("EditBox", "CleanPlatesProfileNameBox", content, "InputBoxTemplate")
    profileNameBox:SetSize(220, 22)
    profileNameBox:SetPoint("TOPLEFT", nameLabel, "BOTTOMLEFT", 0, -6)
    profileNameBox:SetAutoFocus(false)
    profileNameBox:SetScript("OnEscapePressed", function(editBox)
        editBox:ClearFocus()
    end)

    local saveButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    saveButton:SetSize(100, 22)
    saveButton:SetPoint("TOPLEFT", profileNameBox, "BOTTOMLEFT", 0, -10)
    saveButton:SetText(L("btn_save_update"))
    saveButton:SetScript("OnClick", function()
        local profileName = trim(profileNameBox:GetText() or "")
        if profileName == "" then
            profileName = CleanPlates:GetActiveProfileName()
            profileNameBox:SetText(profileName)
        end
        local ok, reason = CleanPlates:SaveProfile(profileName)
        if ok then
            CleanPlates:Print(L("msg_profile_saved", profileName))
            CleanPlates:RefreshProfilesOptions()
        else
            CleanPlates:Print(L("msg_profile_save_failed", tostring(reason)))
        end
    end)

    local loadButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    loadButton:SetSize(70, 22)
    loadButton:SetPoint("LEFT", saveButton, "RIGHT", 8, 0)
    loadButton:SetText(L("btn_load"))
    loadButton:SetScript("OnClick", function()
        local profileName = trim(profileNameBox:GetText() or "")
        if profileName == "" then
            profileName = CleanPlates:GetActiveProfileName()
            profileNameBox:SetText(profileName)
        end
        local ok, reason = CleanPlates:LoadProfile(profileName)
        if ok then
            CleanPlates:Print(L("msg_profile_loaded", profileName))
            CleanPlates:RefreshProfilesOptions()
        else
            CleanPlates:Print(L("msg_profile_load_failed", tostring(reason)))
        end
    end)

    local deleteButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    deleteButton:SetSize(70, 22)
    deleteButton:SetPoint("LEFT", loadButton, "RIGHT", 8, 0)
    deleteButton:SetText(L("btn_delete"))
    deleteButton:SetScript("OnClick", function()
        local profileName = trim(profileNameBox:GetText() or "")
        local ok, reason = CleanPlates:DeleteProfile(profileName)
        if ok then
            CleanPlates:Print(L("msg_profile_deleted", profileName))
            CleanPlates:RefreshProfilesOptions()
        else
            CleanPlates:Print(L("msg_profile_delete_failed", tostring(reason)))
        end
    end)

    local resetProfileButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    resetProfileButton:SetSize(110, 22)
    resetProfileButton:SetPoint("LEFT", deleteButton, "RIGHT", 8, 0)
    resetProfileButton:SetText(L("btn_reset_active"))
    resetProfileButton:SetScript("OnClick", function()
        local activeName = CleanPlates:GetActiveProfileName()
        local ok, reason = CleanPlates:ResetActiveProfile()
        if ok then
            CleanPlates:Print(L("msg_profile_reset", activeName))
            CleanPlates:RefreshProfilesOptions()
        else
            CleanPlates:Print(L("msg_profile_reset_failed", tostring(reason)))
        end
    end)

    local listHeader = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    listHeader:SetPoint("TOPLEFT", saveButton, "BOTTOMLEFT", 0, -16)
    listHeader:SetText(L("saved_profiles"))

    local listScroll = CreateFrame("ScrollFrame", "CleanPlatesProfilesListScroll", content, "UIPanelScrollFrameTemplate")
    listScroll:SetPoint("TOPLEFT", listHeader, "BOTTOMLEFT", 0, -8)
    listScroll:SetSize(236, 360)

    local listContent = CreateFrame("Frame", nil, listScroll)
    listContent:SetSize(210, 360)
    listScroll:SetScrollChild(listContent)

    local ioHeader = content:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    ioHeader:SetPoint("TOPLEFT", content, "TOPLEFT", 286, -68)
    ioHeader:SetText(L("import_export"))

    local ioScroll = CreateFrame("ScrollFrame", "CleanPlatesProfileIOScroll", content, "UIPanelScrollFrameTemplate")
    ioScroll:SetPoint("TOPLEFT", ioHeader, "BOTTOMLEFT", 0, -8)
    ioScroll:SetSize(430, 260)

    local profileStringBox = CreateFrame("EditBox", "CleanPlatesProfileIOBox", ioScroll)
    profileStringBox:SetMultiLine(true)
    profileStringBox:SetFontObject(ChatFontNormal)
    profileStringBox:SetWidth(404)
    profileStringBox:SetPoint("TOPLEFT", ioScroll, "TOPLEFT", 0, 0)
    profileStringBox:SetAutoFocus(false)
    profileStringBox:SetScript("OnEscapePressed", function(editBox)
        editBox:ClearFocus()
    end)

    local function getProfileIOTextHeight()
        if type(profileStringBox.GetStringHeight) == "function" then
            local ok, value = pcall(profileStringBox.GetStringHeight, profileStringBox)
            if ok and type(value) == "number" and value > 0 then
                return value
            end
        end

        if type(profileStringBox.GetFontString) == "function" then
            local fontString = profileStringBox:GetFontString()
            if fontString and type(fontString.GetStringHeight) == "function" then
                local ok, value = pcall(fontString.GetStringHeight, fontString)
                if ok and type(value) == "number" and value > 0 then
                    return value
                end
            end
        end

        local text = profileStringBox:GetText() or ""
        local lines = 1
        for _ in text:gmatch("\n") do
            lines = lines + 1
        end
        return lines * 14
    end

    local function updateIOHeight()
        local desiredHeight = math.max(260, getProfileIOTextHeight() + 40)
        profileStringBox:SetHeight(desiredHeight)
        ioScroll:UpdateScrollChildRect()
    end

    profileStringBox:SetScript("OnTextChanged", function()
        updateIOHeight()
    end)
    profileStringBox:SetScript("OnCursorChanged", function(_, _, yPos, _, height)
        local viewBottom = ioScroll:GetVerticalScroll() + ioScroll:GetHeight()
        local cursorBottom = -yPos + height
        if cursorBottom > viewBottom then
            ioScroll:SetVerticalScroll(cursorBottom - ioScroll:GetHeight() + 12)
        elseif -yPos < ioScroll:GetVerticalScroll() then
            ioScroll:SetVerticalScroll(math.max(0, -yPos - 12))
        end
    end)
    ioScroll:SetScrollChild(profileStringBox)

    local function applyProfilesLayout()
        local contentWidth = content:GetWidth() or 760
        local ioLeft = 286
        local rightPadding = 34
        local ioWidth = math.max(300, contentWidth - ioLeft - rightPadding)
        ioHeader:ClearAllPoints()
        ioHeader:SetPoint("TOPLEFT", content, "TOPLEFT", ioLeft, -68)
        ioScroll:ClearAllPoints()
        ioScroll:SetPoint("TOPLEFT", ioHeader, "BOTTOMLEFT", 0, -8)
        ioScroll:SetWidth(ioWidth)
        profileStringBox:SetWidth(math.max(260, ioWidth - 26))
        listScroll:SetWidth(math.min(236, math.max(190, ioLeft - 40)))
        listContent:SetWidth(math.max(164, listScroll:GetWidth() - 26))
    end

    local exportFillButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    exportFillButton:SetSize(86, 22)
    exportFillButton:SetPoint("TOPLEFT", ioScroll, "BOTTOMLEFT", 0, -10)
    exportFillButton:SetText(L("btn_fill_export"))
    exportFillButton:SetScript("OnClick", function()
        local exportString = CleanPlates:BuildExportString()
        if not exportString then
            CleanPlates:Print(L("msg_profile_export_failed"))
            return
        end
        profileStringBox:SetText(exportString)
        profileStringBox:HighlightText()
        profileStringBox:SetFocus()
    end)

    local importButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    importButton:SetSize(110, 22)
    importButton:SetPoint("LEFT", exportFillButton, "RIGHT", 8, 0)
    importButton:SetText(L("btn_import_string"))
    importButton:SetScript("OnClick", function()
        local payload = trim(profileStringBox:GetText() or "")
        local ok, reason = CleanPlates:ApplyImportString(payload)
        if ok then
            CleanPlates:Print(L("msg_profile_imported"))
            CleanPlates:RefreshProfilesOptions()
        else
            CleanPlates:Print(L("msg_profile_import_failed", tostring(reason)))
        end
    end)

    local clearButton = CreateFrame("Button", nil, content, "UIPanelButtonTemplate")
    clearButton:SetSize(70, 22)
    clearButton:SetPoint("LEFT", importButton, "RIGHT", 8, 0)
    clearButton:SetText(L("btn_clear"))
    clearButton:SetScript("OnClick", function()
        profileStringBox:SetText("")
        profileStringBox:ClearFocus()
    end)

    local ioHint = content:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    ioHint:SetPoint("TOPLEFT", exportFillButton, "BOTTOMLEFT", 0, -10)
    ioHint:SetPoint("RIGHT", ioScroll, "RIGHT", 0, 0)
    ioHint:SetJustifyH("LEFT")
    ioHint:SetText(L("io_hint"))

    content:SetHeight(860)

    frame:SetScript("OnSizeChanged", function(_, width)
        local contentWidth = math.max(width - 52, 620)
        content:SetWidth(contentWidth)
        applyProfilesLayout()
        updateIOHeight()
    end)
    applyProfilesLayout()
    updateIOHeight()

    frame.controls = {
        activeProfile = activeProfile,
        profileNameBox = profileNameBox,
        listContent = listContent,
        profileStringBox = profileStringBox,
    }

    frame:SetScript("OnShow", function()
        CleanPlates:RefreshProfilesOptions()
    end)

    self.profilesOptionsFrame = frame
    self:RefreshProfilesOptions()
    return frame
end

function CleanPlates:OpenProfilesOptions()
    if self.OpenAceOptions and self:OpenAceOptions("profiles") then
        return
    end

    if self.InitializeSettingsCategory then
        self:InitializeSettingsCategory()
    end

    if self.profilesSettingsCategoryID and Settings and type(Settings.OpenToCategory) == "function" then
        Settings.OpenToCategory(self.profilesSettingsCategoryID)
        C_Timer.After(0, function()
            if Settings and type(Settings.OpenToCategory) == "function" then
                Settings.OpenToCategory(self.profilesSettingsCategoryID)
            end
        end)
        return
    end

    self:ToggleOptions()
end

function CleanPlates:CreateInfoOptions()
    if self.infoOptionsFrame then
        return self.infoOptionsFrame
    end

    local frame = CreateFrame("Frame", "CleanPlatesInfoCanvas", UIParent)
    frame:SetSize(820, 620)
    frame:Hide()

    local version = "1.0.0"
    if type(GetAddOnMetadata) == "function" then
        local detectedVersion = GetAddOnMetadata("CleanPlates", "Version")
        if detectedVersion and detectedVersion ~= "" then
            version = detectedVersion
        end
    end

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText(L("info_title"))

    local body = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    body:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -12)
    body:SetPoint("RIGHT", frame, "RIGHT", -24, 0)
    body:SetJustifyH("LEFT")
    body:SetJustifyV("TOP")
    body:SetText(L("info_body", version))

    self.infoOptionsFrame = frame
    return frame
end

function CleanPlates:CreateSectionJumpOptions(sectionName, titleText, descriptionText)
    local key = tostring(sectionName or ""):gsub("[^%w]", "")
    if key == "" then
        return nil
    end

    local frameField = "sectionJumpFrame" .. key
    if self[frameField] then
        return self[frameField]
    end

    local frame = CreateFrame("Frame", "CleanPlatesSectionJump" .. key, UIParent)
    frame:SetSize(820, 620)
    frame:Hide()

    local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("CleanPlates - " .. titleText)

    local body = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    body:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -12)
    body:SetPoint("RIGHT", frame, "RIGHT", -24, 0)
    body:SetJustifyH("LEFT")
    body:SetText((descriptionText or "") .. "\n\n" .. L("section_opening"))

    local jumping = false
    frame:SetScript("OnShow", function()
        if jumping then
            return
        end
        jumping = true
        C_Timer.After(0, function()
            jumping = false
            if CleanPlates and type(CleanPlates.OpenOptionsSection) == "function" then
                CleanPlates:OpenOptionsSection(sectionName)
            end
        end)
    end)

    self[frameField] = frame
    return frame
end

function CleanPlates:InitializeSettingsCategory()
    if self.settingsCategoryID then
        return
    end
    if not self.db then
        return
    end

    if self.InitializeAceOptions then
        self:InitializeAceOptions()
    end
    if self.aceOptionsInitialized then
        return
    end

    local frame = self:CreateOptions()
    if not frame then
        return
    end

    if not Settings or type(Settings.RegisterCanvasLayoutCategory) ~= "function" or type(Settings.RegisterAddOnCategory) ~= "function" then
        return
    end

    local category, layout = Settings.RegisterCanvasLayoutCategory(frame, "CleanPlates")
    if not category then
        return
    end

    if layout and type(layout.AddAnchorPoint) == "function" then
        layout:AddAnchorPoint("TOPLEFT", 0, 0)
        layout:AddAnchorPoint("BOTTOMRIGHT", 0, 0)
    end

    applySettingsCategoryIcon(category)
    Settings.RegisterAddOnCategory(category)
    self.settingsCategoryID = category:GetID()
    self.settingsCategory = category

    if type(Settings.RegisterCanvasLayoutSubcategory) == "function" then
        local function registerSectionShortcut(sectionName, label, description)
            local sectionFrame = self:CreateSectionJumpOptions(sectionName, label, description)
            if not sectionFrame then
                return
            end

            local sectionCategory, sectionLayout = Settings.RegisterCanvasLayoutSubcategory(category, sectionFrame, label, label)
            if sectionCategory and sectionLayout and type(sectionLayout.AddAnchorPoint) == "function" then
                sectionLayout:AddAnchorPoint("TOPLEFT", 0, 0)
                sectionLayout:AddAnchorPoint("BOTTOMRIGHT", 0, 0)
            end
        end

        registerSectionShortcut("General", L("nav_general"), L("nav_desc_general"))
        registerSectionShortcut("Nameplate Filters", L("nav_filters"), L("nav_desc_filters"))
        registerSectionShortcut("Aura Display", L("nav_aura"), L("nav_desc_aura"))
        registerSectionShortcut("Typography", L("nav_typography"), L("nav_desc_typography"))
        registerSectionShortcut("Size And Scale", L("nav_size"), L("nav_desc_size"))
        registerSectionShortcut("Plate Art", L("nav_plate_art"), L("nav_desc_plate_art"))
        registerSectionShortcut("Palette", L("nav_palette"), L("nav_desc_palette"))

        local profilesFrame = self:CreateProfilesOptions()
        if profilesFrame then
            local profilesCategory, profilesLayout = Settings.RegisterCanvasLayoutSubcategory(category, profilesFrame, L("nav_profiles"), L("nav_profiles"))
            if profilesCategory then
                if profilesLayout and type(profilesLayout.AddAnchorPoint) == "function" then
                    profilesLayout:AddAnchorPoint("TOPLEFT", 0, 0)
                    profilesLayout:AddAnchorPoint("BOTTOMRIGHT", 0, 0)
                end
                self.profilesSettingsCategoryID = profilesCategory:GetID()
            end
        end

        local infoFrame = self:CreateInfoOptions()
        if infoFrame then
            local infoCategory, infoLayout = Settings.RegisterCanvasLayoutSubcategory(category, infoFrame, L("nav_info"), L("nav_info"))
            if infoCategory then
                if infoLayout and type(infoLayout.AddAnchorPoint) == "function" then
                    infoLayout:AddAnchorPoint("TOPLEFT", 0, 0)
                    infoLayout:AddAnchorPoint("BOTTOMRIGHT", 0, 0)
                end
                self.infoSettingsCategoryID = infoCategory:GetID()
            end
        end
    end
end

function CleanPlates:ToggleOptions()
    if self.OpenAceOptions and self:OpenAceOptions("root") then
        return
    end

    if self.InitializeSettingsCategory then
        self:InitializeSettingsCategory()
    end

    if not self.optionsFrame then
        self:CreateOptions()
    end

    if self.settingsCategoryID and Settings and type(Settings.OpenToCategory) == "function" then
        Settings.OpenToCategory(self.settingsCategoryID)
        C_Timer.After(0, function()
            if Settings and type(Settings.OpenToCategory) == "function" then
                Settings.OpenToCategory(self.settingsCategoryID)
            end
        end)
        return
    end

    -- Fallback for clients that do not expose the modern Settings API.
    if self.optionsFrame:IsShown() then
        self.optionsFrame:Hide()
        return
    end

    self:RefreshOptions()
    self.optionsFrame:Show()
end
