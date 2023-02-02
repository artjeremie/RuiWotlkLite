-- Credits to: https://www.curseforge.com/wow/addons/mini-item-level

local MTT = {}

-- Add the item level text to the tooltip
function MTT:SetToolTipText(tooltip, itemLevel, itemClassID, rowIndex, isShoppingTooltip)

    -- Weapon, Armor, or Projectile
    if itemClassID == 2 or itemClassID == 4 or itemClassID == 6 then
        local left = _G[tooltip:GetName() .. 'TextLeft' .. rowIndex]
        local leftText = left:GetText()

        if isShoppingTooltip then
            left:SetText("|cffffd100Item Level: " .. itemLevel .. "|r")

            local nextLeft = _G[tooltip:GetName() .. 'TextLeft' .. rowIndex+1]
            nextLeft:SetText(leftText .. "|n" .. nextLeft:GetText())
        else
            left:SetText("|cffffd100Item Level: " .. itemLevel .. "|r|n" .. leftText)
        end

        tooltip:Show()
    end
end

-- Get the item info from the given item link provided
function MTT:GetItemInfoFromLink(link)
    if link then
        local _, _, _, itemLevel,_,_,_,_,_,_,_, classID,_ = GetItemInfo(link)
        return itemLevel, classID
    end
end

-- Modify the on hover tooltip's text to include current item context's item level
local function GameTooltipSetItem(tooltip, ...)
    if tooltip:IsForbidden() then
        return
    end

    local _, link = tooltip:GetItem()

    local itemLevel, classID = MTT:GetItemInfoFromLink(link)

    MTT:SetToolTipText(tooltip, itemLevel, classID, 2)
end

-- The first comparison tooltip when comparison modifier is true, e.g shift key pressed on hover
local function ShoppingTooltip1SetItem(tooltip, ...)
    if tooltip:IsForbidden() then
        return
    end

    local _, link = tooltip:GetItem()

    local itemLevel, classID = MTT:GetItemInfoFromLink(link)

    MTT:SetToolTipText(tooltip, itemLevel, classID, 3, true)
end

-- The second comparison tooltip when comparison modifier is true, e.g shift key pressed on hover
local function ShoppingTooltip2SetItem(tooltip, ...)
    if tooltip:IsForbidden() then
        return
    end

    local _, link = tooltip:GetItem()

    local itemLevel, classID = MTT:GetItemInfoFromLink(link)

    MTT:SetToolTipText(tooltip, itemLevel, classID, 3, true)
end

-- The third comparison tooltip when comparison modifier is true, e.g shift key pressed on hover
local function ShoppingTooltip3SetItem(tooltip, ...)
    if tooltip:IsForbidden() then
        return
    end

    local _, link = tooltip:GetItem()

    local itemLevel, classID = MTT:GetItemInfoFromLink(link)

    MTT:SetToolTipText(tooltip, itemLevel, classID, 3, true)
end

-- The on-item link click tooltip
local function ItemRefTooltipSetItem(tooltip, ...)
    if tooltip:IsForbidden() then
        return
    end

    local _, link = tooltip:GetItem()

    local itemLevel, classID = MTT:GetItemInfoFromLink(link)

    MTT:SetToolTipText(tooltip, itemLevel, classID, 2)
end

local f = CreateFrame("Frame")
f:RegisterEvent("GET_ITEM_INFO_RECEIVED")
f:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")

GameTooltip:HookScript("OnTooltipSetItem", GameTooltipSetItem)
ItemRefTooltip:HookScript("OnTooltipSetItem", ItemRefTooltipSetItem)
ShoppingTooltip1:HookScript("OnTooltipSetItem", ShoppingTooltip1SetItem)
ShoppingTooltip2:HookScript("OnTooltipSetItem", ShoppingTooltip2SetItem)
