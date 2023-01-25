-- Credits to: https://www.curseforge.com/wow/addons/rougeui
local str_split = string.split
local UnitGUID = UnitGUID
local select, hooksecurefunc = select, hooksecurefunc

local function AddElements(plate)
    if plate:IsForbidden() then
        return
    end

    local sh = plate.selectionHighlight -- kang from evolvee
    sh:SetPoint("TOPLEFT", sh:GetParent(), "TOPLEFT", 1, -1)
    sh:SetPoint("BOTTOMRIGHT", sh:GetParent(), "BOTTOMRIGHT", -1, 1)
    if not select(1, IsActiveBattlefieldArena()) then
        plate.name:SetFont(STANDARD_TEXT_FONT, 8)
        plate.name:ClearAllPoints()
        plate.name:SetPoint("BOTTOMRIGHT", plate, "TOPRIGHT", -6, -13)
        plate.name:SetJustifyH("RIGHT")
    end
    for _, v in pairs({ plate.healthBar.border:GetRegions(), plate.CastBar.Border }) do
        v:SetVertexColor(0.25, 0.25, 0.25)
    end
end

local function NiceOne(self)
    if not self.Text:IsShown() then
        self.Text:SetFont(STANDARD_TEXT_FONT, 8)
        self.Text:Show()
    end
end
hooksecurefunc("Nameplate_CastBar_AdjustPosition", NiceOne)

-- Disable unwanted nameplates
local function HidePlates(plate, unit)
    if plate:IsForbidden() then
        return
    end

    local _, _, _, _, _, npcId = str_split("-", UnitGUID(unit))
    -- Hide feral spirit, treants, risen ghoul, army of the dead, snake trap
    -- mirror image, underbelly croc
    if npcId == "29264" or npcId == "1964" or npcId == "26125" or npcId == "24207" or npcId == "19833" or npcId == "19921" or npcId == "31216" or npcId == "32441" then
        plate.UnitFrame:Hide()
    else
        plate.UnitFrame:Show()
    end
end

local OnEvent = function(self, event, ...)
    if event == "NAME_PLATE_UNIT_ADDED" then
        local base = ...
        local namePlateFrameBase = C_NamePlate.GetNamePlateForUnit(base, issecure());
        if not namePlateFrameBase then
            return
        end
        AddElements(namePlateFrameBase.UnitFrame)
    end
    self:UnregisterEvent("ADDON_LOADED")
end

local e = CreateFrame("Frame")
e:RegisterEvent("NAME_PLATE_UNIT_ADDED")
e:RegisterEvent("ADDON_LOADED")
e:SetScript('OnEvent', OnEvent)