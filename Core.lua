local ADDON_NAME, ns = ...

local CleanPlates = CreateFrame("Frame")
ns.CleanPlates = CleanPlates
local CLIENT_LOCALE = (type(GetLocale) == "function" and GetLocale()) or "enUS"

local function localizeText(enUS, deDE)
    if CLIENT_LOCALE == "deDE" and type(deDE) == "string" and deDE ~= "" then
        return deDE
    end
    return enUS
end

local defaults = {
    enabled = true,
    debug = false,
    classColorPlayers = true,
    styleCombatText = true,
    enableCastStateColors = true,
    showHealthPercent = false,
    healthPercentEnemiesOnly = true,
    targetHighlight = true,
    showQuestMarker = true,
    plateArtStyle = "clean",
    showEnemyPlates = true,
    showFriendlyPlates = true,
    showEnemyPets = true,
    showEnemyGuardians = true,
    showEnemyTotems = true,
    showEnemyMinions = true,
    showFriendlyPets = true,
    showFriendlyGuardians = true,
    showFriendlyTotems = true,
    showFriendlyMinions = true,
    showDebuffsOnEnemy = true,
    showBuffsOnEnemy = false,
    showDebuffsOnFriendly = false,
    showBuffsOnFriendly = false,
    maxBuffs = 0,
    maxDebuffs = 4,
    nameplateGlobalScale = 1.0,
    nameplateHorizontalScale = 1.0,
    nameplateVerticalScale = 1.0,
    nameplateHeightMultiplier = 1.0,
    nameplateXSpacing = 0.8,
    nameplateYSpacing = 1.1,
    nameplateSelectedScale = 1.2,
    nameplateMaxDistance = 60,
    castBarScale = 1.0,
    targetFontBoost = 1,
    preset = "vivid",
    nameFont = "Fonts\\ARIALN.TTF",
    nameFontSize = 12,
    combatTextFontSize = 26,
    fontFlags = "OUTLINE",
    healthTexture = "Interface\\TARGETINGFRAME\\UI-StatusBar",
    castTexture = "Interface\\TARGETINGFRAME\\UI-StatusBar",
    enemyColor = { r = 0.92, g = 0.20, b = 0.20 },
    friendlyColor = { r = 0.20, g = 0.85, b = 0.30 },
    neutralColor = { r = 0.90, g = 0.74, b = 0.25 },
    targetColor = { r = 1.00, g = 0.82, b = 0.00 },
    castInterruptibleColor = { r = 1.00, g = 0.72, b = 0.16 },
    castUninterruptibleColor = { r = 0.62, g = 0.62, b = 0.62 },
    castFriendlyColor = { r = 0.33, g = 0.62, b = 0.95 },
    healthTextColor = { r = 1.00, g = 1.00, b = 1.00 },
}

local presets = {
    vivid = {
        enemyColor = { r = 0.92, g = 0.20, b = 0.20 },
        friendlyColor = { r = 0.20, g = 0.85, b = 0.30 },
        neutralColor = { r = 0.90, g = 0.74, b = 0.25 },
        targetColor = { r = 1.00, g = 0.82, b = 0.00 },
        castInterruptibleColor = { r = 1.00, g = 0.72, b = 0.16 },
        castUninterruptibleColor = { r = 0.62, g = 0.62, b = 0.62 },
        castFriendlyColor = { r = 0.33, g = 0.62, b = 0.95 },
        healthTextColor = { r = 1.00, g = 1.00, b = 1.00 },
        targetFontBoost = 1,
        nameFontSize = 12,
        combatTextFontSize = 26,
    },
    neutral = {
        enemyColor = { r = 0.85, g = 0.35, b = 0.22 },
        friendlyColor = { r = 0.28, g = 0.72, b = 0.42 },
        neutralColor = { r = 0.80, g = 0.70, b = 0.36 },
        targetColor = { r = 1.00, g = 0.82, b = 0.00 },
        castInterruptibleColor = { r = 1.00, g = 0.72, b = 0.16 },
        castUninterruptibleColor = { r = 0.62, g = 0.62, b = 0.62 },
        castFriendlyColor = { r = 0.33, g = 0.62, b = 0.95 },
        healthTextColor = { r = 1.00, g = 1.00, b = 1.00 },
        targetFontBoost = 1,
        nameFontSize = 12,
        combatTextFontSize = 24,
    },
    soft = {
        enemyColor = { r = 0.80, g = 0.33, b = 0.33 },
        friendlyColor = { r = 0.36, g = 0.72, b = 0.54 },
        neutralColor = { r = 0.76, g = 0.66, b = 0.38 },
        targetColor = { r = 1.00, g = 0.82, b = 0.00 },
        castInterruptibleColor = { r = 1.00, g = 0.72, b = 0.16 },
        castUninterruptibleColor = { r = 0.62, g = 0.62, b = 0.62 },
        castFriendlyColor = { r = 0.33, g = 0.62, b = 0.95 },
        healthTextColor = { r = 1.00, g = 1.00, b = 1.00 },
        targetFontBoost = 1,
        nameFontSize = 11,
        combatTextFontSize = 22,
    },
}

local plateArtStyleOrder = {
    "clean",
    "solid",
    "blizzard",
    "classic",
    "thin",
    "thick",
    "compact",
    "wide",
}

local plateArtStyles = {
    clean = {
        healthTexture = "Interface\\TARGETINGFRAME\\UI-StatusBar",
        castTexture = "Interface\\TARGETINGFRAME\\UI-StatusBar",
        borderThickness = 1,
        borderAlpha = 0.35,
        backdropAlpha = 0.16,
        accentAlpha = 0.18,
    },
    solid = {
        healthTexture = "Interface\\Buttons\\WHITE8X8",
        castTexture = "Interface\\Buttons\\WHITE8X8",
        borderThickness = 2,
        borderAlpha = 0.78,
        backdropAlpha = 0.30,
        accentAlpha = 0.00,
        horizontalScaleMult = 1.06,
        verticalScaleMult = 1.04,
        castBarScaleMult = 1.08,
    },
    blizzard = {
        healthTexture = "Interface\\TARGETINGFRAME\\UI-StatusBar",
        castTexture = "Interface\\TARGETINGFRAME\\UI-StatusBar",
        borderThickness = 1,
        borderAlpha = 0.20,
        backdropAlpha = 0.08,
        accentAlpha = 0.00,
    },
    classic = {
        healthTexture = "Interface\\RaidFrame\\Raid-Bar-Hp-Fill",
        castTexture = "Interface\\RaidFrame\\Raid-Bar-Hp-Fill",
        borderThickness = 1,
        borderAlpha = 0.58,
        backdropAlpha = 0.24,
        accentAlpha = 0.30,
        horizontalScaleMult = 1.02,
        verticalScaleMult = 0.98,
    },
    thin = {
        healthTexture = "Interface\\Buttons\\WHITE8X8",
        castTexture = "Interface\\Buttons\\WHITE8X8",
        borderThickness = 1,
        borderAlpha = 0.66,
        backdropAlpha = 0.20,
        accentAlpha = 0.26,
        horizontalScaleMult = 0.92,
        verticalScaleMult = 0.78,
        selectedScaleMult = 1.08,
        castBarScaleMult = 0.82,
    },
    thick = {
        healthTexture = "Interface\\Buttons\\WHITE8X8",
        castTexture = "Interface\\Buttons\\WHITE8X8",
        borderThickness = 3,
        borderAlpha = 0.86,
        backdropAlpha = 0.34,
        accentAlpha = 0.35,
        horizontalScaleMult = 1.10,
        verticalScaleMult = 1.22,
        selectedScaleMult = 1.15,
        castBarScaleMult = 1.25,
    },
    compact = {
        healthTexture = "Interface\\TARGETINGFRAME\\UI-StatusBar",
        castTexture = "Interface\\TARGETINGFRAME\\UI-StatusBar",
        borderThickness = 1,
        borderAlpha = 0.44,
        backdropAlpha = 0.12,
        accentAlpha = 0.12,
        globalScaleMult = 0.90,
        horizontalScaleMult = 0.88,
        verticalScaleMult = 0.85,
        selectedScaleMult = 1.05,
        castBarScaleMult = 0.90,
    },
    wide = {
        healthTexture = "Interface\\TARGETINGFRAME\\UI-StatusBar",
        castTexture = "Interface\\TARGETINGFRAME\\UI-StatusBar",
        borderThickness = 2,
        borderAlpha = 0.70,
        backdropAlpha = 0.24,
        accentAlpha = 0.32,
        globalScaleMult = 1.02,
        horizontalScaleMult = 1.28,
        verticalScaleMult = 0.90,
        selectedScaleMult = 1.20,
    },
}

local baseHooksInstalled = false
local mixinHooksInstalled = false
local legacySetupHookInstalled = false
local QUEST_CACHE_TTL = 0.40
local DUPLICATE_APPLY_WINDOW = 0.01
local HEALTH_PERCENT_SUPPORTED = false -- Midnight Secret Values block safe numeric health access on nameplates.
local HEALTH_BAR_STYLING_SUPPORTED = false -- Midnight: writing healthbar visuals can taint secret maxHealth paths.
local HEALTH_TEXTURE_STYLING_SUPPORTED = false -- Midnight: disable direct healthbar texture writes for stability.
local NAME_STYLING_SUPPORTED = false -- Avoid forbidden object taint on Midnight name text regions.
local AURA_FRAME_MUTATION_SUPPORTED = false -- Keep aura control via CVars/bitfields only on Midnight.
local FRAME_STYLING_SUPPORTED = false -- No direct CompactUnitFrame mutations on Midnight stability mode.
local healthTextByUnitFrame = setmetatable({}, { __mode = "k" })
local questMarkerByUnitFrame = setmetatable({}, { __mode = "k" })
local questMarkerAnchorByMarker = setmetatable({}, { __mode = "k" })
local questMarkerVisualKeyByMarker = setmetatable({}, { __mode = "k" })
local castColorKeyByUnitFrame = setmetatable({}, { __mode = "k" })
local nameCacheByUnitFrame = setmetatable({}, { __mode = "k" })
local auraCacheByUnitFrame = setmetatable({}, { __mode = "k" })
local castScaleByUnitFrame = setmetatable({}, { __mode = "k" })
local castTextureByCastBar = setmetatable({}, { __mode = "k" })
local healthTextureByHealthBar = setmetatable({}, { __mode = "k" })
local plateArtOverlayByUnitFrame = setmetatable({}, { __mode = "k" })
local plateArtOverlayKeyByUnitFrame = setmetatable({}, { __mode = "k" })
local castFontKeyByTextRegion = setmetatable({}, { __mode = "k" })
local lastApplyTimeByUnitFrame = setmetatable({}, { __mode = "k" })
local manualSizeBaseByUnitFrame = setmetatable({}, { __mode = "k" })
local manualSizeKeyByUnitFrame = setmetatable({}, { __mode = "k" })
local queuedApplyByUnitFrame = setmetatable({}, { __mode = "k" })
local PROFILE_DEFAULT_NAME = "Default"
local QUEST_MARKER_VISUALS = {
    kill = { texture = "Interface\\Icons\\INV_Sword_04", r = 1.0, g = 0.20, b = 0.20 },
    loot = { texture = "Interface\\Icons\\INV_Misc_Bag_08", r = 1.0, g = 0.90, b = 0.35 },
    turnin = { texture = "Interface\\GossipFrame\\ActiveQuestIcon", r = 1.0, g = 1.0, b = 1.0 },
    quest = { texture = "Interface\\GossipFrame\\AvailableQuestIcon", r = 1.0, g = 1.0, b = 1.0 },
}
local PROFILE_SETTING_KEYS = {
    "enabled",
    "debug",
    "classColorPlayers",
    "styleCombatText",
    "enableCastStateColors",
    "showHealthPercent",
    "healthPercentEnemiesOnly",
    "targetHighlight",
    "showQuestMarker",
    "plateArtStyle",
    "showEnemyPlates",
    "showFriendlyPlates",
    "showEnemyPets",
    "showEnemyGuardians",
    "showEnemyTotems",
    "showEnemyMinions",
    "showFriendlyPets",
    "showFriendlyGuardians",
    "showFriendlyTotems",
    "showFriendlyMinions",
    "showDebuffsOnEnemy",
    "showBuffsOnEnemy",
    "showDebuffsOnFriendly",
    "showBuffsOnFriendly",
    "maxBuffs",
    "maxDebuffs",
    "nameplateGlobalScale",
    "nameplateHorizontalScale",
    "nameplateVerticalScale",
    "nameplateHeightMultiplier",
    "nameplateXSpacing",
    "nameplateYSpacing",
    "nameplateSelectedScale",
    "nameplateMaxDistance",
    "castBarScale",
    "targetFontBoost",
    "preset",
    "nameFont",
    "nameFontSize",
    "combatTextFontSize",
    "fontFlags",
    "healthTexture",
    "castTexture",
    "enemyColor",
    "friendlyColor",
    "neutralColor",
    "targetColor",
    "castInterruptibleColor",
    "castUninterruptibleColor",
    "castFriendlyColor",
    "healthTextColor",
}

function CleanPlates:IsFrameStylingSupported()
    return FRAME_STYLING_SUPPORTED == true
end

function CleanPlates:IsNameStylingSupported()
    return FRAME_STYLING_SUPPORTED == true and NAME_STYLING_SUPPORTED == true
end

local function copyDefaults(source, target)
    if type(source) ~= "table" then
        return target
    end

    if type(target) ~= "table" then
        target = {}
    end

    for key, value in pairs(source) do
        if type(value) == "table" then
            if type(target[key]) ~= "table" then
                target[key] = {}
            end
            copyDefaults(value, target[key])
        elseif target[key] == nil then
            target[key] = value
        end
    end

    return target
end

local function deepCopyTable(source)
    if type(source) ~= "table" then
        return source
    end

    local target = {}
    for key, value in pairs(source) do
        target[key] = deepCopyTable(value)
    end
    return target
end

local function getOptionalAceLib(libName)
    if (type(LibStub) ~= "table" and type(LibStub) ~= "function") or type(libName) ~= "string" then
        return nil
    end
    local ok, library = pcall(LibStub, libName, true)
    if not ok then
        return nil
    end
    return library
end

local function buildCharacterProfileKey()
    local playerName = type(UnitName) == "function" and UnitName("player") or nil
    local realmName = type(GetRealmName) == "function" and GetRealmName() or nil
    playerName = (type(playerName) == "string" and playerName ~= "") and playerName or "Unknown"
    realmName = (type(realmName) == "string" and realmName ~= "") and realmName or "Unknown"
    return string.format("%s - %s", playerName, realmName)
end

local function trim(text)
    return (text:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function startsWith(text, prefix)
    if type(text) ~= "string" or type(prefix) ~= "string" then
        return false
    end

    return text:sub(1, #prefix) == prefix
end

function CleanPlates:MigrateLegacyDatabaseForAce()
    if type(CleanPlatesDB) ~= "table" then
        CleanPlatesDB = {}
    end

    if type(CleanPlatesDB.profiles) == "table" and type(CleanPlatesDB.profileKeys) == "table" then
        return
    end

    local legacyRoot = copyDefaults(defaults, deepCopyTable(CleanPlatesDB))
    local requestedProfileName = PROFILE_DEFAULT_NAME
    if type(CleanPlatesDB.activeProfileName) == "string" and CleanPlatesDB.activeProfileName ~= "" then
        requestedProfileName = CleanPlatesDB.activeProfileName
    end

    local migratedProfiles = {}
    if type(CleanPlatesDB.profiles) == "table" then
        for profileName, profileData in pairs(CleanPlatesDB.profiles) do
            if type(profileName) == "string" and profileName ~= "" and type(profileData) == "table" then
                migratedProfiles[profileName] = copyDefaults(defaults, deepCopyTable(profileData))
            end
        end
    end

    if type(migratedProfiles[PROFILE_DEFAULT_NAME]) ~= "table" then
        migratedProfiles[PROFILE_DEFAULT_NAME] = copyDefaults(defaults, {})
    end

    if type(migratedProfiles[requestedProfileName]) ~= "table" then
        migratedProfiles[requestedProfileName] = copyDefaults(defaults, deepCopyTable(legacyRoot))
    end

    CleanPlatesDB = {
        profileKeys = {
            [buildCharacterProfileKey()] = requestedProfileName,
        },
        profiles = migratedProfiles,
    }
end

function CleanPlates:OnAceProfileChanged()
    if not self.aceDB then
        return
    end
    self.db = self.aceDB.profile
    self:NormalizeSettings()
    self.forceCVarReapply = true
    if self.RefreshOptions then
        self:RefreshOptions()
    end
    self:Refresh()
end

function CleanPlates:InitializeDatabase()
    local aceDBLib = getOptionalAceLib("AceDB-3.0")
    if aceDBLib and type(aceDBLib.New) == "function" then
        self:MigrateLegacyDatabaseForAce()
        local aceDefaults = {
            profile = deepCopyTable(defaults),
        }
        self.aceDB = aceDBLib:New("CleanPlatesDB", aceDefaults, PROFILE_DEFAULT_NAME)
        self.db = self.aceDB.profile
        self.usingAceDB = true
        if type(self.aceDB.RegisterCallback) == "function" then
            self.aceDB:RegisterCallback(self, "OnProfileChanged", "OnAceProfileChanged")
            self.aceDB:RegisterCallback(self, "OnProfileCopied", "OnAceProfileChanged")
            self.aceDB:RegisterCallback(self, "OnProfileReset", "OnAceProfileChanged")
            self.aceDB:RegisterCallback(self, "OnNewProfile", "OnAceProfileChanged")
        end
        self:NormalizeSettings()
        return
    end

    CleanPlatesDB = copyDefaults(defaults, CleanPlatesDB or {})
    self.db = CleanPlatesDB
    self.aceDB = nil
    self.usingAceDB = false
    self:NormalizeSettings()
    self:EnsureProfileStore()
end

local function getUnit(unitFrame)
    if not unitFrame then
        return nil
    end

    local unit = unitFrame.displayedUnit or unitFrame.unit
    if type(unit) ~= "string" or unit == "" then
        return nil
    end
    if type(issecretvalue) == "function" then
        local ok, secret = pcall(issecretvalue, unit)
        if ok and secret then
            return nil
        end
    end
    if type(canaccessvalue) == "function" then
        local ok, accessible = pcall(canaccessvalue, unit)
        if ok and not accessible then
            return nil
        end
    end
    return unit
end

local function getHealthBar(unitFrame)
    if not unitFrame then
        return nil
    end

    if unitFrame.healthBar then
        return unitFrame.healthBar
    end

    if unitFrame.HealthBarsContainer and unitFrame.HealthBarsContainer.healthBar then
        return unitFrame.HealthBarsContainer.healthBar
    end

    return nil
end

local function getCastBar(unitFrame)
    if not unitFrame then
        return nil
    end

    return unitFrame.castBar or unitFrame.SpellCastBar or unitFrame.CastBar
end

local function isForbiddenObject(object)
    return object and type(object.IsForbidden) == "function" and object:IsForbidden()
end

local function isSecretValue(value)
    if type(issecretvalue) ~= "function" then
        return false
    end

    local ok, isSecret = pcall(issecretvalue, value)
    return ok and isSecret or false
end

local function toSafeBoolean(value)
    if value == nil or isSecretValue(value) then
        return false
    end
    if type(canaccessvalue) == "function" then
        local ok, canAccess = pcall(canaccessvalue, value)
        if ok and not canAccess then
            return false
        end
    end

    local ok, booleanValue = pcall(function(input)
        return input and true or false
    end, value)
    if not ok then
        return false
    end
    return booleanValue
end

local function safeUnitExists(unit)
    local ok, exists = pcall(UnitExists, unit)
    return ok and toSafeBoolean(exists)
end

local function safeUnitCanAttack(unit)
    local ok, canAttack = pcall(UnitCanAttack, "player", unit)
    return ok and toSafeBoolean(canAttack)
end

local function safeFrameIsFriend(unitFrame)
    if not unitFrame then
        return nil
    end

    local value = unitFrame.isFriend
    if value == nil or isSecretValue(value) then
        return nil
    end
    if type(canaccessvalue) == "function" then
        local ok, accessible = pcall(canaccessvalue, value)
        if ok and not accessible then
            return nil
        end
    end
    return toSafeBoolean(value)
end

local function safeUnitIsPlayer(unit)
    local ok, isPlayer = pcall(UnitIsPlayer, unit)
    return ok and toSafeBoolean(isPlayer)
end

local function safeUnitIsDead(unit)
    if type(UnitIsDeadOrGhost) == "function" then
        local ok, isDeadOrGhost = pcall(UnitIsDeadOrGhost, unit)
        if ok then
            return toSafeBoolean(isDeadOrGhost)
        end
    end
    if type(UnitIsDead) == "function" then
        local ok, isDead = pcall(UnitIsDead, unit)
        if ok then
            return toSafeBoolean(isDead)
        end
    end
    return false
end

local function safeUnitIsUnit(unitA, unitB)
    local ok, isSame = pcall(UnitIsUnit, unitA, unitB)
    return ok and toSafeBoolean(isSame)
end

local function safeUnitReaction(unitA, unitB)
    local ok, reaction = pcall(UnitReaction, unitA, unitB)
    if not ok or reaction == nil or isSecretValue(reaction) then
        return nil
    end

    if type(reaction) == "number" then
        return reaction
    end

    local convertOk, numericReaction = pcall(tonumber, reaction)
    if not convertOk then
        return nil
    end
    return numericReaction
end

local function safeUnitIsEnemy(unitFrame, unit)
    local isFriend = safeFrameIsFriend(unitFrame)
    if type(isFriend) == "boolean" then
        return not isFriend
    end
    return safeUnitCanAttack(unit)
end

local function clamp(value, minValue, maxValue)
    if value < minValue then
        return minValue
    end
    if value > maxValue then
        return maxValue
    end
    return value
end

local function getNow()
    if type(GetTimePreciseSec) == "function" then
        return GetTimePreciseSec()
    end
    if type(GetTime) == "function" then
        return GetTime()
    end
    return 0
end

local function getReadableNameFontFlags(flags)
    if type(flags) ~= "string" or flags == "" then
        return "THICKOUTLINE"
    end

    if flags:find("THICKOUTLINE", 1, true) then
        return flags
    end

    if flags:find("OUTLINE", 1, true) then
        return flags:gsub("OUTLINE", "THICKOUTLINE", 1)
    end

    if flags:find("MONOCHROME", 1, true) then
        return "MONOCHROME,THICKOUTLINE"
    end

    return "THICKOUTLINE"
end

local function adjustBrightTextColor(r, g, b)
    local luminance = (0.299 * r) + (0.587 * g) + (0.114 * b)
    if luminance > 0.72 then
        return 1, 1, 1
    end
    return r, g, b
end

local function boolToCVar(value)
    return value and "1" or "0"
end

local function cvarToBool(value, fallback)
    if value == nil then
        return fallback == true
    end
    if type(value) == "boolean" then
        return value
    end
    if type(value) == "number" then
        return value ~= 0
    end
    value = tostring(value)
    return value ~= "0" and value ~= ""
end

local function getCVarValue(cvarName)
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

    return nil
end

local function setCVarValue(cvarName, value)
    local targetValue = tostring(value)

    if C_CVar and type(C_CVar.SetCVar) == "function" then
        local ok = pcall(C_CVar.SetCVar, cvarName, targetValue)
        if ok then
            return true
        end
    end

    if type(SetCVar) == "function" then
        local ok = pcall(SetCVar, cvarName, targetValue)
        if ok then
            return true
        end
    end

    return false
end

local function setCVarIfDifferent(cvarName, value)
    local targetValue = tostring(value)
    local currentValue = getCVarValue(cvarName)
    if currentValue ~= targetValue then
        setCVarValue(cvarName, targetValue)
    end
end

local function setAnyCVarIfDifferent(cvarNames, value)
    if type(cvarNames) ~= "table" then
        return
    end

    local targetValue = tostring(value)
    for i = 1, #cvarNames do
        local cvarName = cvarNames[i]
        if type(cvarName) == "string" and cvarName ~= "" then
            local currentValue = getCVarValue(cvarName)
            if currentValue == nil or currentValue ~= targetValue then
                setCVarValue(cvarName, targetValue)
            end
        end
    end
end

local function getFirstAvailableCVar(cvarNames)
    if type(cvarNames) ~= "table" then
        return nil, nil
    end

    for i = 1, #cvarNames do
        local cvarName = cvarNames[i]
        if type(cvarName) == "string" and cvarName ~= "" then
            local value = getCVarValue(cvarName)
            if value ~= nil then
                return cvarName, value
            end
        end
    end

    local fallback = cvarNames[1]
    return fallback, getCVarValue(fallback)
end

local function setNumericCVarIfDifferent(cvarName, value)
    local targetValue = tonumber(value)
    if not targetValue then
        return
    end

    local currentNumber = tonumber(getCVarValue(cvarName))
    local targetText
    if math.abs(targetValue - math.floor(targetValue + 0.5)) < 0.0001 then
        targetText = tostring(math.floor(targetValue + 0.5))
    else
        targetText = string.format("%.3f", targetValue)
    end

    if currentNumber == nil or math.abs(currentNumber - targetValue) > 0.0001 then
        setCVarValue(cvarName, targetText)
    end
end

local function getCVarBitfieldValue(cvarName, bitIndex)
    if not C_CVar or type(C_CVar.GetCVarBitfield) ~= "function" then
        return nil
    end
    if type(cvarName) ~= "string" or cvarName == "" or type(bitIndex) ~= "number" then
        return nil
    end

    local ok, value = pcall(C_CVar.GetCVarBitfield, cvarName, bitIndex)
    if not ok then
        return nil
    end
    return toSafeBoolean(value)
end

local function setCVarBitfieldIfDifferent(cvarName, bitIndex, value)
    if not C_CVar or type(C_CVar.SetCVarBitfield) ~= "function" then
        return false
    end
    if type(cvarName) ~= "string" or cvarName == "" or type(bitIndex) ~= "number" then
        return false
    end

    local target = value and true or false
    local current = getCVarBitfieldValue(cvarName, bitIndex)
    if current ~= nil and current == target then
        return false
    end

    local ok = pcall(C_CVar.SetCVarBitfield, cvarName, bitIndex, target)
    return ok
end

local function readNumericCVar(cvarName)
    local value = tonumber(getCVarValue(cvarName))
    if not value or value ~= value then
        return nil
    end
    return value
end

local function numbersClose(a, b, epsilon)
    if type(a) ~= "number" or type(b) ~= "number" then
        return false
    end
    return math.abs(a - b) <= (epsilon or 0.0001)
end

local function parseColorInput(input)
    local target, rText, gText, bText = input:match("^color%s+(%a+)%s+([%d%.]+)%s+([%d%.]+)%s+([%d%.]+)$")
    if not target then
        return nil
    end

    local r = tonumber(rText)
    local g = tonumber(gText)
    local b = tonumber(bText)
    if not r or not g or not b then
        return nil
    end

    if r > 1 or g > 1 or b > 1 then
        r = r / 255
        g = g / 255
        b = b / 255
    end

    return target:lower(), clamp(r, 0, 1), clamp(g, 0, 1), clamp(b, 0, 1)
end

local function to255(value)
    return math.floor((value * 255) + 0.5)
end

local function colorToHex(color)
    return string.format("%02X%02X%02X", to255(color.r), to255(color.g), to255(color.b))
end

local function hexToColor(hex)
    if type(hex) ~= "string" or not hex:match("^%x%x%x%x%x%x$") then
        return nil
    end

    local r = tonumber(hex:sub(1, 2), 16) / 255
    local g = tonumber(hex:sub(3, 4), 16) / 255
    local b = tonumber(hex:sub(5, 6), 16) / 255
    return { r = r, g = g, b = b }
end

function CleanPlates:Print(message)
    if DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage("|cff40c7ebCleanPlates|r: " .. message)
    end
end

function CleanPlates:DisableHealthPercentFeature(reason)
    self.healthPercentBlocked = true
    if self.db then
        self.db.showHealthPercent = false
    end

    if self.RefreshOptions then
        self:RefreshOptions()
    end

    if reason and not self.healthPercentDisableNotified then
        self.healthPercentDisableNotified = true
        self:Print(reason)
    end
end

function CleanPlates:Debug(message)
    if self.db and self.db.debug then
        self:Print("|cff9be89bDEBUG|r " .. message)
    end
end

local function normalizeColor(source, fallback)
    source = source or {}
    return {
        r = clamp(tonumber(source.r) or fallback.r, 0, 1),
        g = clamp(tonumber(source.g) or fallback.g, 0, 1),
        b = clamp(tonumber(source.b) or fallback.b, 0, 1),
    }
end

function CleanPlates:NormalizeSettings()
    if not self.db then
        return
    end

    self.db.enabled = self.db.enabled ~= false
    self.db.nameFontSize = clamp(tonumber(self.db.nameFontSize) or defaults.nameFontSize, 8, 24)
    self.db.combatTextFontSize = clamp(tonumber(self.db.combatTextFontSize) or defaults.combatTextFontSize, 16, 40)
    self.db.targetFontBoost = clamp(tonumber(self.db.targetFontBoost) or defaults.targetFontBoost, 0, 8)
    self.db.maxBuffs = clamp(tonumber(self.db.maxBuffs) or defaults.maxBuffs, 0, 8)
    self.db.maxDebuffs = clamp(tonumber(self.db.maxDebuffs) or defaults.maxDebuffs, 0, 8)
    self.db.nameplateGlobalScale = clamp(tonumber(self.db.nameplateGlobalScale) or defaults.nameplateGlobalScale, 0.6, 2.0)
    self.db.nameplateHorizontalScale = clamp(tonumber(self.db.nameplateHorizontalScale) or defaults.nameplateHorizontalScale, 0.6, 1.8)
    self.db.nameplateVerticalScale = clamp(tonumber(self.db.nameplateVerticalScale) or defaults.nameplateVerticalScale, 0.6, 2.0)
    self.db.nameplateHeightMultiplier = clamp(tonumber(self.db.nameplateHeightMultiplier) or defaults.nameplateHeightMultiplier, 0.5, 2.5)
    self.db.nameplateXSpacing = clamp(tonumber(self.db.nameplateXSpacing) or defaults.nameplateXSpacing, 0.05, 2.0)
    self.db.nameplateYSpacing = clamp(tonumber(self.db.nameplateYSpacing) or defaults.nameplateYSpacing, 0.05, 2.0)
    self.db.nameplateSelectedScale = clamp(tonumber(self.db.nameplateSelectedScale) or defaults.nameplateSelectedScale, 1.0, 2.5)
    self.db.nameplateMaxDistance = clamp(tonumber(self.db.nameplateMaxDistance) or defaults.nameplateMaxDistance, 20, 100)
    self.db.castBarScale = clamp(tonumber(self.db.castBarScale) or defaults.castBarScale, 0.6, 2.0)
    self.db.targetHighlight = self.db.targetHighlight ~= false
    self.db.classColorPlayers = self.db.classColorPlayers ~= false
    self.db.styleCombatText = self.db.styleCombatText ~= false
    self.db.enableCastStateColors = self.db.enableCastStateColors ~= false
    self.db.showHealthPercent = self.db.showHealthPercent ~= false
    self.db.healthPercentEnemiesOnly = self.db.healthPercentEnemiesOnly ~= false
    self.db.debug = self.db.debug == true
    self.db.showQuestMarker = self.db.showQuestMarker ~= false
    self.db.showEnemyPlates = self.db.showEnemyPlates ~= false
    self.db.showFriendlyPlates = self.db.showFriendlyPlates ~= false
    self.db.showEnemyPets = self.db.showEnemyPets ~= false
    self.db.showEnemyGuardians = self.db.showEnemyGuardians ~= false
    self.db.showEnemyTotems = self.db.showEnemyTotems ~= false
    self.db.showEnemyMinions = self.db.showEnemyMinions ~= false
    self.db.showFriendlyPets = self.db.showFriendlyPets ~= false
    self.db.showFriendlyGuardians = self.db.showFriendlyGuardians ~= false
    self.db.showFriendlyTotems = self.db.showFriendlyTotems ~= false
    self.db.showFriendlyMinions = self.db.showFriendlyMinions ~= false
    self.db.showDebuffsOnEnemy = self.db.showDebuffsOnEnemy ~= false
    self.db.showBuffsOnEnemy = self.db.showBuffsOnEnemy == true
    self.db.showDebuffsOnFriendly = self.db.showDebuffsOnFriendly == true
    self.db.showBuffsOnFriendly = self.db.showBuffsOnFriendly == true

    if type(self.db.preset) ~= "string" or not presets[self.db.preset] then
        self.db.preset = defaults.preset
    end
    if type(self.db.plateArtStyle) ~= "string" or not plateArtStyles[self.db.plateArtStyle] then
        self.db.plateArtStyle = defaults.plateArtStyle
    end

    self.db.enemyColor = normalizeColor(self.db.enemyColor, defaults.enemyColor)
    self.db.friendlyColor = normalizeColor(self.db.friendlyColor, defaults.friendlyColor)
    self.db.neutralColor = normalizeColor(self.db.neutralColor, defaults.neutralColor)
    self.db.targetColor = normalizeColor(self.db.targetColor, defaults.targetColor)
    self.db.castInterruptibleColor = normalizeColor(self.db.castInterruptibleColor, defaults.castInterruptibleColor)
    self.db.castUninterruptibleColor = normalizeColor(self.db.castUninterruptibleColor, defaults.castUninterruptibleColor)
    self.db.castFriendlyColor = normalizeColor(self.db.castFriendlyColor, defaults.castFriendlyColor)
    self.db.healthTextColor = normalizeColor(self.db.healthTextColor, defaults.healthTextColor)

    if not HEALTH_PERCENT_SUPPORTED then
        self.healthPercentBlocked = true
        self.db.showHealthPercent = false
    end
end

function CleanPlates:CaptureCurrentSettings()
    local snapshot = {}
    if not self.db then
        return copyDefaults(defaults, snapshot)
    end

    for i = 1, #PROFILE_SETTING_KEYS do
        local key = PROFILE_SETTING_KEYS[i]
        local value = self.db[key]
        if value == nil then
            value = defaults[key]
        end
        snapshot[key] = deepCopyTable(value)
    end

    return copyDefaults(defaults, snapshot)
end

function CleanPlates:ApplySettingsSnapshot(snapshot, suppressRefresh)
    if type(snapshot) ~= "table" or not self.db then
        return false, "Invalid profile data."
    end

    for i = 1, #PROFILE_SETTING_KEYS do
        local key = PROFILE_SETTING_KEYS[i]
        local value = snapshot[key]
        if value == nil then
            value = defaults[key]
        end
        self.db[key] = deepCopyTable(value)
    end

    self:NormalizeSettings()
    self.forceCVarReapply = true
    if self.RefreshOptions then
        self:RefreshOptions()
    end
    if not suppressRefresh then
        self:Refresh()
    end
    return true
end

function CleanPlates:EnsureProfileStore()
    if self.aceDB then
        return
    end

    if not self.db then
        return
    end

    if type(self.db.profiles) ~= "table" then
        self.db.profiles = {}
    end

    if type(self.db.activeProfileName) ~= "string" or self.db.activeProfileName == "" then
        self.db.activeProfileName = PROFILE_DEFAULT_NAME
    end

    if type(self.db.profiles[PROFILE_DEFAULT_NAME]) ~= "table" then
        self.db.profiles[PROFILE_DEFAULT_NAME] = copyDefaults(defaults, {})
    end

    if type(self.db.profiles[self.db.activeProfileName]) ~= "table" then
        self.db.profiles[self.db.activeProfileName] = self:CaptureCurrentSettings()
    end
end

function CleanPlates:GetActiveProfileName()
    if self.aceDB and type(self.aceDB.GetCurrentProfile) == "function" then
        return self.aceDB:GetCurrentProfile() or PROFILE_DEFAULT_NAME
    end

    if not self.db then
        return PROFILE_DEFAULT_NAME
    end

    self:EnsureProfileStore()
    return self.db.activeProfileName or PROFILE_DEFAULT_NAME
end

function CleanPlates:GetProfileNames()
    local names = {}
    if self.aceDB and type(self.aceDB.GetProfiles) == "function" then
        self.aceDB:GetProfiles(names)
        table.sort(names, function(a, b)
            return tostring(a):lower() < tostring(b):lower()
        end)
        return names
    end

    if not self.db then
        return names
    end

    self:EnsureProfileStore()
    for profileName, profileData in pairs(self.db.profiles) do
        if type(profileName) == "string" and profileName ~= "" and type(profileData) == "table" then
            names[#names + 1] = profileName
        end
    end

    table.sort(names, function(a, b)
        return a:lower() < b:lower()
    end)
    return names
end

function CleanPlates:SaveProfile(profileName)
    if not self.db then
        return false, "Database is not ready."
    end

    profileName = trim(profileName or "")
    if profileName == "" then
        return false, "Profile name is empty."
    end

    if self.aceDB and type(self.aceDB.SetProfile) == "function" then
        local snapshot = self:CaptureCurrentSettings()
        local ok, err = pcall(self.aceDB.SetProfile, self.aceDB, profileName)
        if not ok then
            return false, tostring(err or "Failed to switch profile.")
        end
        self.db = self.aceDB.profile
        local applyOk, reason = self:ApplySettingsSnapshot(snapshot, true)
        if not applyOk then
            return false, reason
        end
        self.forceCVarReapply = true
        if self.RefreshOptions then
            self:RefreshOptions()
        end
        self:Refresh()
        return true
    end

    self:EnsureProfileStore()
    self.db.profiles[profileName] = self:CaptureCurrentSettings()
    self.db.activeProfileName = profileName
    if self.RefreshOptions then
        self:RefreshOptions()
    end
    return true
end

function CleanPlates:LoadProfile(profileName)
    if not self.db then
        return false, "Database is not ready."
    end

    profileName = trim(profileName or "")
    if profileName == "" then
        return false, "Profile name is empty."
    end

    if self.aceDB and type(self.aceDB.SetProfile) == "function" and type(self.aceDB.GetProfiles) == "function" then
        local names = {}
        self.aceDB:GetProfiles(names)
        local found = false
        for i = 1, #names do
            if names[i] == profileName then
                found = true
                break
            end
        end
        if not found then
            return false, "Profile not found."
        end
        local ok, err = pcall(self.aceDB.SetProfile, self.aceDB, profileName)
        if not ok then
            return false, tostring(err or "Failed to load profile.")
        end
        self.db = self.aceDB.profile
        self:NormalizeSettings()
        self.forceCVarReapply = true
        if self.RefreshOptions then
            self:RefreshOptions()
        end
        self:Refresh()
        return true
    end

    self:EnsureProfileStore()
    local profileData = self.db.profiles[profileName]
    if type(profileData) ~= "table" then
        return false, "Profile not found."
    end

    self.db.activeProfileName = profileName
    return self:ApplySettingsSnapshot(profileData)
end

function CleanPlates:DeleteProfile(profileName)
    if not self.db then
        return false, "Database is not ready."
    end

    profileName = trim(profileName or "")
    if profileName == "" then
        return false, "Profile name is empty."
    end

    if self.aceDB and type(self.aceDB.DeleteProfile) == "function" then
        if profileName == PROFILE_DEFAULT_NAME then
            return false, "Default profile cannot be deleted."
        end
        if type(self.aceDB.GetProfiles) == "function" then
            local names = {}
            self.aceDB:GetProfiles(names)
            local exists = false
            for i = 1, #names do
                if names[i] == profileName then
                    exists = true
                    break
                end
            end
            if not exists then
                return false, "Profile not found."
            end
        end
        local currentProfile = self.aceDB.GetCurrentProfile and self.aceDB:GetCurrentProfile() or PROFILE_DEFAULT_NAME
        if currentProfile == profileName and type(self.aceDB.SetProfile) == "function" then
            local okSet, errSet = pcall(self.aceDB.SetProfile, self.aceDB, PROFILE_DEFAULT_NAME)
            if not okSet then
                return false, tostring(errSet or "Failed to switch off active profile.")
            end
            self.db = self.aceDB.profile
        end
        local ok, err = pcall(self.aceDB.DeleteProfile, self.aceDB, profileName, true)
        if not ok then
            return false, tostring(err or "Delete failed.")
        end
        if self.RefreshOptions then
            self:RefreshOptions()
        end
        self:Refresh()
        return true
    end

    self:EnsureProfileStore()
    if profileName == PROFILE_DEFAULT_NAME then
        return false, "Default profile cannot be deleted."
    end

    if type(self.db.profiles[profileName]) ~= "table" then
        return false, "Profile not found."
    end

    self.db.profiles[profileName] = nil
    if self.db.activeProfileName == profileName then
        self.db.activeProfileName = PROFILE_DEFAULT_NAME
        self:ApplySettingsSnapshot(self.db.profiles[PROFILE_DEFAULT_NAME])
    elseif self.RefreshOptions then
        self:RefreshOptions()
    end
    return true
end

function CleanPlates:ResetActiveProfile()
    if not self.db then
        return false, "Database is not ready."
    end

    if self.aceDB and type(self.aceDB.ResetProfile) == "function" then
        local ok, err = pcall(self.aceDB.ResetProfile, self.aceDB)
        if not ok then
            return false, tostring(err or "Reset failed.")
        end
        self.db = self.aceDB.profile
        self:NormalizeSettings()
        self.forceCVarReapply = true
        if self.RefreshOptions then
            self:RefreshOptions()
        end
        self:Refresh()
        return true
    end

    self:EnsureProfileStore()
    local profileName = self.db.activeProfileName or PROFILE_DEFAULT_NAME
    self.db.profiles[profileName] = copyDefaults(defaults, {})
    self.db.activeProfileName = profileName
    return self:ApplySettingsSnapshot(self.db.profiles[profileName])
end

function CleanPlates:SetPaletteColor(target, r, g, b)
    if not self.db then
        return false
    end

    local fieldName
    if target == "enemy" then
        fieldName = "enemyColor"
    elseif target == "friendly" then
        fieldName = "friendlyColor"
    elseif target == "neutral" then
        fieldName = "neutralColor"
    elseif target == "target" then
        fieldName = "targetColor"
    elseif target == "castint" then
        fieldName = "castInterruptibleColor"
    elseif target == "castlock" then
        fieldName = "castUninterruptibleColor"
    elseif target == "castfriendly" then
        fieldName = "castFriendlyColor"
    elseif target == "healthtext" then
        fieldName = "healthTextColor"
    end

    if not fieldName then
        return false
    end

    self.db[fieldName] = {
        r = clamp(r, 0, 1),
        g = clamp(g, 0, 1),
        b = clamp(b, 0, 1),
    }
    self:Debug(string.format("set %s color to %.3f %.3f %.3f", target, r, g, b))
    return true
end

function CleanPlates:SetPlateArtStyle(styleName, silent)
    if not self.db then
        return false
    end

    styleName = trim(styleName or ""):lower()
    if not plateArtStyles[styleName] then
        return false
    end

    self.db.plateArtStyle = styleName
    if self.RefreshOptions then
        self:RefreshOptions()
    end
    self:Refresh()
    if not silent then
        self:Print("Plate art set to: " .. styleName)
    end
    return true
end

function CleanPlates:GetPlateArtStyleNames()
    local names = {}
    for i = 1, #plateArtStyleOrder do
        names[i] = plateArtStyleOrder[i]
    end
    return names
end

function CleanPlates:GetPlateArtStyleConfig()
    local styleName = (self.db and self.db.plateArtStyle) or defaults.plateArtStyle
    return plateArtStyles[styleName] or plateArtStyles[defaults.plateArtStyle] or plateArtStyles.clean or {}
end

local function getStyleScale(style, key)
    local value = style and style[key]
    if type(value) ~= "number" then
        return 1
    end
    return value
end

function CleanPlates:GetSharedMedia()
    if self.sharedMediaChecked then
        return self.sharedMedia
    end

    self.sharedMediaChecked = true
    if type(LibStub) ~= "function" then
        return nil
    end

    local ok, lsm = pcall(LibStub, "LibSharedMedia-3.0", true)
    if ok and type(lsm) == "table" then
        self.sharedMedia = lsm
    end
    return self.sharedMedia
end

function CleanPlates:ResolveStatusBarTexture(textureValue, fallbackPath)
    local fallback = fallbackPath or defaults.castTexture
    if type(textureValue) ~= "string" or textureValue == "" then
        return fallback
    end

    -- Direct texture path.
    if textureValue:find("\\", 1, true) or textureValue:find("/", 1, true) then
        return textureValue
    end

    -- Optional external media integration (LibSharedMedia-3.0).
    local lsm = self:GetSharedMedia()
    if lsm and type(lsm.Fetch) == "function" then
        local ok, resolvedPath = pcall(lsm.Fetch, lsm, "statusbar", textureValue, true)
        if ok and type(resolvedPath) == "string" and resolvedPath ~= "" then
            return resolvedPath
        end
    end

    return fallback
end

function CleanPlates:GetResolvedCastTexture()
    local style = self:GetPlateArtStyleConfig()
    local requested = (style and style.castTexture) or (self.db and self.db.castTexture) or defaults.castTexture
    return self:ResolveStatusBarTexture(requested, defaults.castTexture)
end

function CleanPlates:GetResolvedHealthTexture()
    local style = self:GetPlateArtStyleConfig()
    local requested = (style and style.healthTexture) or (self.db and self.db.healthTexture) or defaults.healthTexture
    return self:ResolveStatusBarTexture(requested, defaults.healthTexture)
end

function CleanPlates:GetAvailableStatusBarTextures()
    local names = {}
    local lsm = self:GetSharedMedia()
    if not lsm or type(lsm.HashTable) ~= "function" then
        return names
    end

    local ok, tableRef = pcall(lsm.HashTable, lsm, "statusbar")
    if not ok or type(tableRef) ~= "table" then
        return names
    end

    for textureName in pairs(tableRef) do
        if type(textureName) == "string" and textureName ~= "" then
            names[#names + 1] = textureName
        end
    end

    table.sort(names)
    return names
end

function CleanPlates:SetTextureSelection(kind, textureValue)
    if not self.db then
        return false, "DB not initialized."
    end

    local key
    local fallback
    if kind == "health" then
        key = "healthTexture"
        fallback = defaults.healthTexture
    elseif kind == "cast" then
        key = "castTexture"
        fallback = defaults.castTexture
    else
        return false, "Unknown texture target."
    end

    local value = trim(textureValue or "")
    if value == "" then
        return false, "Texture is empty."
    end

    if value:lower() == "default" then
        value = fallback
    end

    self.db[key] = value
    if self.RefreshOptions then
        self:RefreshOptions()
    end
    self:Refresh()
    return true
end

function CleanPlates:EnsureNameplateBaseSizes()
    if self.baseNameplateWidth and self.baseNameplateHeight and self.baseEnemyWidth and self.baseEnemyHeight and self.baseFriendlyWidth and self.baseFriendlyHeight then
        return
    end
    if not C_NamePlate then
        return
    end

    if (not self.baseNameplateWidth or not self.baseNameplateHeight) and type(C_NamePlate.GetNamePlateSize) == "function" then
        local ok, width, height = pcall(C_NamePlate.GetNamePlateSize)
        if ok and type(width) == "number" and type(height) == "number" and width > 0 and height > 0 then
            self.baseNameplateWidth = width
            self.baseNameplateHeight = height
            if not self.baseEnemyWidth or not self.baseEnemyHeight then
                self.baseEnemyWidth = width
                self.baseEnemyHeight = height
            end
            if not self.baseFriendlyWidth or not self.baseFriendlyHeight then
                self.baseFriendlyWidth = width
                self.baseFriendlyHeight = height
            end
        end
    end

    if (not self.baseEnemyWidth or not self.baseEnemyHeight) and type(C_NamePlate.GetNamePlateEnemySize) == "function" then
        local ok, width, height = pcall(C_NamePlate.GetNamePlateEnemySize)
        if ok and type(width) == "number" and type(height) == "number" and width > 0 and height > 0 then
            self.baseEnemyWidth = width
            self.baseEnemyHeight = height
        end
    end

    if (not self.baseFriendlyWidth or not self.baseFriendlyHeight) and type(C_NamePlate.GetNamePlateFriendlySize) == "function" then
        local ok, width, height = pcall(C_NamePlate.GetNamePlateFriendlySize)
        if ok and type(width) == "number" and type(height) == "number" and width > 0 and height > 0 then
            self.baseFriendlyWidth = width
            self.baseFriendlyHeight = height
        end
    end

    -- Retail fallback defaults used by Blizzard/major plate addons when API getters are unavailable.
    if not self.baseNameplateWidth or not self.baseNameplateHeight then
        self.baseNameplateWidth = self.baseNameplateWidth or 110
        self.baseNameplateHeight = self.baseNameplateHeight or 40
    end
    if not self.baseEnemyWidth or not self.baseEnemyHeight then
        self.baseEnemyWidth = self.baseEnemyWidth or self.baseNameplateWidth or 110
        self.baseEnemyHeight = self.baseEnemyHeight or self.baseNameplateHeight or 40
    end
    if not self.baseFriendlyWidth or not self.baseFriendlyHeight then
        self.baseFriendlyWidth = self.baseFriendlyWidth or self.baseNameplateWidth or 110
        self.baseFriendlyHeight = self.baseFriendlyHeight or self.baseNameplateHeight or 40
    end
end

function CleanPlates:ApplyNameplateApiSizes(globalScale, horizontalScale, verticalScale)
    if not C_NamePlate then
        return false
    end
    if InCombatLockdown and InCombatLockdown() then
        self.pendingSizeApplyAfterCombat = true
        self.nameplateSizeMode = "deferred-combat"
        self:Debug("nameplate API size deferred (combat lockdown)")
        return false
    end

    self:EnsureNameplateBaseSizes()
    local factorW = globalScale * horizontalScale
    local factorH = globalScale * verticalScale
    local applied = false

    local requestedGeneralWidth
    local requestedGeneralHeight
    local requestedEnemyWidth
    local requestedEnemyHeight
    local requestedFriendlyWidth
    local requestedFriendlyHeight

    if self.baseNameplateWidth and self.baseNameplateHeight and type(C_NamePlate.SetNamePlateSize) == "function" then
        local width = clamp(self.baseNameplateWidth * factorW, 20, 500)
        local height = clamp(self.baseNameplateHeight * factorH, 6, 200)
        requestedGeneralWidth = width
        requestedGeneralHeight = height
        local ok, err = pcall(C_NamePlate.SetNamePlateSize, width, height)
        if ok then
            applied = true
        else
            self:Debug("SetNamePlateSize failed: " .. tostring(err))
        end
    end

    if self.baseEnemyWidth and self.baseEnemyHeight and type(C_NamePlate.SetNamePlateEnemySize) == "function" then
        local enemyWidth = clamp(self.baseEnemyWidth * factorW, 20, 500)
        local enemyHeight = clamp(self.baseEnemyHeight * factorH, 6, 200)
        requestedEnemyWidth = enemyWidth
        requestedEnemyHeight = enemyHeight
        local ok, err = pcall(C_NamePlate.SetNamePlateEnemySize, enemyWidth, enemyHeight)
        if ok then
            applied = true
        else
            self:Debug("SetNamePlateEnemySize failed: " .. tostring(err))
        end
    end

    if self.baseFriendlyWidth and self.baseFriendlyHeight and type(C_NamePlate.SetNamePlateFriendlySize) == "function" then
        local friendlyWidth = clamp(self.baseFriendlyWidth * factorW, 20, 500)
        local friendlyHeight = clamp(self.baseFriendlyHeight * factorH, 6, 200)
        requestedFriendlyWidth = friendlyWidth
        requestedFriendlyHeight = friendlyHeight
        local ok, err = pcall(C_NamePlate.SetNamePlateFriendlySize, friendlyWidth, friendlyHeight)
        if ok then
            applied = true
        else
            self:Debug("SetNamePlateFriendlySize failed: " .. tostring(err))
        end
    end

    if self.db and self.db.debug then
        self:Debug(string.format(
            "API target sizes general=%.1fx%.1f enemy=%.1fx%.1f friendly=%.1fx%.1f (factors %.2f/%.2f)",
            requestedGeneralWidth or -1,
            requestedGeneralHeight or -1,
            requestedEnemyWidth or -1,
            requestedEnemyHeight or -1,
            requestedFriendlyWidth or -1,
            requestedFriendlyHeight or -1,
            factorW,
            factorH
        ))
    end

    if applied then
        local requestedChecks = 0
        local verifiedChecks = 0

        if requestedGeneralWidth and requestedGeneralHeight and type(C_NamePlate.GetNamePlateSize) == "function" then
            requestedChecks = requestedChecks + 1
            local ok, width, height = pcall(C_NamePlate.GetNamePlateSize)
            if ok and type(width) == "number" and type(height) == "number" then
                if math.abs(width - requestedGeneralWidth) <= 0.5 and math.abs(height - requestedGeneralHeight) <= 0.5 then
                    verifiedChecks = verifiedChecks + 1
                end
            end
        end

        if requestedEnemyWidth and requestedEnemyHeight and type(C_NamePlate.GetNamePlateEnemySize) == "function" then
            requestedChecks = requestedChecks + 1
            local ok, width, height = pcall(C_NamePlate.GetNamePlateEnemySize)
            if ok and type(width) == "number" and type(height) == "number" then
                if math.abs(width - requestedEnemyWidth) <= 0.5 and math.abs(height - requestedEnemyHeight) <= 0.5 then
                    verifiedChecks = verifiedChecks + 1
                end
            end
        end

        if requestedFriendlyWidth and requestedFriendlyHeight and type(C_NamePlate.GetNamePlateFriendlySize) == "function" then
            requestedChecks = requestedChecks + 1
            local ok, width, height = pcall(C_NamePlate.GetNamePlateFriendlySize)
            if ok and type(width) == "number" and type(height) == "number" then
                if math.abs(width - requestedFriendlyWidth) <= 0.5 and math.abs(height - requestedFriendlyHeight) <= 0.5 then
                    verifiedChecks = verifiedChecks + 1
                end
            end
        end

        if requestedChecks > 0 and verifiedChecks == 0 then
            applied = false
            self:Debug("API size verification failed (no readback matched requested values)")
        end
    end

    return applied
end

local function captureFrameDimensions(frame)
    if not frame or isForbiddenObject(frame) or type(frame.GetWidth) ~= "function" or type(frame.GetHeight) ~= "function" then
        return nil, nil
    end

    local width = frame:GetWidth()
    local height = frame:GetHeight()
    if type(width) ~= "number" or type(height) ~= "number" or width <= 0 or height <= 0 then
        return nil, nil
    end
    return width, height
end

function CleanPlates:EnsureManualSizeBase(unitFrame)
    if not unitFrame then
        return nil
    end

    local base = manualSizeBaseByUnitFrame[unitFrame]
    if type(base) ~= "table" then
        base = {}
        manualSizeBaseByUnitFrame[unitFrame] = base
    end

    if not base.frameScale then
        local frameScale = 1
        if type(unitFrame.GetScale) == "function" then
            local ok, value = pcall(unitFrame.GetScale, unitFrame)
            if ok and type(value) == "number" and value > 0 then
                frameScale = value
            end
        end
        base.frameScale = frameScale
    end

    local healthBar = getHealthBar(unitFrame)
    if (not base.healthWidth or not base.healthHeight) and healthBar then
        local width, height = captureFrameDimensions(healthBar)
        if width and height then
            base.healthWidth = width
            base.healthHeight = height
        end
    end

    local castBar = getCastBar(unitFrame)
    if (not base.castWidth or not base.castHeight) and castBar then
        local width, height = captureFrameDimensions(castBar)
        if width and height then
            base.castWidth = width
            base.castHeight = height
        end
    end

    return base
end

function CleanPlates:GetEffectiveScaleFactors()
    local globalScale = self.effectiveGlobalScale or self.db.nameplateGlobalScale or defaults.nameplateGlobalScale
    local horizontalScale = self.effectiveHorizontalScale or self.db.nameplateHorizontalScale or defaults.nameplateHorizontalScale
    local verticalScale = self.effectiveVerticalScale or self.db.nameplateVerticalScale or defaults.nameplateVerticalScale
    return globalScale, horizontalScale, verticalScale
end

function CleanPlates:ApplyManualNameplateSize(unitFrame)
    if not self.db or not self.db.enabled or not unitFrame or isForbiddenObject(unitFrame) then
        return
    end
    if self.nameplateSizeMode ~= "manual" then
        return
    end

    local base = self:EnsureManualSizeBase(unitFrame)
    if not base then
        return
    end

    local globalScale, horizontalScale, verticalScale = self:GetEffectiveScaleFactors()
    local key = string.format("%.3f|%.3f|%.3f", globalScale, horizontalScale, verticalScale)
    local healthBar = getHealthBar(unitFrame)
    local castBar = getCastBar(unitFrame)
    local targetHealthWidth = base.healthWidth and clamp(base.healthWidth * horizontalScale, 20, 500) or nil
    local targetHealthHeight = base.healthHeight and clamp(base.healthHeight * verticalScale, 6, 200) or nil
    local targetCastWidth = base.castWidth and clamp(base.castWidth * horizontalScale, 20, 500) or nil
    local targetCastHeight = base.castHeight and clamp(base.castHeight * verticalScale, 4, 120) or nil

    if manualSizeKeyByUnitFrame[unitFrame] == key then
        local needsReapply = false
        if type(unitFrame.GetScale) == "function" then
            local ok, currentScale = pcall(unitFrame.GetScale, unitFrame)
            if not ok or type(currentScale) ~= "number" or math.abs(currentScale - globalScale) > 0.01 then
                needsReapply = true
            end
        end

        if not needsReapply and healthBar and targetHealthWidth and targetHealthHeight and not isForbiddenObject(healthBar) then
            local currentWidth, currentHeight = captureFrameDimensions(healthBar)
            if not currentWidth
                or not currentHeight
                or math.abs(currentWidth - targetHealthWidth) > 0.5
                or math.abs(currentHeight - targetHealthHeight) > 0.5 then
                needsReapply = true
            end
        end

        if not needsReapply and castBar and targetCastWidth and targetCastHeight and not isForbiddenObject(castBar) then
            local currentWidth, currentHeight = captureFrameDimensions(castBar)
            if not currentWidth
                or not currentHeight
                or math.abs(currentWidth - targetCastWidth) > 0.5
                or math.abs(currentHeight - targetCastHeight) > 0.5 then
                needsReapply = true
            end
        end

        if not needsReapply then
            return
        end
    end

    if type(unitFrame.SetScale) == "function" then
        pcall(unitFrame.SetScale, unitFrame, globalScale)
    end

    if healthBar and type(healthBar.SetSize) == "function" and targetHealthWidth and targetHealthHeight and not isForbiddenObject(healthBar) then
        pcall(healthBar.SetSize, healthBar, targetHealthWidth, targetHealthHeight)
    end

    if castBar and type(castBar.SetSize) == "function" and targetCastWidth and targetCastHeight and not isForbiddenObject(castBar) then
        pcall(castBar.SetSize, castBar, targetCastWidth, targetCastHeight)
    end

    manualSizeKeyByUnitFrame[unitFrame] = key
end

function CleanPlates:RestoreManualNameplateSize(unitFrame)
    if not unitFrame or isForbiddenObject(unitFrame) then
        return
    end

    local base = manualSizeBaseByUnitFrame[unitFrame]
    if type(unitFrame.SetScale) == "function" then
        pcall(unitFrame.SetScale, unitFrame, base and base.frameScale or 1)
    end

    if type(base) == "table" then
        local healthBar = getHealthBar(unitFrame)
        if healthBar and type(healthBar.SetSize) == "function" and base.healthWidth and base.healthHeight and not isForbiddenObject(healthBar) then
            pcall(healthBar.SetSize, healthBar, base.healthWidth, base.healthHeight)
        end

        local castBar = getCastBar(unitFrame)
        if castBar and type(castBar.SetSize) == "function" and base.castWidth and base.castHeight and not isForbiddenObject(castBar) then
            pcall(castBar.SetSize, castBar, base.castWidth, base.castHeight)
        end
    end

    manualSizeKeyByUnitFrame[unitFrame] = nil
end

function CleanPlates:ApplyNameplateSizeCompensation(globalScale, horizontalScale, verticalScale)
    local liveGlobal = readNumericCVar("nameplateGlobalScale")
    local liveHorizontal = readNumericCVar("nameplateHorizontalScale")
    local liveVertical = readNumericCVar("nameplateVerticalScale")

    local needsCompensation =
        not numbersClose(liveGlobal, globalScale, 0.02)
        or not numbersClose(liveHorizontal, horizontalScale, 0.02)
        or not numbersClose(liveVertical, verticalScale, 0.02)

    if not needsCompensation then
        if self.apiSizeCompensationActive then
            self:ApplyNameplateApiSizes(1, 1, 1)
            self.apiSizeCompensationActive = false
            self.lastApiSizeCompensationKey = nil
        end
        return
    end

    local denominatorGlobal = (type(liveGlobal) == "number" and math.abs(liveGlobal) > 0.001) and liveGlobal or 1
    local denominatorHorizontal = (type(liveHorizontal) == "number" and math.abs(liveHorizontal) > 0.001) and liveHorizontal or 1
    local denominatorVertical = (type(liveVertical) == "number" and math.abs(liveVertical) > 0.001) and liveVertical or 1

    local compensationGlobal = clamp(globalScale / denominatorGlobal, 0.45, 2.50)
    local compensationHorizontal = clamp(horizontalScale / denominatorHorizontal, 0.45, 2.50)
    local compensationVertical = clamp(verticalScale / denominatorVertical, 0.45, 2.50)

    self:ApplyNameplateApiSizes(compensationGlobal, compensationHorizontal, compensationVertical)
    self.apiSizeCompensationActive = true

    local key = table.concat({
        string.format("%.2f", compensationGlobal),
        string.format("%.2f", compensationHorizontal),
        string.format("%.2f", compensationVertical),
        tostring(liveGlobal or "nil"),
        tostring(liveHorizontal or "nil"),
        tostring(liveVertical or "nil"),
    }, "|")
    if self.db and self.db.debug and self.lastApiSizeCompensationKey ~= key then
        self.lastApiSizeCompensationKey = key
        self:Debug(
            string.format(
                "size compensation active (live %.2f/%.2f/%.2f -> target %.2f/%.2f/%.2f, compensation %.2f/%.2f/%.2f)",
                liveGlobal or -1,
                liveHorizontal or -1,
                liveVertical or -1,
                globalScale,
                horizontalScale,
                verticalScale,
                compensationGlobal,
                compensationHorizontal,
                compensationVertical
            )
        )
    end
end

function CleanPlates:EnsurePlateArtOverlay(unitFrame)
    if not unitFrame or isForbiddenObject(unitFrame) then
        return nil, nil
    end

    local healthBar = getHealthBar(unitFrame)
    if not healthBar or isForbiddenObject(healthBar) then
        return nil, nil
    end

    local overlay = plateArtOverlayByUnitFrame[unitFrame]
    if not overlay then
        overlay = CreateFrame("Frame", nil, healthBar)
        overlay:SetAllPoints(healthBar)
        overlay:SetIgnoreParentAlpha(true)
        overlay:SetIgnoreParentScale(false)

        overlay.bg = overlay:CreateTexture(nil, "BACKGROUND")
        overlay.bg:SetAllPoints(overlay)
        overlay.bg:SetTexture("Interface\\Buttons\\WHITE8X8")

        overlay.top = overlay:CreateTexture(nil, "BORDER")
        overlay.top:SetTexture("Interface\\Buttons\\WHITE8X8")
        overlay.bottom = overlay:CreateTexture(nil, "BORDER")
        overlay.bottom:SetTexture("Interface\\Buttons\\WHITE8X8")
        overlay.left = overlay:CreateTexture(nil, "BORDER")
        overlay.left:SetTexture("Interface\\Buttons\\WHITE8X8")
        overlay.right = overlay:CreateTexture(nil, "BORDER")
        overlay.right:SetTexture("Interface\\Buttons\\WHITE8X8")

        overlay.accent = overlay:CreateTexture(nil, "ARTWORK")
        overlay.accent:SetTexture("Interface\\Buttons\\WHITE8X8")

        plateArtOverlayByUnitFrame[unitFrame] = overlay
    else
        overlay:SetParent(healthBar)
    end

    return overlay, healthBar
end

function CleanPlates:ApplyPlateArtVisual(unitFrame)
    if not self.db or not self.db.enabled or not unitFrame then
        return
    end
    if isForbiddenObject(unitFrame) then
        return
    end

    local styleName = (self.db.plateArtStyle or defaults.plateArtStyle)
    local style = self:GetPlateArtStyleConfig()

    local overlay, healthBar = self:EnsurePlateArtOverlay(unitFrame)
    if not overlay or not healthBar then
        return
    end

    if HEALTH_TEXTURE_STYLING_SUPPORTED and healthBar.SetStatusBarTexture then
        local healthTexture = self:GetResolvedHealthTexture()
        if healthTextureByHealthBar[healthBar] ~= healthTexture then
            local ok = pcall(healthBar.SetStatusBarTexture, healthBar, healthTexture)
            if ok then
                healthTextureByHealthBar[healthBar] = healthTexture
            end
        end
    end

    local borderThickness = clamp(tonumber(style.borderThickness) or 1, 1, 4)
    local borderAlpha = clamp(tonumber(style.borderAlpha) or 0.45, 0, 1)
    local backdropAlpha = clamp(tonumber(style.backdropAlpha) or 0.16, 0, 1)
    local accentAlpha = clamp(tonumber(style.accentAlpha) or 0.16, 0, 1)

    local styleKey = table.concat({
        tostring(styleName),
        tostring(borderThickness),
        string.format("%.2f", borderAlpha),
        string.format("%.2f", backdropAlpha),
        string.format("%.2f", accentAlpha),
    }, "|")

    if plateArtOverlayKeyByUnitFrame[unitFrame] ~= styleKey then
        overlay:ClearAllPoints()
        overlay:SetPoint("TOPLEFT", healthBar, "TOPLEFT", -borderThickness, borderThickness)
        overlay:SetPoint("BOTTOMRIGHT", healthBar, "BOTTOMRIGHT", borderThickness, -borderThickness)

        overlay.bg:SetAllPoints(overlay)
        overlay.bg:SetColorTexture(0, 0, 0, backdropAlpha)

        overlay.top:ClearAllPoints()
        overlay.top:SetPoint("TOPLEFT", overlay, "TOPLEFT", 0, 0)
        overlay.top:SetPoint("TOPRIGHT", overlay, "TOPRIGHT", 0, 0)
        overlay.top:SetHeight(borderThickness)
        overlay.top:SetColorTexture(0, 0, 0, borderAlpha)

        overlay.bottom:ClearAllPoints()
        overlay.bottom:SetPoint("BOTTOMLEFT", overlay, "BOTTOMLEFT", 0, 0)
        overlay.bottom:SetPoint("BOTTOMRIGHT", overlay, "BOTTOMRIGHT", 0, 0)
        overlay.bottom:SetHeight(borderThickness)
        overlay.bottom:SetColorTexture(0, 0, 0, borderAlpha)

        overlay.left:ClearAllPoints()
        overlay.left:SetPoint("TOPLEFT", overlay, "TOPLEFT", 0, 0)
        overlay.left:SetPoint("BOTTOMLEFT", overlay, "BOTTOMLEFT", 0, 0)
        overlay.left:SetWidth(borderThickness)
        overlay.left:SetColorTexture(0, 0, 0, borderAlpha)

        overlay.right:ClearAllPoints()
        overlay.right:SetPoint("TOPRIGHT", overlay, "TOPRIGHT", 0, 0)
        overlay.right:SetPoint("BOTTOMRIGHT", overlay, "BOTTOMRIGHT", 0, 0)
        overlay.right:SetWidth(borderThickness)
        overlay.right:SetColorTexture(0, 0, 0, borderAlpha)

        if accentAlpha > 0.01 then
            overlay.accent:ClearAllPoints()
            overlay.accent:SetPoint("TOPLEFT", overlay, "TOPLEFT", borderThickness, -borderThickness)
            overlay.accent:SetPoint("TOPRIGHT", overlay, "TOPRIGHT", -borderThickness, -borderThickness)
            overlay.accent:SetHeight(1)
            overlay.accent:SetColorTexture(1, 1, 1, accentAlpha)
            overlay.accent:Show()
        else
            overlay.accent:Hide()
        end

        plateArtOverlayKeyByUnitFrame[unitFrame] = styleKey
    end

    overlay:Show()
end

function CleanPlates:ApplyAuraDisplayBitfields(showBuffsOnEnemy, showDebuffsOnEnemy, showBuffsOnFriendly, showDebuffsOnFriendly)
    if not C_CVar or type(C_CVar.SetCVarBitfield) ~= "function" then
        return false
    end

    local enumRoot = Enum
    if type(enumRoot) ~= "table" then
        return false
    end

    local appliedAny = false
    local function applyBitfieldPair(cvarName, enumTable, showBuffs, showDebuffs)
        if type(cvarName) ~= "string" or cvarName == "" or type(enumTable) ~= "table" then
            return
        end

        local buffIndex = enumTable.Buffs
        if type(buffIndex) == "number" then
            if setCVarBitfieldIfDifferent(cvarName, buffIndex, showBuffs) then
                appliedAny = true
            end
        end

        local debuffIndex = enumTable.Debuffs
        if type(debuffIndex) == "number" then
            if setCVarBitfieldIfDifferent(cvarName, debuffIndex, showDebuffs) then
                appliedAny = true
            end
        end
    end

    applyBitfieldPair(
        "nameplateEnemyPlayerAuraDisplay",
        enumRoot.NamePlateEnemyPlayerAuraDisplay,
        showBuffsOnEnemy,
        showDebuffsOnEnemy
    )
    applyBitfieldPair(
        "nameplateEnemyNpcAuraDisplay",
        enumRoot.NamePlateEnemyNpcAuraDisplay,
        showBuffsOnEnemy,
        showDebuffsOnEnemy
    )
    applyBitfieldPair(
        "nameplateFriendlyPlayerAuraDisplay",
        enumRoot.NamePlateFriendlyPlayerAuraDisplay,
        showBuffsOnFriendly,
        showDebuffsOnFriendly
    )

    local friendlyNpcAuraEnum = enumRoot.NamePlateFriendlyNpcAuraDisplay or enumRoot.NamePlateFriendlyNPCAuraDisplay
    if type(friendlyNpcAuraEnum) == "table" then
        applyBitfieldPair(
            "nameplateFriendlyNpcAuraDisplay",
            friendlyNpcAuraEnum,
            showBuffsOnFriendly,
            showDebuffsOnFriendly
        )
    end

    return appliedAny
end

function CleanPlates:ApplyNameplateCVars()
    if not self.db then
        return
    end

    local styleName = self.db.plateArtStyle or defaults.plateArtStyle
    local style = self:GetPlateArtStyleConfig()
    local globalScale = clamp((self.db.nameplateGlobalScale or defaults.nameplateGlobalScale) * getStyleScale(style, "globalScaleMult"), 0.6, 2.0)
    local horizontalScale = clamp((self.db.nameplateHorizontalScale or defaults.nameplateHorizontalScale) * getStyleScale(style, "horizontalScaleMult"), 0.6, 1.8)
    local verticalScale = clamp((self.db.nameplateVerticalScale or defaults.nameplateVerticalScale) * getStyleScale(style, "verticalScaleMult"), 0.6, 2.0)
    local heightMultiplier = clamp(self.db.nameplateHeightMultiplier or defaults.nameplateHeightMultiplier, 0.5, 2.5)
    local appliedVerticalScale = clamp(verticalScale * heightMultiplier, 0.6, 2.5)
    local xSpacing = clamp(self.db.nameplateXSpacing or defaults.nameplateXSpacing, 0.05, 2.0)
    local ySpacing = clamp(self.db.nameplateYSpacing or defaults.nameplateYSpacing, 0.05, 2.0)
    local selectedScale = clamp((self.db.nameplateSelectedScale or defaults.nameplateSelectedScale) * getStyleScale(style, "selectedScaleMult"), 1.0, 2.5)
    local maxDistance = math.floor((self.db.nameplateMaxDistance or defaults.nameplateMaxDistance) + 0.5)
    local showEnemyRoot = self.db.showEnemyPlates == true
    local showFriendlyRoot = self.db.showFriendlyPlates == true
    local showEnemyPets = showEnemyRoot and self.db.showEnemyPets == true
    local showEnemyGuardians = showEnemyRoot and self.db.showEnemyGuardians == true
    local showEnemyTotems = showEnemyRoot and self.db.showEnemyTotems == true
    local showEnemyMinions = showEnemyRoot and self.db.showEnemyMinions == true
    local showFriendlyPets = showFriendlyRoot and self.db.showFriendlyPets == true
    local showFriendlyGuardians = showFriendlyRoot and self.db.showFriendlyGuardians == true
    local showFriendlyTotems = showFriendlyRoot and self.db.showFriendlyTotems == true
    local showFriendlyMinions = showFriendlyRoot and self.db.showFriendlyMinions == true
    local showDebuffsOnEnemy = showEnemyRoot and self.db.showDebuffsOnEnemy == true
    local showBuffsOnEnemy = showEnemyRoot and self.db.showBuffsOnEnemy == true
    local showDebuffsOnFriendly = showFriendlyRoot and self.db.showDebuffsOnFriendly == true
    local showBuffsOnFriendly = showFriendlyRoot and self.db.showBuffsOnFriendly == true

    local cvarSignature = table.concat({
        styleName,
        boolToCVar(showEnemyRoot),
        boolToCVar(showFriendlyRoot),
        boolToCVar(showEnemyPets),
        boolToCVar(showEnemyGuardians),
        boolToCVar(showEnemyTotems),
        boolToCVar(showEnemyMinions),
        boolToCVar(showFriendlyPets),
        boolToCVar(showFriendlyGuardians),
        boolToCVar(showFriendlyTotems),
        boolToCVar(showFriendlyMinions),
        boolToCVar(showDebuffsOnEnemy),
        boolToCVar(showBuffsOnEnemy),
        boolToCVar(showDebuffsOnFriendly),
        boolToCVar(showBuffsOnFriendly),
        string.format("%.3f", globalScale),
        string.format("%.3f", horizontalScale),
        string.format("%.3f", appliedVerticalScale),
        string.format("%.3f", heightMultiplier),
        string.format("%.3f", xSpacing),
        string.format("%.3f", ySpacing),
        string.format("%.3f", selectedScale),
        tostring(maxDistance),
    }, "|")

    if self.lastCVarSignature == cvarSignature and not self.forceCVarReapply then
        return
    end
    if self.db and self.db.debug then
        self:Debug(string.format(
            "apply size request g=%.2f w=%.2f h=%.2f hMult=%.2f x=%.2f y=%.2f target=%.2f dist=%d",
            globalScale, horizontalScale, appliedVerticalScale, heightMultiplier, xSpacing, ySpacing, selectedScale, maxDistance
        ))
    end

    -- Root toggles: set both legacy and split CVars for modern clients.
    setAnyCVarIfDifferent({ "nameplateShowEnemies" }, boolToCVar(showEnemyRoot))
    setAnyCVarIfDifferent({ "nameplateShowEnemyPlayers" }, boolToCVar(showEnemyRoot))
    setAnyCVarIfDifferent({ "nameplateShowEnemyNPCs", "nameplateShowEnemyNpcs" }, boolToCVar(showEnemyRoot))
    setAnyCVarIfDifferent({ "nameplateShowFriends" }, boolToCVar(showFriendlyRoot))
    setAnyCVarIfDifferent({ "nameplateShowFriendlyPlayers" }, boolToCVar(showFriendlyRoot))
    setAnyCVarIfDifferent({ "nameplateShowFriendlyNPCs", "nameplateShowFriendlyNpcs" }, boolToCVar(showFriendlyRoot))

    setCVarIfDifferent("nameplateShowEnemyPets", boolToCVar(showEnemyPets))
    setCVarIfDifferent("nameplateShowEnemyGuardians", boolToCVar(showEnemyGuardians))
    setCVarIfDifferent("nameplateShowEnemyTotems", boolToCVar(showEnemyTotems))
    setCVarIfDifferent("nameplateShowEnemyMinions", boolToCVar(showEnemyMinions))
    setCVarIfDifferent("nameplateShowEnemyMinus", boolToCVar(showEnemyMinions))
    setAnyCVarIfDifferent({ "nameplateShowFriendlyPlayerPets", "nameplateShowFriendlyPets" }, boolToCVar(showFriendlyPets))
    setAnyCVarIfDifferent({ "nameplateShowFriendlyPlayerGuardians", "nameplateShowFriendlyGuardians" }, boolToCVar(showFriendlyGuardians))
    setAnyCVarIfDifferent({ "nameplateShowFriendlyPlayerTotems", "nameplateShowFriendlyTotems" }, boolToCVar(showFriendlyTotems))
    setAnyCVarIfDifferent({ "nameplateShowFriendlyPlayerMinions", "nameplateShowFriendlyMinions" }, boolToCVar(showFriendlyMinions))

    -- Legacy aura CVars (older clients) + Midnight bitfield aura CVars.
    setAnyCVarIfDifferent({ "nameplateShowDebuffsOnEnemy", "nameplateShowDebuffsOnEnemies" }, boolToCVar(showDebuffsOnEnemy))
    setAnyCVarIfDifferent({ "nameplateShowBuffsOnEnemy", "nameplateShowBuffsOnEnemies" }, boolToCVar(showBuffsOnEnemy))
    setAnyCVarIfDifferent({ "nameplateShowDebuffsOnFriendly", "nameplateShowDebuffsOnFriendlies" }, boolToCVar(showDebuffsOnFriendly))
    setAnyCVarIfDifferent({ "nameplateShowBuffsOnFriendly", "nameplateShowBuffsOnFriendlies" }, boolToCVar(showBuffsOnFriendly))
    self:ApplyAuraDisplayBitfields(showBuffsOnEnemy, showDebuffsOnEnemy, showBuffsOnFriendly, showDebuffsOnFriendly)

    setNumericCVarIfDifferent("nameplateGlobalScale", globalScale)
    setNumericCVarIfDifferent("NamePlateGlobalScale", globalScale)
    setNumericCVarIfDifferent("nameplateHorizontalScale", horizontalScale)
    setNumericCVarIfDifferent("NamePlateHorizontalScale", horizontalScale)
    setNumericCVarIfDifferent("nameplateVerticalScale", appliedVerticalScale)
    setNumericCVarIfDifferent("NamePlateVerticalScale", appliedVerticalScale)
    setNumericCVarIfDifferent("nameplateOverlapH", xSpacing)
    setNumericCVarIfDifferent("nameplateOverlapV", ySpacing)
    setNumericCVarIfDifferent("nameplateSelectedScale", selectedScale)
    setNumericCVarIfDifferent("nameplateMaxDistance", maxDistance)
    -- Keep distance-based auto-scaling from overriding manual size sliders.
    setNumericCVarIfDifferent("nameplateMinScale", 1.0)
    setNumericCVarIfDifferent("nameplateMaxScale", 1.0)
    -- Clients differ on selected-scale CVar names; apply both when available.
    setNumericCVarIfDifferent("nameplateLargerScale", selectedScale)
    setNumericCVarIfDifferent("nameplatePlayerLargerScale", selectedScale)
    self.effectiveGlobalScale = globalScale
    self.effectiveHorizontalScale = horizontalScale
    self.effectiveVerticalScale = appliedVerticalScale

    local apiApplied = self:ApplyNameplateApiSizes(globalScale, horizontalScale, appliedVerticalScale)
    if apiApplied then
        self.nameplateSizeMode = "api"
        self.pendingSizeApplyAfterCombat = nil
    else
        -- Midnight secure values: per-frame manual resizing taints CompactUnitFrame health internals.
        -- Keep CVar-driven sizing when API writes are unavailable.
        self.nameplateSizeMode = "cvar"
        self.apiSizeCompensationActive = false
        self.lastApiSizeCompensationKey = nil
    end

    self.lastCVarSignature = cvarSignature
    self.forceCVarReapply = nil
end

function CleanPlates:SyncRootPlateTogglesFromCVars(changedCVarName, changedValue)
    if not self.db then
        return false
    end

    local cvarName = tostring(changedCVarName or ""):lower()
    if cvarName == "" then
        return false
    end

    local isFriendlyRootCVar =
        cvarName == "nameplateshowfriends"
        or cvarName == "nameplateshowfriendlyplayers"
        or cvarName == "nameplateshowfriendlynpcs"
    local isEnemyRootCVar =
        cvarName == "nameplateshowenemies"
        or cvarName == "nameplateshowenemyplayers"
        or cvarName == "nameplateshowenemynpcs"

    if not isFriendlyRootCVar and not isEnemyRootCVar then
        return false
    end

    local changed = false

    if isFriendlyRootCVar then
        local newFriendlyRoot
        if cvarName == "nameplateshowfriends" or cvarName == "nameplateshowfriendlyplayers" or cvarName == "nameplateshowfriendlynpcs" then
            newFriendlyRoot = cvarToBool(changedValue, self.db.showFriendlyPlates)
        else
            local _, friendlyRootCVar = getFirstAvailableCVar({
                "nameplateShowFriendlyPlayers",
                "nameplateShowFriends",
                "nameplateShowFriendlyNPCs",
                "nameplateShowFriendlyNpcs",
            })
            newFriendlyRoot = cvarToBool(friendlyRootCVar, self.db.showFriendlyPlates)
        end
        if self.db.showFriendlyPlates ~= newFriendlyRoot then
            self.db.showFriendlyPlates = newFriendlyRoot
            changed = true
        end
    end

    if isEnemyRootCVar then
        local newEnemyRoot
        if cvarName == "nameplateshowenemies" or cvarName == "nameplateshowenemyplayers" or cvarName == "nameplateshowenemynpcs" then
            newEnemyRoot = cvarToBool(changedValue, self.db.showEnemyPlates)
        else
            local _, enemyRootCVar = getFirstAvailableCVar({
                "nameplateShowEnemyPlayers",
                "nameplateShowEnemies",
                "nameplateShowEnemyNPCs",
                "nameplateShowEnemyNpcs",
            })
            newEnemyRoot = cvarToBool(enemyRootCVar, self.db.showEnemyPlates)
        end
        if self.db.showEnemyPlates ~= newEnemyRoot then
            self.db.showEnemyPlates = newEnemyRoot
            changed = true
        end
    end

    if changed then
        self:NormalizeSettings()
        self.lastCVarSignature = nil
        if self.RefreshOptions then
            self:RefreshOptions()
        end
    end

    return changed
end

function CleanPlates:BuildExportString()
    if not self.db then
        return nil
    end

    local fields = {
        "CP1",
        tostring(self.db.preset or "vivid"),
        self.db.enabled and "1" or "0",
        self.db.classColorPlayers and "1" or "0",
        self.db.styleCombatText and "1" or "0",
        self.db.enableCastStateColors and "1" or "0",
        self.db.showHealthPercent and "1" or "0",
        self.db.healthPercentEnemiesOnly and "1" or "0",
        self.db.targetHighlight and "1" or "0",
        self.db.debug and "1" or "0",
        tostring(self.db.nameFontSize or defaults.nameFontSize),
        tostring(self.db.combatTextFontSize or defaults.combatTextFontSize),
        tostring(self.db.targetFontBoost or defaults.targetFontBoost),
        colorToHex(self.db.enemyColor or defaults.enemyColor),
        colorToHex(self.db.friendlyColor or defaults.friendlyColor),
        colorToHex(self.db.neutralColor or defaults.neutralColor),
        colorToHex(self.db.targetColor or defaults.targetColor),
        colorToHex(self.db.castInterruptibleColor or defaults.castInterruptibleColor),
        colorToHex(self.db.castUninterruptibleColor or defaults.castUninterruptibleColor),
        colorToHex(self.db.castFriendlyColor or defaults.castFriendlyColor),
        colorToHex(self.db.healthTextColor or defaults.healthTextColor),
        self.db.showQuestMarker and "1" or "0",
        self.db.showEnemyPlates and "1" or "0",
        self.db.showFriendlyPlates and "1" or "0",
        self.db.showEnemyPets and "1" or "0",
        self.db.showEnemyGuardians and "1" or "0",
        self.db.showEnemyTotems and "1" or "0",
        self.db.showEnemyMinions and "1" or "0",
        self.db.showFriendlyPets and "1" or "0",
        self.db.showFriendlyGuardians and "1" or "0",
        self.db.showFriendlyTotems and "1" or "0",
        self.db.showFriendlyMinions and "1" or "0",
        self.db.showDebuffsOnEnemy and "1" or "0",
        self.db.showBuffsOnEnemy and "1" or "0",
        self.db.showDebuffsOnFriendly and "1" or "0",
        self.db.showBuffsOnFriendly and "1" or "0",
        tostring(self.db.maxBuffs or defaults.maxBuffs),
        tostring(self.db.maxDebuffs or defaults.maxDebuffs),
        string.format("%.2f", self.db.nameplateGlobalScale or defaults.nameplateGlobalScale),
        string.format("%.2f", self.db.nameplateHorizontalScale or defaults.nameplateHorizontalScale),
        string.format("%.2f", self.db.nameplateVerticalScale or defaults.nameplateVerticalScale),
        string.format("%.2f", self.db.nameplateHeightMultiplier or defaults.nameplateHeightMultiplier),
        string.format("%.2f", self.db.nameplateXSpacing or defaults.nameplateXSpacing),
        string.format("%.2f", self.db.nameplateYSpacing or defaults.nameplateYSpacing),
        string.format("%.2f", self.db.nameplateSelectedScale or defaults.nameplateSelectedScale),
        tostring(self.db.nameplateMaxDistance or defaults.nameplateMaxDistance),
        string.format("%.2f", self.db.castBarScale or defaults.castBarScale),
        tostring(self.db.plateArtStyle or defaults.plateArtStyle),
    }

    return table.concat(fields, "|")
end

function CleanPlates:ApplyImportString(importString)
    if type(importString) ~= "string" or importString == "" then
        return false, "Import string is empty."
    end

    local parts = {}
    for part in string.gmatch(importString, "([^|]+)") do
        parts[#parts + 1] = part
    end

    if #parts < 21 or string.upper(parts[1]) ~= "CP1" then
        return false, "Invalid profile format."
    end

    local preset = parts[2]
    if preset ~= "vivid" and preset ~= "neutral" and preset ~= "soft" then
        preset = "vivid"
    end

    local enemy = hexToColor(parts[14])
    local friendly = hexToColor(parts[15])
    local neutral = hexToColor(parts[16])
    local target = hexToColor(parts[17])
    local castInt = hexToColor(parts[18])
    local castLock = hexToColor(parts[19])
    local castFriendly = hexToColor(parts[20])
    local healthText = hexToColor(parts[21])
    if not enemy or not friendly or not neutral or not target or not castInt or not castLock or not castFriendly or not healthText then
        return false, "Invalid color data in profile."
    end

    local function parseBoolPart(index, fallback)
        local raw = parts[index]
        if raw == nil then
            return fallback
        end
        return raw == "1"
    end

    local function parseNumberPart(index, fallback)
        local value = tonumber(parts[index] or "")
        if value == nil then
            return fallback
        end
        return value
    end

    self.db.preset = preset
    self.db.enabled = parseBoolPart(3, defaults.enabled)
    self.db.classColorPlayers = parseBoolPart(4, defaults.classColorPlayers)
    self.db.styleCombatText = parseBoolPart(5, defaults.styleCombatText)
    self.db.enableCastStateColors = parseBoolPart(6, defaults.enableCastStateColors)
    self.db.showHealthPercent = parseBoolPart(7, defaults.showHealthPercent)
    self.db.healthPercentEnemiesOnly = parseBoolPart(8, defaults.healthPercentEnemiesOnly)
    self.db.targetHighlight = parseBoolPart(9, defaults.targetHighlight)
    self.db.debug = parseBoolPart(10, defaults.debug)
    self.db.nameFontSize = parseNumberPart(11, defaults.nameFontSize)
    self.db.combatTextFontSize = parseNumberPart(12, defaults.combatTextFontSize)
    self.db.targetFontBoost = parseNumberPart(13, defaults.targetFontBoost)
    self.db.enemyColor = enemy
    self.db.friendlyColor = friendly
    self.db.neutralColor = neutral
    self.db.targetColor = target
    self.db.castInterruptibleColor = castInt
    self.db.castUninterruptibleColor = castLock
    self.db.castFriendlyColor = castFriendly
    self.db.healthTextColor = healthText
    self.db.showQuestMarker = parseBoolPart(22, defaults.showQuestMarker)
    self.db.showEnemyPlates = parseBoolPart(23, defaults.showEnemyPlates)
    self.db.showFriendlyPlates = parseBoolPart(24, defaults.showFriendlyPlates)
    self.db.showEnemyPets = parseBoolPart(25, defaults.showEnemyPets)
    self.db.showEnemyGuardians = parseBoolPart(26, defaults.showEnemyGuardians)
    self.db.showEnemyTotems = parseBoolPart(27, defaults.showEnemyTotems)
    self.db.showEnemyMinions = parseBoolPart(28, defaults.showEnemyMinions)
    self.db.showFriendlyPets = parseBoolPart(29, defaults.showFriendlyPets)
    self.db.showFriendlyGuardians = parseBoolPart(30, defaults.showFriendlyGuardians)
    self.db.showFriendlyTotems = parseBoolPart(31, defaults.showFriendlyTotems)
    self.db.showFriendlyMinions = parseBoolPart(32, defaults.showFriendlyMinions)
    self.db.showDebuffsOnEnemy = parseBoolPart(33, defaults.showDebuffsOnEnemy)
    self.db.showBuffsOnEnemy = parseBoolPart(34, defaults.showBuffsOnEnemy)
    self.db.showDebuffsOnFriendly = parseBoolPart(35, defaults.showDebuffsOnFriendly)
    self.db.showBuffsOnFriendly = parseBoolPart(36, defaults.showBuffsOnFriendly)
    self.db.maxBuffs = parseNumberPart(37, defaults.maxBuffs)
    self.db.maxDebuffs = parseNumberPart(38, defaults.maxDebuffs)
    self.db.nameplateGlobalScale = parseNumberPart(39, defaults.nameplateGlobalScale)
    self.db.nameplateHorizontalScale = parseNumberPart(40, defaults.nameplateHorizontalScale)
    self.db.nameplateVerticalScale = parseNumberPart(41, defaults.nameplateVerticalScale)
    if parts[48] ~= nil then
        self.db.nameplateHeightMultiplier = parseNumberPart(42, defaults.nameplateHeightMultiplier)
        self.db.nameplateXSpacing = parseNumberPart(43, defaults.nameplateXSpacing)
        self.db.nameplateYSpacing = parseNumberPart(44, defaults.nameplateYSpacing)
        self.db.nameplateSelectedScale = parseNumberPart(45, defaults.nameplateSelectedScale)
        self.db.nameplateMaxDistance = parseNumberPart(46, defaults.nameplateMaxDistance)
        self.db.castBarScale = parseNumberPart(47, defaults.castBarScale)
        self.db.plateArtStyle = tostring(parts[48] or defaults.plateArtStyle)
    else
        self.db.nameplateHeightMultiplier = defaults.nameplateHeightMultiplier
        self.db.nameplateXSpacing = defaults.nameplateXSpacing
        self.db.nameplateYSpacing = defaults.nameplateYSpacing
        self.db.nameplateSelectedScale = parseNumberPart(42, defaults.nameplateSelectedScale)
        self.db.nameplateMaxDistance = parseNumberPart(43, defaults.nameplateMaxDistance)
        self.db.castBarScale = parseNumberPart(44, defaults.castBarScale)
        self.db.plateArtStyle = tostring(parts[45] or defaults.plateArtStyle)
    end

    self:NormalizeSettings()
    if self.aceDB then
        self.db = self.aceDB.profile
    else
        self:EnsureProfileStore()
        local activeProfile = self.db.activeProfileName or PROFILE_DEFAULT_NAME
        self.db.profiles[activeProfile] = self:CaptureCurrentSettings()
    end
    self.forceCVarReapply = true
    if self.RefreshOptions then
        self:RefreshOptions()
    end
    self:Refresh()
    return true
end

function CleanPlates:EnsureHealthText(unitFrame)
    if not unitFrame then
        return nil
    end
    if isForbiddenObject(unitFrame) then
        return nil
    end

    local existing = healthTextByUnitFrame[unitFrame]
    if existing then
        return existing
    end

    local healthBar = getHealthBar(unitFrame)
    if not healthBar or isForbiddenObject(healthBar) then
        return nil
    end

    local text = healthBar:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    text:SetPoint("CENTER", healthBar, "CENTER", 0, 0)
    text:SetJustifyH("CENTER")
    text:SetText("")
    text:Hide()
    healthTextByUnitFrame[unitFrame] = text
    return text
end

function CleanPlates:EnsureQuestMarker(unitFrame)
    if not unitFrame then
        return nil
    end
    if isForbiddenObject(unitFrame) then
        return nil
    end

    local existing = questMarkerByUnitFrame[unitFrame]
    if existing then
        return existing
    end

    local marker = unitFrame:CreateTexture(nil, "OVERLAY")
    marker:SetTexture(QUEST_MARKER_VISUALS.quest.texture)
    marker:SetVertexColor(1, 1, 1, 1)
    marker:SetSize(16, 16)
    marker:Hide()

    questMarkerByUnitFrame[unitFrame] = marker
    return marker
end

function CleanPlates:IsQuestRelevantUnit(unit)
    if not unit or not safeUnitExists(unit) then
        return false
    end

    local cache = self.questRelevanceCache
    if type(cache) ~= "table" then
        cache = {}
        self.questRelevanceCache = cache
    end

    local now = getNow()
    local cacheKey
    if type(UnitGUID) == "function" then
        local ok, unitGUID = pcall(UnitGUID, unit)
        if ok and type(unitGUID) == "string" and unitGUID ~= "" and not isSecretValue(unitGUID) then
            if type(canaccessvalue) == "function" then
                local accessibleOk, accessible = pcall(canaccessvalue, unitGUID)
                if accessibleOk and accessible then
                    cacheKey = unitGUID
                end
            else
                cacheKey = unitGUID
            end
        end
    end
    if not cacheKey and type(unit) == "string" and unit ~= "" and not isSecretValue(unit) then
        if type(canaccessvalue) == "function" then
            local accessibleOk, accessible = pcall(canaccessvalue, unit)
            if accessibleOk and accessible then
                cacheKey = unit
            end
        else
            cacheKey = unit
        end
    end

    if cacheKey then
        local entry = cache[cacheKey]
        if type(entry) == "table" and type(entry.value) == "boolean" and type(entry.time) == "number" then
            if (now - entry.time) <= QUEST_CACHE_TTL then
                return entry.value, entry.kind
            end
        end
    end

    local result = false
    local isQuestBoss = false

    if type(UnitIsQuestBoss) == "function" then
        local ok, isBoss = pcall(UnitIsQuestBoss, unit)
        if ok and toSafeBoolean(isBoss) then
            result = true
            isQuestBoss = true
        end
    end

    if not result and C_QuestLog and type(C_QuestLog.UnitIsRelatedToActiveQuest) == "function" then
        local ok, isRelated = pcall(C_QuestLog.UnitIsRelatedToActiveQuest, unit)
        if ok and toSafeBoolean(isRelated) then
            result = true
        end
    end

    local kind
    if result then
        local attackable = safeUnitCanAttack(unit)
        if isQuestBoss then
            kind = "kill"
        elseif attackable then
            if safeUnitIsDead(unit) then
                kind = "loot"
            else
                kind = "kill"
            end
        else
            kind = "turnin"
        end
    end

    if cacheKey then
        cache[cacheKey] = {
            value = result,
            kind = kind,
            time = now,
        }
    end

    return result, kind
end

function CleanPlates:ClearQuestRelevanceCache()
    self.questRelevanceCache = {}
end

function CleanPlates:ApplyQuestMarker(unitFrame)
    if not self.db or not self.db.enabled or not unitFrame then
        return
    end
    if isForbiddenObject(unitFrame) then
        return
    end

    local marker = questMarkerByUnitFrame[unitFrame]
    if marker and isForbiddenObject(marker) then
        return
    end
    if not self.db.showQuestMarker then
        if marker then
            marker:Hide()
        end
        return
    end

    local unit = getUnit(unitFrame)
    local shouldShow, markerKind = self:IsQuestRelevantUnit(unit)
    if not shouldShow then
        if marker then
            marker:Hide()
        end
        return
    end

    marker = self:EnsureQuestMarker(unitFrame)
    if not marker then
        return
    end

    local nameText = unitFrame.name or (unitFrame.nameFrame and unitFrame.nameFrame.name)
    if questMarkerAnchorByMarker[marker] ~= nameText then
        marker:ClearAllPoints()
        if nameText then
            marker:SetPoint("RIGHT", nameText, "LEFT", -4, 0)
        else
            marker:SetPoint("CENTER", unitFrame, "TOPLEFT", 4, -14)
        end
        questMarkerAnchorByMarker[marker] = nameText
    end

    local resolvedKind = markerKind or "quest"
    local visual = QUEST_MARKER_VISUALS[resolvedKind] or QUEST_MARKER_VISUALS.quest
    local markerSize = math.max(14, (self.db.nameFontSize or defaults.nameFontSize) + 3)
    local markerVisualKey = table.concat({
        resolvedKind,
        tostring(markerSize),
        visual.texture or "",
        tostring(visual.r or 1),
        tostring(visual.g or 1),
        tostring(visual.b or 1),
    }, "|")
    if questMarkerVisualKeyByMarker[marker] ~= markerVisualKey then
        marker:SetTexture(visual.texture or QUEST_MARKER_VISUALS.quest.texture)
        marker:SetVertexColor(visual.r or 1, visual.g or 1, visual.b or 1, 1)
        marker:SetSize(markerSize, markerSize)
        questMarkerVisualKeyByMarker[marker] = markerVisualKey
    end
    marker:Show()
end

local function getCastState(unit)
    if not unit then
        return nil
    end

    local castOk, castingName = pcall(UnitCastingInfo, unit)
    if castOk and toSafeBoolean(castingName) then
        return "casting"
    end

    local channelOk, channelName = pcall(UnitChannelInfo, unit)
    if channelOk and toSafeBoolean(channelName) then
        return "channeling"
    end

    return nil
end

function CleanPlates:ApplyCastColor(unitFrame)
    if not self.db or not self.db.enabled or not self.db.enableCastStateColors or not unitFrame then
        return
    end
    if isForbiddenObject(unitFrame) then
        return
    end

    local castBar = getCastBar(unitFrame)
    if not castBar or not castBar.SetStatusBarColor or isForbiddenObject(castBar) then
        return
    end

    local unit = getUnit(unitFrame)
    if not unit or not safeUnitExists(unit) then
        castColorKeyByUnitFrame[unitFrame] = nil
        return
    end

    local r
    local g
    local b
    local isEnemy = safeUnitIsEnemy(unitFrame, unit)
    if not isEnemy then
        r = self.db.castFriendlyColor.r
        g = self.db.castFriendlyColor.g
        b = self.db.castFriendlyColor.b
    else
        local castState = getCastState(unit)
        if not castState then
            castColorKeyByUnitFrame[unitFrame] = nil
            return
        end
        r = self.db.castInterruptibleColor.r
        g = self.db.castInterruptibleColor.g
        b = self.db.castInterruptibleColor.b
    end

    local colorKey = string.format("%d-%d-%d", to255(r), to255(g), to255(b))
    if castColorKeyByUnitFrame[unitFrame] ~= colorKey then
        castBar:SetStatusBarColor(r, g, b)
        castColorKeyByUnitFrame[unitFrame] = colorKey
    end
end

function CleanPlates:ApplyHealthText(unitFrame)
    if not self.db or not self.db.enabled or not unitFrame then
        return
    end
    if isForbiddenObject(unitFrame) then
        return
    end

    local text = healthTextByUnitFrame[unitFrame]
    if text and isForbiddenObject(text) then
        return
    end
    if self.healthPercentBlocked or not HEALTH_PERCENT_SUPPORTED or not self.db.showHealthPercent then
        if text then
            text:Hide()
        end
        return
    end

    text = self:EnsureHealthText(unitFrame)
    if not text or isForbiddenObject(text) then
        return
    end

    local unit = getUnit(unitFrame)
    if not unit or not safeUnitExists(unit) then
        text:Hide()
        return
    end

    local isEnemy = safeUnitIsEnemy(unitFrame, unit)
    if self.db.healthPercentEnemiesOnly and not isEnemy then
        text:Hide()
        return
    end

    text:Hide()
end

function CleanPlates:ApplyName(unitFrame)
    if not self.db or not self.db.enabled or not unitFrame then
        return
    end
    if not NAME_STYLING_SUPPORTED then
        return
    end
    if isForbiddenObject(unitFrame) then
        return
    end
    if type(InCombatLockdown) == "function" and InCombatLockdown() then
        return
    end

    local unit = getUnit(unitFrame)
    local isTarget = self.db.targetHighlight and unit and safeUnitIsUnit(unit, "target")
    local nameText = unitFrame.name or (unitFrame.nameFrame and unitFrame.nameFrame.name)
    if nameText and nameText.SetFont and not isForbiddenObject(nameText) then
        local fontSize = self.db.nameFontSize + (isTarget and self.db.targetFontBoost or 0)
        local nameFontFlags = getReadableNameFontFlags(self.db.fontFlags)
        local nameR = 1
        local nameG = 1
        local nameB = 1

        if unit and safeUnitExists(unit) then
            if isTarget then
                local tr, tg, tb = adjustBrightTextColor(self.db.targetColor.r, self.db.targetColor.g, self.db.targetColor.b)
                nameR, nameG, nameB = tr, tg, tb
            elseif self.db.classColorPlayers and safeUnitIsPlayer(unit) then
                local _, classTag = UnitClass(unit)
                local classColor = classTag and RAID_CLASS_COLORS[classTag]
                if classColor then
                    nameR, nameG, nameB = classColor.r, classColor.g, classColor.b
                end
            elseif safeUnitIsEnemy(unitFrame, unit) then
                nameR, nameG, nameB = self.db.enemyColor.r, self.db.enemyColor.g, self.db.enemyColor.b
            else
                local reaction = safeUnitReaction("player", unit)
                if reaction == 4 then
                    nameR, nameG, nameB = self.db.neutralColor.r, self.db.neutralColor.g, self.db.neutralColor.b
                else
                    nameR, nameG, nameB = self.db.friendlyColor.r, self.db.friendlyColor.g, self.db.friendlyColor.b
                end
            end
        end

        local colorRi = to255(nameR)
        local colorGi = to255(nameG)
        local colorBi = to255(nameB)
        local fontKey = table.concat({
            self.db.nameFont,
            tostring(fontSize),
            nameFontFlags,
        }, "|")

        local cache = nameCacheByUnitFrame[unitFrame]
        if not cache or cache.fontKey ~= fontKey then
            nameText:SetFont(self.db.nameFont, fontSize, nameFontFlags)
            nameText:SetShadowOffset(1, -1)
            nameText:SetShadowColor(0, 0, 0, 1)
        end

        if not cache or cache.ri ~= colorRi or cache.gi ~= colorGi or cache.bi ~= colorBi then
            nameText:SetTextColor(nameR, nameG, nameB)
        end

        if nameText.SetAlpha then
            nameText:SetAlpha(1)
        end
        if nameText.Show then
            nameText:Show()
        end

        nameCacheByUnitFrame[unitFrame] = {
            fontKey = fontKey,
            ri = colorRi,
            gi = colorGi,
            bi = colorBi,
        }
    end
end

function CleanPlates:ApplyAuraSettings(unitFrame)
    if not self.db or not self.db.enabled or not unitFrame then
        return
    end
    if isForbiddenObject(unitFrame) then
        return
    end
    if not AURA_FRAME_MUTATION_SUPPORTED then
        return
    end

    local unit = getUnit(unitFrame)
    if not unit or not safeUnitExists(unit) then
        return
    end

    local isEnemy = safeUnitIsEnemy(unitFrame, unit)
    local maxBuffs = self.db.maxBuffs or defaults.maxBuffs
    local maxDebuffs = self.db.maxDebuffs or defaults.maxDebuffs

    if isEnemy then
        if not self.db.showBuffsOnEnemy then
            maxBuffs = 0
        end
        if not self.db.showDebuffsOnEnemy then
            maxDebuffs = 0
        end
    else
        if not self.db.showBuffsOnFriendly then
            maxBuffs = 0
        end
        if not self.db.showDebuffsOnFriendly then
            maxDebuffs = 0
        end
    end

    auraCacheByUnitFrame[unitFrame] = {
        maxBuffs = maxBuffs,
        maxDebuffs = maxDebuffs,
    }

    -- Midnight taint safety: avoid direct CompactUnitFrame_* calls here.
    local function applyVisibility(buttons, maxVisible)
        if type(buttons) ~= "table" then
            return
        end

        for i = 1, #buttons do
            local button = buttons[i]
            if button and not isForbiddenObject(button) then
                if i <= maxVisible then
                    if button.Show then
                        button:Show()
                    end
                else
                    if button.Hide then
                        button:Hide()
                    end
                end
            end
        end
    end

    applyVisibility(unitFrame.buffs, maxBuffs)
    applyVisibility(unitFrame.debuffs, maxDebuffs)
    if unitFrame.AurasFrame and not isForbiddenObject(unitFrame.AurasFrame) then
        applyVisibility(unitFrame.AurasFrame.buffs, maxBuffs)
        applyVisibility(unitFrame.AurasFrame.debuffs, maxDebuffs)
    end
end

function CleanPlates:ApplyCastBarLayout(unitFrame)
    if not self.db or not self.db.enabled or not unitFrame then
        return
    end
    if isForbiddenObject(unitFrame) then
        return
    end

    local castBar = getCastBar(unitFrame)
    if castBar and castBar.SetScale and not isForbiddenObject(castBar) then
        local style = self:GetPlateArtStyleConfig()
        local targetScale = clamp(
            (self.db.castBarScale or defaults.castBarScale) * getStyleScale(style, "castBarScaleMult"),
            0.6,
            2.0
        )
        local roundedScale = math.floor((targetScale * 1000) + 0.5) / 1000
        if castScaleByUnitFrame[unitFrame] ~= roundedScale then
            castBar:SetScale(roundedScale)
            castScaleByUnitFrame[unitFrame] = roundedScale
        end
    end
end

function CleanPlates:ApplyTextures(unitFrame)
    if not self.db or not self.db.enabled or not unitFrame then
        return
    end
    if isForbiddenObject(unitFrame) then
        return
    end

    self:ApplyPlateArtVisual(unitFrame)

    local castBar = getCastBar(unitFrame)
    if castBar and castBar.SetStatusBarTexture and not isForbiddenObject(castBar) then
        local castTexture = self:GetResolvedCastTexture()
        if castTextureByCastBar[castBar] ~= castTexture then
            castBar:SetStatusBarTexture(castTexture)
            castTextureByCastBar[castBar] = castTexture
        end
    end

    if castBar and castBar.Text and castBar.Text.SetFont and not isForbiddenObject(castBar.Text) then
        local castFontSize = math.max(self.db.nameFontSize - 1, 8)
        local castFontFlags = getReadableNameFontFlags(self.db.fontFlags)
        local castFontKey = table.concat({
            self.db.nameFont,
            tostring(castFontSize),
            castFontFlags,
        }, "|")
        if castFontKeyByTextRegion[castBar.Text] ~= castFontKey then
            castBar.Text:SetFont(self.db.nameFont, castFontSize, castFontFlags)
            castFontKeyByTextRegion[castBar.Text] = castFontKey
        end
    end

    self:ApplyCastBarLayout(unitFrame)
    self:ApplyCastColor(unitFrame)
end

function CleanPlates:ApplyHealth(unitFrame)
    if not HEALTH_BAR_STYLING_SUPPORTED or not self.db or not self.db.enabled or not unitFrame then
        return
    end
    if isForbiddenObject(unitFrame) then
        return
    end

    local healthBar = getHealthBar(unitFrame)
    if not healthBar or isForbiddenObject(healthBar) then
        return
    end

    local unit = getUnit(unitFrame)
    if not unit or not safeUnitExists(unit) then
        return
    end

    if self.db.classColorPlayers and safeUnitIsPlayer(unit) then
        local _, classTag = UnitClass(unit)
        local classColor = classTag and RAID_CLASS_COLORS[classTag]
        if classColor then
            healthBar:SetStatusBarColor(classColor.r, classColor.g, classColor.b)
            return
        end
    end

    if safeUnitIsEnemy(unitFrame, unit) then
        healthBar:SetStatusBarColor(self.db.enemyColor.r, self.db.enemyColor.g, self.db.enemyColor.b)
        return
    end

    local reaction = safeUnitReaction("player", unit)
    if reaction == 4 then
        healthBar:SetStatusBarColor(self.db.neutralColor.r, self.db.neutralColor.g, self.db.neutralColor.b)
        return
    end

    healthBar:SetStatusBarColor(self.db.friendlyColor.r, self.db.friendlyColor.g, self.db.friendlyColor.b)
end

function CleanPlates:ApplyUnitFrame(unitFrame, force)
    if not FRAME_STYLING_SUPPORTED then
        return
    end
    if not unitFrame then
        return
    end
    if isForbiddenObject(unitFrame) then
        return
    end

    if not force then
        local now = getNow()
        if lastApplyTimeByUnitFrame[unitFrame] and (now - lastApplyTimeByUnitFrame[unitFrame]) < DUPLICATE_APPLY_WINDOW then
            return
        end
        lastApplyTimeByUnitFrame[unitFrame] = now
    else
        lastApplyTimeByUnitFrame[unitFrame] = getNow()
    end

    self:ApplyName(unitFrame)
    self:ApplyQuestMarker(unitFrame)
    self:ApplyAuraSettings(unitFrame)
    self:ApplyTextures(unitFrame)
    self:ApplyManualNameplateSize(unitFrame)
    self:ApplyHealth(unitFrame)
    self:ApplyHealthText(unitFrame)
end

function CleanPlates:QueueApplyUnitFrame(unitFrame, force, delay)
    if not FRAME_STYLING_SUPPORTED then
        return
    end
    if not unitFrame or isForbiddenObject(unitFrame) then
        return
    end
    if not self.db or not self.db.enabled then
        return
    end

    local existing = queuedApplyByUnitFrame[unitFrame]
    if existing ~= nil then
        if force then
            queuedApplyByUnitFrame[unitFrame] = true
        end
        return
    end

    queuedApplyByUnitFrame[unitFrame] = force and true or false
    if not C_Timer or type(C_Timer.After) ~= "function" then
        local queuedForce = queuedApplyByUnitFrame[unitFrame]
        queuedApplyByUnitFrame[unitFrame] = nil
        if queuedForce ~= nil then
            self:ApplyUnitFrame(unitFrame, queuedForce)
        end
        return
    end

    C_Timer.After(delay or 0, function()
        local queuedForce = queuedApplyByUnitFrame[unitFrame]
        queuedApplyByUnitFrame[unitFrame] = nil
        if queuedForce == nil then
            return
        end
        if not CleanPlates.db or not CleanPlates.db.enabled then
            return
        end
        if isForbiddenObject(unitFrame) then
            return
        end
        CleanPlates:ApplyUnitFrame(unitFrame, queuedForce)
    end)
end

function CleanPlates:ApplyToAllNamePlates()
    if not FRAME_STYLING_SUPPORTED then
        return
    end
    if not self.db or not self.db.enabled or not C_NamePlate or type(C_NamePlate.GetNamePlates) ~= "function" then
        return
    end

    local plates = C_NamePlate.GetNamePlates() or {}
    for i = 1, #plates do
        local plate = plates[i]
        if plate and plate.UnitFrame then
            self:ApplyUnitFrame(plate.UnitFrame, true)
        end
    end
end

function CleanPlates:RestoreBlizzardNameColors()
    -- Do not call Blizzard CompactUnitFrame update functions directly on Midnight.
    -- Direct calls taint secure values used by nameplate health internals.
    return
end

function CleanPlates:RestoreCombatTextStyle()
    if not CombatTextFont or not CombatTextFont.SetFont then
        return
    end

    local fontPath = DAMAGE_TEXT_FONT or STANDARD_TEXT_FONT or "Fonts\\FRIZQT__.TTF"
    local fontSize = tonumber(COMBAT_TEXT_HEIGHT) or 24
    CombatTextFont:SetFont(fontPath, fontSize, "OUTLINE")
end

function CleanPlates:RunRuntimeAudit()
    if not self.db then
        self:Print("Audit: database not ready.")
        return
    end

    self:NormalizeSettings()
    local function printToggle(label, dbValue, cvarCandidates)
        local cvarName, cvarValue = getFirstAvailableCVar(cvarCandidates)
        self:Print(string.format("Audit %s: db=%s cvar(%s)=%s", label, tostring(dbValue), tostring(cvarName), tostring(cvarValue)))
    end
    local function printAuraBitfield(label, cvarName, enumTable, key)
        local bitIndex = type(enumTable) == "table" and enumTable[key] or nil
        if type(bitIndex) ~= "number" then
            self:Print(string.format("Audit %s: unavailable", label))
            return
        end
        local value = getCVarBitfieldValue(cvarName, bitIndex)
        self:Print(string.format("Audit %s: bitfield(%s[%s=%d])=%s", label, cvarName, key, bitIndex, tostring(value)))
    end

    self:Print("Audit: start")
    printToggle("Enemy plates", self.db.showEnemyPlates, { "nameplateShowEnemies" })
    printToggle("Friendly plates", self.db.showFriendlyPlates, { "nameplateShowFriends" })
    printToggle("Enemy NPCs", self.db.showEnemyPlates, { "nameplateShowEnemyNPCs", "nameplateShowEnemyNpcs" })
    printToggle("Friendly NPCs", self.db.showFriendlyPlates, { "nameplateShowFriendlyNPCs", "nameplateShowFriendlyNpcs" })
    printToggle("Friendly pets", self.db.showFriendlyPets, { "nameplateShowFriendlyPlayerPets", "nameplateShowFriendlyPets" })
    printToggle("Friendly guardians", self.db.showFriendlyGuardians, { "nameplateShowFriendlyPlayerGuardians", "nameplateShowFriendlyGuardians" })
    printToggle("Friendly totems", self.db.showFriendlyTotems, { "nameplateShowFriendlyPlayerTotems", "nameplateShowFriendlyTotems" })
    printToggle("Friendly minions", self.db.showFriendlyMinions, { "nameplateShowFriendlyPlayerMinions", "nameplateShowFriendlyMinions" })
    printToggle("Debuffs enemy", self.db.showDebuffsOnEnemy, { "nameplateShowDebuffsOnEnemy", "nameplateShowDebuffsOnEnemies" })
    printToggle("Buffs enemy", self.db.showBuffsOnEnemy, { "nameplateShowBuffsOnEnemy", "nameplateShowBuffsOnEnemies" })
    printToggle("Debuffs friendly", self.db.showDebuffsOnFriendly, { "nameplateShowDebuffsOnFriendly", "nameplateShowDebuffsOnFriendlies" })
    printToggle("Buffs friendly", self.db.showBuffsOnFriendly, { "nameplateShowBuffsOnFriendly", "nameplateShowBuffsOnFriendlies" })
    if type(Enum) == "table" then
        printAuraBitfield("Enemy NPC buffs", "nameplateEnemyNpcAuraDisplay", Enum.NamePlateEnemyNpcAuraDisplay, "Buffs")
        printAuraBitfield("Enemy NPC debuffs", "nameplateEnemyNpcAuraDisplay", Enum.NamePlateEnemyNpcAuraDisplay, "Debuffs")
        printAuraBitfield("Enemy player buffs", "nameplateEnemyPlayerAuraDisplay", Enum.NamePlateEnemyPlayerAuraDisplay, "Buffs")
        printAuraBitfield("Enemy player debuffs", "nameplateEnemyPlayerAuraDisplay", Enum.NamePlateEnemyPlayerAuraDisplay, "Debuffs")
        printAuraBitfield("Friendly player buffs", "nameplateFriendlyPlayerAuraDisplay", Enum.NamePlateFriendlyPlayerAuraDisplay, "Buffs")
        printAuraBitfield("Friendly player debuffs", "nameplateFriendlyPlayerAuraDisplay", Enum.NamePlateFriendlyPlayerAuraDisplay, "Debuffs")
    end
    self:Print("Audit aura caps: db.maxBuffs=" .. tostring(self.db.maxBuffs) .. ", db.maxDebuffs=" .. tostring(self.db.maxDebuffs))
    self:Print("Audit health percent: supported=" .. tostring(HEALTH_PERCENT_SUPPORTED) .. ", blocked=" .. tostring(self.healthPercentBlocked == true))
    self:Print("Audit size mode: " .. tostring(self.nameplateSizeMode or "unknown"))
    if C_NamePlate then
        self:Print("Audit API SetSize=" .. tostring(type(C_NamePlate.SetNamePlateSize) == "function") ..
            ", SetEnemySize=" .. tostring(type(C_NamePlate.SetNamePlateEnemySize) == "function") ..
            ", SetFriendlySize=" .. tostring(type(C_NamePlate.SetNamePlateFriendlySize) == "function"))
        if type(C_NamePlate.GetNamePlateEnemySize) == "function" then
            local ok, w, h = pcall(C_NamePlate.GetNamePlateEnemySize)
            self:Print("Audit API EnemySize current=" .. tostring(ok and string.format("%.2fx%.2f", w or -1, h or -1) or "n/a"))
        end
        if type(C_NamePlate.GetNamePlateFriendlySize) == "function" then
            local ok, w, h = pcall(C_NamePlate.GetNamePlateFriendlySize)
            self:Print("Audit API FriendlySize current=" .. tostring(ok and string.format("%.2fx%.2f", w or -1, h or -1) or "n/a"))
        end
    else
        self:Print("Audit API: C_NamePlate unavailable")
    end
    self:Print("Audit API CompactUnitFrame_UpdateAuras=" .. tostring(type(CompactUnitFrame_UpdateAuras) == "function"))
    self:Print("Audit: done")
end

function CleanPlates:RestoreBlizzardStyle()
    if not C_NamePlate or type(C_NamePlate.GetNamePlates) ~= "function" then
        return
    end

    if FRAME_STYLING_SUPPORTED then
        local plates = C_NamePlate.GetNamePlates() or {}
        for i = 1, #plates do
            local plate = plates[i]
            if plate and plate.UnitFrame then
                self:RestoreManualNameplateSize(plate.UnitFrame)

                local artOverlay = plateArtOverlayByUnitFrame[plate.UnitFrame]
                if artOverlay and not isForbiddenObject(artOverlay) then
                    artOverlay:Hide()
                end

                local healthText = healthTextByUnitFrame[plate.UnitFrame]
                if healthText and not isForbiddenObject(healthText) then
                    healthText:Hide()
                end
                local questMarker = questMarkerByUnitFrame[plate.UnitFrame]
                if questMarker and not isForbiddenObject(questMarker) then
                    questMarker:Hide()
                end

                if HEALTH_TEXTURE_STYLING_SUPPORTED then
                    local healthBar = getHealthBar(plate.UnitFrame)
                    if healthBar and healthBar.SetStatusBarTexture and not isForbiddenObject(healthBar) then
                        local defaultHealthTexture = self:ResolveStatusBarTexture(defaults.healthTexture, defaults.healthTexture)
                        pcall(healthBar.SetStatusBarTexture, healthBar, defaultHealthTexture)
                        healthTextureByHealthBar[healthBar] = nil
                    end
                end

                local castBar = getCastBar(plate.UnitFrame)
                if castBar and castBar.SetStatusBarTexture and not isForbiddenObject(castBar) then
                    local defaultCastTexture = self:ResolveStatusBarTexture(defaults.castTexture, defaults.castTexture)
                    pcall(castBar.SetStatusBarTexture, castBar, defaultCastTexture)
                    castTextureByCastBar[castBar] = nil
                end
            end
        end
    end

    if C_NamePlate then
        if self.baseNameplateWidth and self.baseNameplateHeight and type(C_NamePlate.SetNamePlateSize) == "function" then
            pcall(C_NamePlate.SetNamePlateSize, self.baseNameplateWidth, self.baseNameplateHeight)
        else
            if self.baseEnemyWidth and self.baseEnemyHeight and type(C_NamePlate.SetNamePlateEnemySize) == "function" then
                pcall(C_NamePlate.SetNamePlateEnemySize, self.baseEnemyWidth, self.baseEnemyHeight)
            end
            if self.baseFriendlyWidth and self.baseFriendlyHeight and type(C_NamePlate.SetNamePlateFriendlySize) == "function" then
                pcall(C_NamePlate.SetNamePlateFriendlySize, self.baseFriendlyWidth, self.baseFriendlyHeight)
            end
        end
    end
    self.apiSizeCompensationActive = false
    self.lastApiSizeCompensationKey = nil
    self.nameplateSizeMode = "blizzard"

    self:RestoreCombatTextStyle()
end

function CleanPlates:ApplyCombatTextStyle()
    if not self.db or not self.db.enabled or not self.db.styleCombatText then
        return
    end

    if CombatTextFont and CombatTextFont.SetFont then
        CombatTextFont:SetFont(self.db.nameFont, self.db.combatTextFontSize, self.db.fontFlags)
    end
end

function CleanPlates:QueueRefresh(delay)
    if self.refreshQueued then
        return
    end

    self.refreshQueued = true
    C_Timer.After(delay or 0.05, function()
        self.refreshQueued = nil
        if not self.db then
            return
        end

        if self.db.enabled then
            self:Refresh()
        else
            self:RestoreBlizzardStyle()
        end
    end)
end

function CleanPlates:Refresh()
    self:NormalizeSettings()
    if not self.db.enabled then
        self.forceCVarReapply = true
        self:RestoreBlizzardStyle()
        return
    end

    self:ApplyNameplateCVars()
    if FRAME_STYLING_SUPPORTED then
        self:ApplyToAllNamePlates()
    end
    if self.db.styleCombatText then
        self:ApplyCombatTextStyle()
    else
        self:RestoreCombatTextStyle()
    end
end

function CleanPlates:ResetToDefaults()
    if self.aceDB and type(self.aceDB.ResetProfile) == "function" then
        self.aceDB:ResetProfile()
        self.db = self.aceDB.profile
        self:NormalizeSettings()
        self.forceCVarReapply = true
        return
    end

    local existingProfiles = nil
    local activeProfileName = PROFILE_DEFAULT_NAME
    if self.db and type(self.db.profiles) == "table" then
        existingProfiles = deepCopyTable(self.db.profiles)
    end
    if self.db and type(self.db.activeProfileName) == "string" and self.db.activeProfileName ~= "" then
        activeProfileName = self.db.activeProfileName
    end

    CleanPlatesDB = copyDefaults(defaults, {})
    if existingProfiles then
        CleanPlatesDB.profiles = existingProfiles
    end
    CleanPlatesDB.activeProfileName = activeProfileName
    self.db = CleanPlatesDB
    self:NormalizeSettings()
    self:EnsureProfileStore()
    self.db.profiles[self.db.activeProfileName] = self:CaptureCurrentSettings()
    self.forceCVarReapply = true
end

function CleanPlates:GetPresetNames()
    return { "vivid", "neutral", "soft" }
end

function CleanPlates:GetActivePreset()
    if not self.db then
        return defaults.preset
    end
    return self.db.preset or defaults.preset
end

function CleanPlates:ApplyPreset(presetName, silent)
    if not self.db then
        return
    end

    local preset = presets[presetName]
    if not preset then
        self:Print("Unknown preset. Use: vivid, neutral, soft.")
        return
    end

    self.db.preset = presetName
    self.db.enemyColor = {
        r = preset.enemyColor.r,
        g = preset.enemyColor.g,
        b = preset.enemyColor.b,
    }
    self.db.friendlyColor = {
        r = preset.friendlyColor.r,
        g = preset.friendlyColor.g,
        b = preset.friendlyColor.b,
    }
    self.db.neutralColor = {
        r = preset.neutralColor.r,
        g = preset.neutralColor.g,
        b = preset.neutralColor.b,
    }
    self.db.targetColor = {
        r = preset.targetColor.r,
        g = preset.targetColor.g,
        b = preset.targetColor.b,
    }
    self.db.castInterruptibleColor = {
        r = preset.castInterruptibleColor.r,
        g = preset.castInterruptibleColor.g,
        b = preset.castInterruptibleColor.b,
    }
    self.db.castUninterruptibleColor = {
        r = preset.castUninterruptibleColor.r,
        g = preset.castUninterruptibleColor.g,
        b = preset.castUninterruptibleColor.b,
    }
    self.db.castFriendlyColor = {
        r = preset.castFriendlyColor.r,
        g = preset.castFriendlyColor.g,
        b = preset.castFriendlyColor.b,
    }
    self.db.healthTextColor = {
        r = preset.healthTextColor.r,
        g = preset.healthTextColor.g,
        b = preset.healthTextColor.b,
    }
    self.db.targetFontBoost = preset.targetFontBoost
    self.db.nameFontSize = preset.nameFontSize
    self.db.combatTextFontSize = preset.combatTextFontSize

    if self.RefreshOptions then
        self:RefreshOptions()
    end

    self:Refresh()
    if not silent then
        self:Print("Preset applied: " .. presetName)
    end
end

function CleanPlates:SetupSlashCommands()
    if self.slashReady then
        return
    end

    self.slashReady = true
    SLASH_CLEANPLATES1 = "/cleanplates"
    SLASH_CLEANPLATES2 = "/cp"

    SlashCmdList.CLEANPLATES = function(input)
        local command = trim(input or ""):lower()
        if command == "audit" then
            if CleanPlates.RunRuntimeAudit then
                CleanPlates:RunRuntimeAudit()
            else
                CleanPlates:Print("Audit is unavailable.")
            end
            return
        end

        if command ~= "" and command ~= "open" and command ~= "options" and command ~= "settings" then
            CleanPlates:Print("UI-only mode: use /cp or /cleanplates to open settings.")
        end
        if CleanPlates.ToggleOptions then
            CleanPlates:ToggleOptions()
        else
            CleanPlates:Print("Options are not ready yet.")
        end
    end
end

local function installHooks()
    -- Midnight stability mode:
    -- avoid hooking CompactUnitFrame/NamePlate mixin update functions directly.
    -- Applying from those secure update paths can taint secret values.
    baseHooksInstalled = true
    mixinHooksInstalled = true
    legacySetupHookInstalled = true
end

CleanPlates:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local loadedAddon = ...
        if loadedAddon == "Blizzard_Settings" then
            if self.InitializeSettingsCategory then
                self:InitializeSettingsCategory()
            end
            if self.InitializeAceOptions then
                self:InitializeAceOptions()
            end
            return
        end

        if loadedAddon == "Blizzard_NamePlates" or loadedAddon == "Blizzard_UnitFrame" then
            installHooks()
            return
        end

        if loadedAddon ~= ADDON_NAME then
            return
        end

        if self.initialized then
            return
        end
        self.initialized = true

        self:InitializeDatabase()
        self.forceCVarReapply = true
        self:ClearQuestRelevanceCache()

        installHooks()
        self:SetupSlashCommands()
        if self.InitializeSettingsCategory then
            self:InitializeSettingsCategory()
        end
        if self.InitializeAceOptions then
            self:InitializeAceOptions()
        end
        if not self.startupNoticeShown then
            self.startupNoticeShown = true
            self:Print(localizeText(
                "Addon is in development. Feedback is welcome. Open settings with /cp.",
                "Addon ist in Entwicklung. Feedback ist willkommen. Einstellungen mit /cp oeffnen."
            ))
        end

        self:RegisterEvent("PLAYER_ENTERING_WORLD")
        self:RegisterEvent("CVAR_UPDATE")
        self:RegisterEvent("PLAYER_REGEN_ENABLED")
        self:RegisterEvent("QUEST_LOG_UPDATE")
        self:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
        if FRAME_STYLING_SUPPORTED then
            self:RegisterEvent("NAME_PLATE_UNIT_ADDED")
            self:RegisterEvent("PLAYER_TARGET_CHANGED")
        end
        if HEALTH_PERCENT_SUPPORTED then
            self:RegisterEvent("UNIT_HEALTH")
            self:RegisterEvent("UNIT_MAXHEALTH")
        end
        if FRAME_STYLING_SUPPORTED then
            self:RegisterEvent("UNIT_SPELLCAST_START")
            self:RegisterEvent("UNIT_SPELLCAST_STOP")
            self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTIBLE")
            self:RegisterEvent("UNIT_SPELLCAST_NOT_INTERRUPTIBLE")
            self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
            self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
        end
        self:RegisterEvent("PLAYER_LOGIN")
        return
    end

    if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_LOGIN" then
        C_Timer.After(0.10, function()
            self:Refresh()
        end)
        return
    end

    if event == "PLAYER_TARGET_CHANGED" then
        if FRAME_STYLING_SUPPORTED and self.db and self.db.enabled then
            self:ApplyToAllNamePlates()
        elseif not FRAME_STYLING_SUPPORTED then
            return
        else
            self:RestoreBlizzardStyle()
        end
        return
    end

    if event == "NAME_PLATE_UNIT_ADDED" then
        if not FRAME_STYLING_SUPPORTED then
            return
        end
        local unitToken = ...
        if not unitToken or not C_NamePlate or type(C_NamePlate.GetNamePlateForUnit) ~= "function" or not self.db or not self.db.enabled then
            return
        end

        local plate = C_NamePlate.GetNamePlateForUnit(unitToken)
        if plate and plate.UnitFrame then
            self:QueueApplyUnitFrame(plate.UnitFrame, true)
        end
        return
    end

    if event == "CVAR_UPDATE" then
        local rawCVarName, rawCVarValue = ...
        local cvarName = tostring(rawCVarName or ""):lower()
        if startsWith(cvarName, "nameplate") or startsWith(cvarName, "floatingcombattext") then
            if startsWith(cvarName, "nameplate") then
                self:SyncRootPlateTogglesFromCVars(cvarName, rawCVarValue)
            end
            self.forceCVarReapply = true
            self:QueueRefresh(0.08)
        end
        return
    end

    if event == "PLAYER_REGEN_ENABLED" then
        if self.db and self.db.enabled then
            if self.pendingSizeApplyAfterCombat then
                self:Debug("combat ended, applying deferred nameplate size update")
            end
            self.forceCVarReapply = true
            self:QueueRefresh(0.05)
        end
        return
    end

    if event == "QUEST_LOG_UPDATE" or event == "QUEST_WATCH_LIST_CHANGED" then
        self:ClearQuestRelevanceCache()
        if self.db and self.db.enabled then
            self:QueueRefresh(0.12)
        end
        return
    end

    if event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH" then
        if not HEALTH_PERCENT_SUPPORTED then
            return
        end

        local unitToken = ...
        if not unitToken or not startsWith(unitToken, "nameplate") or not self.db or not self.db.enabled then
            return
        end

        if not C_NamePlate or type(C_NamePlate.GetNamePlateForUnit) ~= "function" then
            return
        end

        local plate = C_NamePlate.GetNamePlateForUnit(unitToken)
        if plate and plate.UnitFrame then
            self:ApplyHealth(plate.UnitFrame)
            self:ApplyHealthText(plate.UnitFrame)
        end
        return
    end

    if event == "UNIT_SPELLCAST_START"
        or event == "UNIT_SPELLCAST_STOP"
        or event == "UNIT_SPELLCAST_INTERRUPTIBLE"
        or event == "UNIT_SPELLCAST_NOT_INTERRUPTIBLE"
        or event == "UNIT_SPELLCAST_CHANNEL_START"
        or event == "UNIT_SPELLCAST_CHANNEL_STOP" then
        if not FRAME_STYLING_SUPPORTED then
            return
        end
        local unitToken = ...
        if not unitToken or not startsWith(unitToken, "nameplate") or not self.db or not self.db.enabled then
            return
        end

        if not C_NamePlate or type(C_NamePlate.GetNamePlateForUnit) ~= "function" then
            return
        end

        local plate = C_NamePlate.GetNamePlateForUnit(unitToken)
        if plate and plate.UnitFrame then
            self:QueueApplyUnitFrame(plate.UnitFrame)
        end
    end
end)

CleanPlates:RegisterEvent("ADDON_LOADED")
