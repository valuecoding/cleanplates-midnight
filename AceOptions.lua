local _, ns = ...

local CleanPlates = ns.CleanPlates
if not CleanPlates then
    return
end

local APP_NAME = "CleanPlates_Ace"
local ROOT_CATEGORY_NAME = "CleanPlates"
local unpackFunc = unpack or table.unpack

local STYLE_LABEL_KEYS = {
    clean = "style_clean",
    solid = "style_solid",
    blizzard = "style_blizzard",
    classic = "style_classic",
    thin = "style_thin",
    thick = "style_thick",
    compact = "style_compact",
    wide = "style_wide",
}

local COLOR_TARGETS = {
    enemyColor = "enemy",
    friendlyColor = "friendly",
    neutralColor = "neutral",
    targetColor = "target",
    castInterruptibleColor = "castint",
    castUninterruptibleColor = "castlock",
    castFriendlyColor = "castfriendly",
    healthTextColor = "healthtext",
}

local SECTION_ALIAS = {
    ["General"] = "general",
    ["Nameplate Filters"] = "filters",
    ["Aura Display"] = "aura",
    ["Typography"] = "typography",
    ["Size And Scale"] = "size",
    ["Plate Art"] = "plate_art",
    ["Palette"] = "palette",
}

local SECTION_PATHS = {
    root = {},
    general = { "general" },
    filters = { "filters" },
    aura = { "aura" },
    typography = { "typography" },
    size = { "size" },
    plate_art = { "plate_art" },
    textures = { "textures" },
    presets = { "presets" },
    palette = { "palette" },
    import_export = { "import_export" },
    profiles = { "profiles" },
    info = { "info" },
}

local function getAceLib(libName)
    if type(LibStub) ~= "table" and type(LibStub) ~= "function" then
        return nil
    end
    local ok, lib = pcall(LibStub, libName, true)
    if ok then
        return lib
    end
    return nil
end

local function getTranslator()
    local aceLocale = getAceLib("AceLocale-3.0")
    local localeTable = aceLocale and aceLocale:GetLocale("CleanPlates", true) or nil
    return function(key, fallback, ...)
        local template = (localeTable and localeTable[key]) or fallback or key
        if select("#", ...) > 0 then
            return string.format(template, ...)
        end
        return template
    end
end

local function openSettingsCategory(categoryRef)
    if not Settings or type(Settings.OpenToCategory) ~= "function" then
        return false
    end

    local categoryID = categoryRef
    if type(categoryRef) == "table" and type(categoryRef.GetID) == "function" then
        local ok, id = pcall(categoryRef.GetID, categoryRef)
        if ok then
            categoryID = id
        end
    end

    if type(categoryID) ~= "number" then
        return false
    end

    Settings.OpenToCategory(categoryID)
    C_Timer.After(0, function()
        if Settings and type(Settings.OpenToCategory) == "function" then
            Settings.OpenToCategory(categoryID)
        end
    end)
    return true
end

function CleanPlates:OpenAceOptions(sectionKey)
    if self.InitializeAceOptions then
        self:InitializeAceOptions()
    end
    if not self.aceOptionsInitialized then
        return false
    end

    local key = sectionKey
    if type(key) ~= "string" or key == "" then
        key = "root"
    end
    key = SECTION_ALIAS[key] or key
    if not SECTION_PATHS[key] then
        key = "root"
    end

    local categoryRef = self.aceCategories and self.aceCategories[key]
    if openSettingsCategory(categoryRef) then
        return true
    end

    local dialog = self.aceConfigDialog or getAceLib("AceConfigDialog-3.0")
    if not dialog or type(dialog.Open) ~= "function" then
        return false
    end

    local path = SECTION_PATHS[key]
    if path and #path > 0 then
        dialog:Open(APP_NAME, unpackFunc(path))
    else
        dialog:Open(APP_NAME)
    end
    return true
end

function CleanPlates:InitializeAceOptions()
    if self.aceOptionsInitialized then
        return
    end
    if not self.aceDB or not self.db then
        return
    end

    local AceConfig = getAceLib("AceConfig-3.0")
    local AceConfigDialog = getAceLib("AceConfigDialog-3.0")
    local AceConfigRegistry = getAceLib("AceConfigRegistry-3.0")
    local AceDBOptions = getAceLib("AceDBOptions-3.0")
    if not AceConfig or not AceConfigDialog then
        return
    end

    local L = getTranslator()
    local function notifyChange()
        if AceConfigRegistry and type(AceConfigRegistry.NotifyChange) == "function" then
            AceConfigRegistry:NotifyChange(APP_NAME)
        end
    end

    local function refreshAll(forceCvars)
        self:NormalizeSettings()
        if forceCvars then
            self.forceCVarReapply = true
        end
        if self.RefreshOptions then
            self:RefreshOptions()
        end
        self:Refresh()
        notifyChange()
    end

    local function getDBValue(key, fallback)
        local value = self.db[key]
        if value == nil then
            return fallback
        end
        return value
    end

    local function makeToggle(key, fallback, forceCvars)
        return {
            type = "toggle",
            get = function()
                return getDBValue(key, fallback)
            end,
            set = function(_, value)
                self.db[key] = value and true or false
                refreshAll(forceCvars)
            end,
        }
    end

    local function makeRange(key, fallback, minValue, maxValue, stepValue, forceCvars)
        return {
            type = "range",
            min = minValue,
            max = maxValue,
            step = stepValue,
            get = function()
                return tonumber(getDBValue(key, fallback)) or fallback
            end,
            set = function(_, value)
                self.db[key] = value
                refreshAll(forceCvars)
            end,
        }
    end

    local function styleValues()
        local values = {}
        local names = self.GetPlateArtStyleNames and self:GetPlateArtStyleNames() or {}
        for i = 1, #names do
            local styleName = names[i]
            values[styleName] = L(STYLE_LABEL_KEYS[styleName] or styleName, styleName)
        end
        if not next(values) then
            values.clean = L("style_clean", "Clean")
        end
        return values
    end

    local function infoBody()
        local version = "1.0.0"
        if type(GetAddOnMetadata) == "function" then
            local detected = GetAddOnMetadata("CleanPlates", "Version")
            if detected and detected ~= "" then
                version = detected
            end
        end
        return L("info_body", "Version: %s", version)
    end

    local options = {
        type = "group",
        name = "CleanPlates",
        childGroups = "tree",
        args = {
            general = { type = "group", order = 10, name = L("section_general", "General"), args = {} },
            filters = { type = "group", order = 20, name = L("section_filters", "Nameplate Filters"), args = {} },
            aura = { type = "group", order = 30, name = L("section_aura", "Aura Display"), args = {} },
            typography = { type = "group", order = 40, name = L("section_typography", "Typography"), args = {} },
            size = { type = "group", order = 50, name = L("section_size", "Size And Scale"), args = {} },
            plate_art = { type = "group", order = 60, name = L("section_plate_art", "Plate Art"), args = {} },
            textures = { type = "group", order = 70, name = L("section_external_textures", "External Textures (LSM)"), args = {} },
            presets = { type = "group", order = 80, name = L("section_presets", "Quick Presets"), args = {} },
            palette = { type = "group", order = 90, name = L("section_palette", "Palette"), args = {} },
            import_export = { type = "group", order = 100, name = L("import_export", "Import / Export String"), args = {} },
            info = { type = "group", order = 300, name = L("nav_info", "Info"), args = {} },
        },
    }

    local generalArgs = options.args.general.args
    generalArgs.enabled = makeToggle("enabled", true, true)
    generalArgs.enabled.order = 10
    generalArgs.enabled.width = "full"
    generalArgs.enabled.name = L("check_enabled", "Enable CleanPlates styling")

    generalArgs.classColorPlayers = makeToggle("classColorPlayers", true)
    generalArgs.classColorPlayers.order = 20
    generalArgs.classColorPlayers.width = "full"
    generalArgs.classColorPlayers.name = L("check_class_color", "Use class colors on player nameplates")

    generalArgs.styleCombatText = makeToggle("styleCombatText", true)
    generalArgs.styleCombatText.order = 30
    generalArgs.styleCombatText.width = "full"
    generalArgs.styleCombatText.name = L("check_combat_text", "Style floating combat text font")

    generalArgs.enableCastStateColors = makeToggle("enableCastStateColors", true)
    generalArgs.enableCastStateColors.order = 40
    generalArgs.enableCastStateColors.width = "full"
    generalArgs.enableCastStateColors.name = L("check_cast_colors", "Use castbar colors (enemy/friendly)")

    generalArgs.showHealthPercent = makeToggle("showHealthPercent", false)
    generalArgs.showHealthPercent.order = 50
    generalArgs.showHealthPercent.width = "full"
    generalArgs.showHealthPercent.name = L("check_health_percent", "Show health percent on nameplates")
    generalArgs.showHealthPercent.disabled = function()
        return self.healthPercentBlocked == true
    end

    generalArgs.healthPercentEnemiesOnly = makeToggle("healthPercentEnemiesOnly", true)
    generalArgs.healthPercentEnemiesOnly.order = 60
    generalArgs.healthPercentEnemiesOnly.width = "full"
    generalArgs.healthPercentEnemiesOnly.name = L("check_health_percent_enemy_only", "Only on enemy nameplates")
    generalArgs.healthPercentEnemiesOnly.disabled = function()
        return self.healthPercentBlocked == true or self.db.showHealthPercent ~= true
    end

    generalArgs.targetHighlight = makeToggle("targetHighlight", true)
    generalArgs.targetHighlight.order = 70
    generalArgs.targetHighlight.width = "full"
    generalArgs.targetHighlight.name = L("check_target_highlight", "Highlight current target name")

    generalArgs.showQuestMarker = makeToggle("showQuestMarker", true)
    generalArgs.showQuestMarker.order = 80
    generalArgs.showQuestMarker.width = "full"
    generalArgs.showQuestMarker.name = L("check_quest_marker", "Show quest marker on quest-related nameplates")

    generalArgs.debug = makeToggle("debug", false)
    generalArgs.debug.order = 90
    generalArgs.debug.width = "full"
    generalArgs.debug.name = L("check_debug", "Enable debug chat output")

    generalArgs.apply = {
        type = "execute",
        order = 100,
        width = "half",
        name = L("btn_apply_now", "Apply Now"),
        func = function()
            refreshAll(true)
        end,
    }

    generalArgs.reset = {
        type = "execute",
        order = 110,
        width = "half",
        name = L("btn_reset_defaults", "Reset Defaults"),
        func = function()
            self:ResetToDefaults()
            self:Print(L("msg_defaults_restored", "Defaults restored."))
            notifyChange()
        end,
    }

    local filtersArgs = options.args.filters.args
    local filterSpecs = {
        { "showEnemyPlates", "check_show_enemy", true, 10, true },
        { "showEnemyPets", "check_enemy_pets", true, 20 },
        { "showEnemyGuardians", "check_enemy_guardians", true, 30 },
        { "showEnemyTotems", "check_enemy_totems", true, 40 },
        { "showEnemyMinions", "check_enemy_minions", true, 50 },
        { "showFriendlyPlates", "check_show_friendly", true, 60, true },
        { "showFriendlyPets", "check_friendly_pets", true, 70 },
        { "showFriendlyGuardians", "check_friendly_guardians", true, 80 },
        { "showFriendlyTotems", "check_friendly_totems", true, 90 },
        { "showFriendlyMinions", "check_friendly_minions", true, 100 },
    }
    for i = 1, #filterSpecs do
        local spec = filterSpecs[i]
        local key = spec[1]
        local labelKey = spec[2]
        local fallback = spec[3]
        local order = spec[4]
        local forceCvars = spec[5]
        filtersArgs[key] = makeToggle(key, fallback, forceCvars)
        filtersArgs[key].order = order
        filtersArgs[key].width = "full"
        filtersArgs[key].name = L(labelKey, key)
    end
    filtersArgs.showEnemyPets.disabled = function() return self.db.showEnemyPlates ~= true end
    filtersArgs.showEnemyGuardians.disabled = filtersArgs.showEnemyPets.disabled
    filtersArgs.showEnemyTotems.disabled = filtersArgs.showEnemyPets.disabled
    filtersArgs.showEnemyMinions.disabled = filtersArgs.showEnemyPets.disabled
    filtersArgs.showFriendlyPets.disabled = function() return self.db.showFriendlyPlates ~= true end
    filtersArgs.showFriendlyGuardians.disabled = filtersArgs.showFriendlyPets.disabled
    filtersArgs.showFriendlyTotems.disabled = filtersArgs.showFriendlyPets.disabled
    filtersArgs.showFriendlyMinions.disabled = filtersArgs.showFriendlyPets.disabled

    local auraArgs = options.args.aura.args
    auraArgs.showDebuffsOnEnemy = makeToggle("showDebuffsOnEnemy", true)
    auraArgs.showDebuffsOnEnemy.order = 10
    auraArgs.showDebuffsOnEnemy.width = "full"
    auraArgs.showDebuffsOnEnemy.name = L("check_debuff_enemy", "Show debuffs on enemy nameplates")
    auraArgs.showBuffsOnEnemy = makeToggle("showBuffsOnEnemy", false)
    auraArgs.showBuffsOnEnemy.order = 20
    auraArgs.showBuffsOnEnemy.width = "full"
    auraArgs.showBuffsOnEnemy.name = L("check_buff_enemy", "Show buffs on enemy nameplates")
    auraArgs.showDebuffsOnFriendly = makeToggle("showDebuffsOnFriendly", false)
    auraArgs.showDebuffsOnFriendly.order = 30
    auraArgs.showDebuffsOnFriendly.width = "full"
    auraArgs.showDebuffsOnFriendly.name = L("check_debuff_friendly", "Show debuffs on friendly nameplates")
    auraArgs.showBuffsOnFriendly = makeToggle("showBuffsOnFriendly", false)
    auraArgs.showBuffsOnFriendly.order = 40
    auraArgs.showBuffsOnFriendly.width = "full"
    auraArgs.showBuffsOnFriendly.name = L("check_buff_friendly", "Show buffs on friendly nameplates")
    auraArgs.maxBuffs = makeRange("maxBuffs", 0, 0, 8, 1)
    auraArgs.maxBuffs.order = 50
    auraArgs.maxBuffs.width = "full"
    auraArgs.maxBuffs.name = L("slider_max_buffs", "Max Buff Icons")
    auraArgs.maxDebuffs = makeRange("maxDebuffs", 4, 0, 8, 1)
    auraArgs.maxDebuffs.order = 60
    auraArgs.maxDebuffs.width = "full"
    auraArgs.maxDebuffs.name = L("slider_max_debuffs", "Max Debuff Icons")

    local typoArgs = options.args.typography.args
    typoArgs.status = {
        type = "description",
        order = 10,
        width = "full",
        name = function()
            if self.IsNameStylingSupported and self:IsNameStylingSupported() then
                return L("typography_active", "Name font controls are active.")
            end
            return L("typography_disabled", "Midnight stability mode: name font controls are disabled to prevent taint.")
        end,
    }
    typoArgs.nameFontSize = makeRange("nameFontSize", 12, 8, 24, 1)
    typoArgs.nameFontSize.order = 20
    typoArgs.nameFontSize.width = "full"
    typoArgs.nameFontSize.name = L("slider_name_size", "Name Font Size")
    typoArgs.nameFontSize.disabled = function()
        return not (self.IsNameStylingSupported and self:IsNameStylingSupported())
    end
    typoArgs.combatTextFontSize = makeRange("combatTextFontSize", 26, 16, 40, 1)
    typoArgs.combatTextFontSize.order = 30
    typoArgs.combatTextFontSize.width = "full"
    typoArgs.combatTextFontSize.name = L("slider_combat_size", "Combat Text Font Size")
    typoArgs.targetFontBoost = makeRange("targetFontBoost", 1, 0, 8, 1)
    typoArgs.targetFontBoost.order = 40
    typoArgs.targetFontBoost.width = "full"
    typoArgs.targetFontBoost.name = L("slider_target_boost", "Target Font Boost")

    local sizeArgs = options.args.size.args
    local sizeSpecs = {
        { "nameplateGlobalScale", "slider_global_scale", 1.0, 0.6, 2.0, 0.01, 10 },
        { "nameplateHorizontalScale", "slider_width_scale", 1.0, 0.6, 1.8, 0.01, 20 },
        { "nameplateVerticalScale", "slider_height_scale", 1.0, 0.6, 2.0, 0.01, 30 },
        { "nameplateHeightMultiplier", "slider_height_multiplier", 1.0, 0.5, 2.5, 0.01, 40 },
        { "nameplateXSpacing", "slider_x_spacing", 0.8, 0.05, 2.0, 0.01, 50 },
        { "nameplateYSpacing", "slider_y_spacing", 1.1, 0.05, 2.0, 0.01, 60 },
        { "nameplateSelectedScale", "slider_target_scale", 1.2, 1.0, 2.5, 0.01, 70 },
        { "nameplateMaxDistance", "slider_max_distance", 60, 20, 100, 1, 80 },
        { "castBarScale", "slider_cast_scale", 1.0, 0.6, 2.0, 0.01, 90 },
    }
    for i = 1, #sizeSpecs do
        local spec = sizeSpecs[i]
        sizeArgs[spec[1]] = makeRange(spec[1], spec[3], spec[4], spec[5], spec[6], true)
        sizeArgs[spec[1]].order = spec[7]
        sizeArgs[spec[1]].width = "full"
        sizeArgs[spec[1]].name = L(spec[2], spec[1])
    end
    sizeArgs.recheck = {
        type = "execute",
        order = 100,
        width = "half",
        name = L("btn_recheck_scale", "Recheck Scale"),
        func = function()
            refreshAll(true)
        end,
    }

    local artArgs = options.args.plate_art.args
    artArgs.activeStyle = {
        type = "description",
        order = 10,
        width = "full",
        name = function()
            return L("active_style", "Active Style: %s", tostring(self.db.plateArtStyle or "clean"))
        end,
    }
    artArgs.style = {
        type = "select",
        order = 20,
        width = "full",
        name = L("section_plate_art", "Plate Art"),
        values = styleValues,
        get = function()
            return tostring(getDBValue("plateArtStyle", "clean"))
        end,
        set = function(_, value)
            self:SetPlateArtStyle(tostring(value), true)
            notifyChange()
        end,
    }

    local textureArgs = options.args.textures.args
    textureArgs.info = {
        type = "description",
        order = 10,
        width = "full",
        name = L("texture_info", "Optional: use a LibSharedMedia statusbar name or a direct texture path."),
    }
    textureArgs.healthTexture = {
        type = "input",
        order = 20,
        width = "full",
        name = L("health_texture", "Health Texture"),
        get = function() return tostring(getDBValue("healthTexture", "")) end,
        set = function(_, value) self.db.healthTexture = tostring(value or ""); notifyChange() end,
    }
    textureArgs.castTexture = {
        type = "input",
        order = 30,
        width = "full",
        name = L("cast_texture", "Cast Texture"),
        get = function() return tostring(getDBValue("castTexture", "")) end,
        set = function(_, value) self.db.castTexture = tostring(value or ""); notifyChange() end,
    }
    textureArgs.apply = {
        type = "execute",
        order = 40,
        width = "half",
        name = L("btn_apply_textures", "Apply Textures"),
        func = function()
            local changed = false
            local okHealth = self:SetTextureSelection("health", tostring(getDBValue("healthTexture", "")))
            local okCast = self:SetTextureSelection("cast", tostring(getDBValue("castTexture", "")))
            changed = (okHealth == true) or (okCast == true)
            if not changed then
                self:Print(L("msg_no_texture_change", "No texture change applied."))
            end
            notifyChange()
        end,
    }
    textureArgs.reset = {
        type = "execute",
        order = 50,
        width = "half",
        name = L("btn_reset_textures", "Reset Textures"),
        func = function()
            self:SetTextureSelection("health", "default")
            self:SetTextureSelection("cast", "default")
            notifyChange()
        end,
    }
    textureArgs.list = {
        type = "execute",
        order = 60,
        width = "half",
        name = L("btn_list_lsm", "List LSM"),
        func = function()
            local names = self:GetAvailableStatusBarTextures()
            if #names == 0 then
                self:Print(L("msg_no_lsm_textures", "No external LSM textures found."))
            else
                self:Print(L("msg_lsm_textures", "LSM statusbar textures (%d): %s", #names, table.concat(names, ", ")))
            end
        end,
    }
    textureArgs.resolved = {
        type = "description",
        order = 70,
        width = "full",
        name = function()
            local resolvedHealth = self.GetResolvedHealthTexture and self:GetResolvedHealthTexture() or "<default>"
            local resolvedCast = self.GetResolvedCastTexture and self:GetResolvedCastTexture() or "<default>"
            return L("resolved_textures", "Resolved: health=%s   cast=%s", resolvedHealth, resolvedCast)
        end,
    }

    local presetArgs = options.args.presets.args
    presetArgs.activePreset = {
        type = "description",
        order = 10,
        width = "full",
        name = function()
            return L("active_preset", "Active Preset: %s", tostring(self.db.preset or "-"))
        end,
    }
    local function makePresetButton(order, nameKey, presetName)
        return {
            type = "execute",
            order = order,
            width = "half",
            name = L(nameKey, presetName),
            func = function()
                self:ApplyPreset(presetName, true)
                notifyChange()
            end,
        }
    end
    presetArgs.vivid = makePresetButton(20, "btn_vivid", "vivid")
    presetArgs.neutral = makePresetButton(30, "btn_neutral", "neutral")
    presetArgs.soft = makePresetButton(40, "btn_soft", "soft")

    local paletteArgs = options.args.palette.args
    paletteArgs.hint = {
        type = "description",
        order = 10,
        width = "full",
        name = L("palette_hint", "Click swatches to customize"),
    }
    local colorSpecs = {
        { "enemyColor", "color_enemy", 20 },
        { "friendlyColor", "color_friendly", 30 },
        { "neutralColor", "color_neutral", 40 },
        { "targetColor", "color_target", 50 },
        { "castInterruptibleColor", "color_cast_enemy", 60 },
        { "castUninterruptibleColor", "color_cast_locked", 70 },
        { "castFriendlyColor", "color_cast_friendly", 80 },
        { "healthTextColor", "color_health_text", 90 },
    }
    for i = 1, #colorSpecs do
        local spec = colorSpecs[i]
        local fieldName = spec[1]
        paletteArgs[fieldName] = {
            type = "color",
            order = spec[3],
            width = "full",
            hasAlpha = false,
            name = L(spec[2], fieldName),
            get = function()
                local color = self.db[fieldName] or { r = 1, g = 1, b = 1 }
                return color.r, color.g, color.b
            end,
            set = function(_, r, g, b)
                local target = COLOR_TARGETS[fieldName]
                if target then
                    self:SetPaletteColor(target, r, g, b)
                    refreshAll(false)
                end
            end,
        }
    end

    self.aceImportExportBuffer = self.aceImportExportBuffer or ""
    local ioArgs = options.args.import_export.args
    ioArgs.buffer = {
        type = "input",
        multiline = 14,
        order = 10,
        width = "full",
        name = L("import_export", "Import / Export String"),
        get = function() return tostring(self.aceImportExportBuffer or "") end,
        set = function(_, value) self.aceImportExportBuffer = tostring(value or "") end,
    }
    ioArgs.fill = {
        type = "execute",
        order = 20,
        width = "half",
        name = L("btn_fill_export", "Fill Export"),
        func = function()
            local exportString = self:BuildExportString()
            if exportString then
                self.aceImportExportBuffer = exportString
                notifyChange()
            else
                self:Print(L("msg_profile_export_failed", "Could not export profile."))
            end
        end,
    }
    ioArgs.import = {
        type = "execute",
        order = 30,
        width = "half",
        name = L("btn_import_string", "Import String"),
        func = function()
            local ok, reason = self:ApplyImportString(tostring(self.aceImportExportBuffer or ""))
            if ok then
                self:Print(L("msg_profile_imported", "Profile imported."))
                notifyChange()
            else
                self:Print(L("msg_profile_import_failed", "Import failed: %s", tostring(reason)))
            end
        end,
    }
    ioArgs.clear = {
        type = "execute",
        order = 40,
        width = "half",
        name = L("btn_clear", "Clear"),
        func = function()
            self.aceImportExportBuffer = ""
            notifyChange()
        end,
    }
    ioArgs.hint = {
        type = "description",
        order = 50,
        width = "full",
        name = L("io_hint", "Use Fill Export to generate a share string. Paste a string and press Import String to load it into the active profile."),
    }

    options.args.info.args.body = {
        type = "description",
        order = 10,
        width = "full",
        name = infoBody,
    }

    if AceDBOptions then
        local profileOptions = AceDBOptions:GetOptionsTable(self.aceDB)
        profileOptions.order = 200
        profileOptions.name = L("nav_profiles", "Profiles")
        options.args.profiles = profileOptions
    end

    local ok = pcall(AceConfig.RegisterOptionsTable, AceConfig, APP_NAME, options)
    if not ok then
        return
    end

    self.aceConfigDialog = AceConfigDialog
    self.useAceOptions = true
    self.aceCategories = self.aceCategories or {}

    local function registerBlizzCategory(key, title, parent, path)
        if type(AceConfigDialog.AddToBlizOptions) ~= "function" then
            return
        end
        local okCat, category = pcall(AceConfigDialog.AddToBlizOptions, AceConfigDialog, APP_NAME, title, parent, path)
        if okCat then
            self.aceCategories[key] = category
        end
    end

    registerBlizzCategory("root", ROOT_CATEGORY_NAME)
    registerBlizzCategory("general", L("nav_general", "General"), ROOT_CATEGORY_NAME, "general")
    registerBlizzCategory("filters", L("nav_filters", "Filters"), ROOT_CATEGORY_NAME, "filters")
    registerBlizzCategory("aura", L("nav_aura", "Aura"), ROOT_CATEGORY_NAME, "aura")
    registerBlizzCategory("typography", L("nav_typography", "Typography"), ROOT_CATEGORY_NAME, "typography")
    registerBlizzCategory("size", L("nav_size", "Size & Scale"), ROOT_CATEGORY_NAME, "size")
    registerBlizzCategory("plate_art", L("nav_plate_art", "Plate Art"), ROOT_CATEGORY_NAME, "plate_art")
    registerBlizzCategory("textures", L("section_external_textures", "External Textures (LSM)"), ROOT_CATEGORY_NAME, "textures")
    registerBlizzCategory("presets", L("section_presets", "Quick Presets"), ROOT_CATEGORY_NAME, "presets")
    registerBlizzCategory("palette", L("nav_palette", "Palette"), ROOT_CATEGORY_NAME, "palette")
    registerBlizzCategory("import_export", L("import_export", "Import / Export String"), ROOT_CATEGORY_NAME, "import_export")
    if options.args.profiles then
        registerBlizzCategory("profiles", L("nav_profiles", "Profiles"), ROOT_CATEGORY_NAME, "profiles")
    end
    registerBlizzCategory("info", L("nav_info", "Info"), ROOT_CATEGORY_NAME, "info")

    self.aceSettingsCategory = self.aceCategories.root
    self.aceOptionsInitialized = true
end
