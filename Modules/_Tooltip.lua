-- Credits to: https://www.curseforge.com/wow/addons/zaremtooltip
local _G, ipairs, format, strfind = _G, ipairs, format, strfind
local GameTooltip, GameTooltipStatusBar, ItemRefTooltip = GameTooltip, GameTooltipStatusBar, ItemRefTooltip
local GameTooltipTextLeft1, GameTooltipTextLeft2 = GameTooltipTextLeft1, GameTooltipTextLeft2

local cfg = {

    classNames = true,

    playerTitle = false,
    playerRealm = true,
    guildRank = true,
    pvpText = false, -- Reaction colored

    youText = format(">>%s<<", strupper(YOU)),
    afkText = "|cff909090 <AFK>",
    dndText = "|cff909090 <DND>",
    dcText = "|cff909090 <DC>",
    targetText = "|cffffffff@",

    reactionGuild = true,

    yourGuild = true,
    yourGuildColor = { 1, 0.3, 1 },
    guildColor = { 1, 0.3, 1 },
    gRankColor = "|cff909090",

    bossLevel = "|r|cffff0000??",
    bossClass = format(" (%s)", BOSS),
    eliteClass = "+",
    rareClass = format(" %s", ITEM_QUALITY3_DESC),
    rareEliteClass = format("+ %s", ITEM_QUALITY3_DESC),

    healthHeight = 1,
    healthTexture = "Interface\\TargetingFrame\\UI-StatusBar",
    healthInside = true,
    hideHealthBar = false,

    instantFade = true,

    bg = { 0, 0, 0, 0.2 },
    border = { 0.7, 0.7, 0.7 },

    scale = 1.0,

    font = STANDARD_TEXT_FONT,
    fontHeaderSize = 14,
    fontSize = 12,
    outlineFontHeader = true,
    outlineFont = false,

    backdrop = {
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 14,
        insets = { left = 2, right = 2, top = 2, bottom = 2 },
    },
}

GameTooltipStatusBar:SetStatusBarTexture(cfg.healthTexture)
GameTooltipStatusBar:SetHeight(cfg.healthHeight)

if cfg.healthInside then
    GameTooltipStatusBar:ClearAllPoints()
    GameTooltipStatusBar:SetPoint("BOTTOMLEFT", GameTooltip, "BOTTOMLEFT", 8, 6)
    GameTooltipStatusBar:SetPoint("BOTTOMRIGHT", GameTooltip, "BOTTOMRIGHT", -8, 6)
end

-- Fade
GameTooltip:HookScript("OnUpdate", function(self)
    if cfg.instantFade and self:GetUnit() and not (UnitExists("mouseover")) and GetMouseFocus() == WorldFrame then
        self:Hide()
    end
end)

function GameTooltip:FadeOut()
    if cfg.instantFade then
        self:Hide()
    end
end

do
    if cfg.outlineFontHeader then
        GameTooltipHeaderText:SetFont(cfg.font, cfg.fontHeaderSize, "OUTLINE")
    else
        GameTooltipHeaderText:SetFont(cfg.font, cfg.fontHeaderSize)
    end

    if cfg.outlineFont then
        GameTooltipText:SetFont(cfg.font, cfg.fontSize, "OUTLINE")
        GameTooltipTextSmall:SetFont(cfg.font, cfg.fontSize, "OUTLINE")
    else
        GameTooltipText:SetFont(cfg.font, cfg.fontSize, "")
        GameTooltipTextSmall:SetFont(cfg.font, cfg.fontSize, "")
    end
end

local Tooltips = {
    GameTooltip,
    WorldMapTooltip,
    ShoppingTooltip1,
    ShoppingTooltip2,
    ItemRefTooltip,
    ItemRefShoppingTooltip1,
    ItemRefShoppingTooltip2,
}

for i, v in ipairs(Tooltips) do
    if not v.SetBackdrop then Mixin(v, BackdropTemplateMixin) end

    v:SetBackdrop(cfg.backdrop)
    v:SetScale(cfg.scale)

    v:HookScript("OnShow", function(self)
        if not GameTooltip:GetUnit() then
            self:SetBackdropColor(cfg.bg[1], cfg.bg[2], cfg.bg[3], cfg.bg[4])
            self:SetBackdropBorderColor(cfg.border[1], cfg.border[2], cfg.border[3])
        end
    end)
end

local function Reaction(unit)
    local r, g, b
    if UnitIsDeadOrGhost(unit) or (UnitIsTapDenied(unit) and not (UnitIsPlayer(unit) or UnitPlayerControlled(unit))) or not UnitIsConnected(unit) then
        r, g, b = 0.5, 0.5, 0.5
    elseif UnitReaction(unit, "player") == 4 then
        r, g, b = 0.9, 0.8, 0.3
    elseif UnitIsFriend(unit, "player") then
        r, g, b = 0, 0.8, 0
    elseif UnitIsEnemy(unit, "player") then
        r, g, b = 0.9, 0.2, 0
    else
        r, g, b = 1, 1, 1
    end
    return r, g, b
end

local function ReactionHex(unit)
    local r, g, b = Reaction(unit)
    return format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
end

local function ClassHex(unit)
    local _, class = UnitClass(unit)
    local r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b
    return format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
end

local function QuestHex(unit)
    local level = UnitLevel(unit)
    local color = GetQuestDifficultyColor(level)
    return format("|cff%02x%02x%02x", color.r * 255, color.g * 255, color.b * 255)
end

GameTooltip:HookScript("OnTooltipCleared", function(self)
    if self:IsOwned(UIParent) and not self:GetUnit() and not self:GetItem() then
        self:SetBackdropColor(cfg.bg[1], cfg.bg[2], cfg.bg[3], cfg.bg[4])
        self:SetBackdropBorderColor(cfg.border[1], cfg.border[2], cfg.border[3])
    end
    self:SetPadding(0, 0)
end)

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
    local _, unit = self:GetUnit()
    if not unit then
        return
    end

    self:SetBackdropColor(cfg.bg[1], cfg.bg[2], cfg.bg[3], cfg.bg[4])
    self:SetBackdropBorderColor(cfg.border[1], cfg.border[2], cfg.border[3])

    local r, g, b = Reaction(unit)
    local level = UnitLevel(unit)

    if UnitIsPlayer(unit) then
        local _, class = UnitClass(unit)
        if not class then
            return
        end
        local cr, cg, cb = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b

        local nameColor
        if cfg.classNames then
            nameColor = ClassHex(unit)
        else
            nameColor = ReactionHex(unit)
        end

        local name, realm = UnitName(unit)
        if cfg.playerTitle then
            name = UnitPVPName(unit) or name
        end

        if realm and realm ~= "" then
            if cfg.playerRealm then
                GameTooltipTextLeft1:SetFormattedText("%s%s (%s)", nameColor, name, realm)
            else
                GameTooltipTextLeft1:SetFormattedText("%s%s (*)", nameColor, name)
            end
        else
            GameTooltipTextLeft1:SetFormattedText("%s%s", nameColor, name)
        end

        local guild, rank = GetGuildInfo(unit)
        if guild and strfind(GameTooltipTextLeft2:GetText(), guild) then
            if cfg.yourGuild and UnitIsInMyGuild(unit) and UnitIsSameServer(unit, "player") and UnitIsFriend(unit, "player") then
                GameTooltipTextLeft2:SetTextColor(cfg.yourGuildColor[1], cfg.yourGuildColor[2], cfg.yourGuildColor[3])
            else
                if cfg.reactionGuild then
                    GameTooltipTextLeft2:SetTextColor(r, g, b)
                else
                    GameTooltipTextLeft2:SetTextColor(cfg.guildColor[1], cfg.guildColor[2], cfg.guildColor[3])
                end
            end

            if cfg.guildRank then
                GameTooltipTextLeft2:SetFormattedText("<%s> %s%s", guild, cfg.gRankColor, rank)
            else
                GameTooltipTextLeft2:SetFormattedText("<%s>", guild)
            end
        end

        if UnitIsAFK(unit) then
            self:AppendText(cfg.afkText)
        elseif UnitIsDND(unit) then
            self:AppendText(cfg.dndText)
        elseif not UnitIsConnected(unit) then
            self:AppendText(cfg.dcText)
        end

        GameTooltipTextLeft1:SetFormattedText("%s%s", ReactionHex(unit), GameTooltipTextLeft1:GetText())

        if GameTooltipTextLeft2:IsShown() and not strfind(GameTooltipTextLeft2:GetText(), level) then
            GameTooltipTextLeft2:SetTextColor(r, g, b)
            GameTooltipTextLeft2:SetFormattedText("<%s>", GameTooltipTextLeft2:GetText())
        end
    end

    for i = 2, self:NumLines() do
        local lines = _G["GameTooltipTextLeft" .. i]

        if strfind(lines:GetText(), UNIT_LEVEL_TEMPLATE) or strfind(lines:GetText(), UNIT_LETHAL_LEVEL_TEMPLATE) then
            if level == -1 then 
                level = cfg.bossLevel
            end

            if UnitIsPlayer(unit) then
                lines:SetFormattedText("%s%s|r %s %s%s", QuestHex(unit), level, UnitRace(unit), ClassHex(unit), UnitClass(unit))
            else
                local class = UnitClassification(unit)
                if class == "worldboss" or strfind(lines:GetText(), BOSS) then
                    class = cfg.bossClass
                elseif class == "elite" then
                    class = cfg.eliteClass
                elseif class == "rare" then
                    class = cfg.rareClass
                elseif class == "rareelite" then
                    class = cfg.rareEliteClass
                else
                    class = ""
                end

                local creature = UnitCreatureFamily(unit) or UnitCreatureType(unit) or ""

                if creature == "Not specified" then
                    creature = ""
                end

                if creature == "Non-combat Pet" then
                    creature = "Pet"
                end

                lines:SetFormattedText("%s%s%s|r|cffffffff %s", QuestHex(unit), level, class, creature)
            end
        end

        if i > 2 then
            if strfind(lines:GetText(), PVP_ENABLED) then
                if cfg.pvpText then
                    lines:SetTextColor(r, g, b)
                else
                    lines:SetText(nil)
                end
            end
        end
    end

    local tot = unit .. "target"
    if UnitExists(tot) then
        if UnitIsUnit("player", tot) then
            self:AddLine(format("%s%s %s ", cfg.targetText, ReactionHex(unit), cfg.youText))
        elseif UnitIsPlayer(tot) then
            self:AddLine(format("%s %s%s", cfg.targetText, ClassHex(tot), UnitName(tot)))
        else
            self:AddLine(format("%s %s%s", cfg.targetText, ReactionHex(tot), UnitName(tot)))
        end
    end

    if cfg.hideHealthBar or UnitIsDeadOrGhost(unit) or not UnitIsConnected(unit) then
        GameTooltipStatusBar:Hide()
    end

    if cfg.healthInside and GameTooltipStatusBar:IsShown() then
        self:SetPadding(0, 1)
    end

    self:Show()
end)