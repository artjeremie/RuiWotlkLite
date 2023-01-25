-- Hide Raid frame titles
local function HideFrameTitles(groupIndex)
    local frame

    if not groupIndex then
        frame = _G["CompactPartyFrameTitle"]
    else
        frame = _G["CompactRaidGroup" .. groupIndex .. "Title"]
    end

    if frame then
        frame:Hide()
    end
end

-- Remove server name from raid frames
hooksecurefunc("CompactUnitFrame_UpdateName", function(frame)
    local inInstance, instanceType = IsInInstance()
    local name = frame.name
    local xName = GetUnitName(frame.unit, true)
    if (instanceType == "pvp" or instanceType == "arena") then
        if (xName) then
            local noRealm = gsub(xName, "%-[^|]+", "")
            name:SetText(noRealm)
        end
    end
end)