local mfloor, tonumber, mceil = math.floor, tonumber, math.ceil
local GetCVar = GetCVar
--local GetCVar, UnitIsDeadOrGhost = GetCVar, UnitIsDeadOrGhost

-- Unit frames Status text reformat.
local function true_format(value)
    if value > 1e7 then
        return (mfloor(value / 1e6)) .. 'm'
    elseif value > 1e6 then
        return (mfloor((value / 1e6) * 10) / 10) .. 'm'
    elseif value > 1e4 then
        return (mfloor(value / 1e3)) .. 'k'
    elseif value > 1e3 then
        return (mfloor((value / 1e3) * 10) / 10) .. 'k'
    else
        return value
    end
end

local function Text_UpdateStringValues(statusFrame, textString, value, valueMin, valueMax)
    local value = statusFrame.finalValue or statusFrame:GetValue();
    --local unit = statusFrame.unit

    local valueDisplay = value;
    local valueMaxDisplay = valueMax;

    local textDisplay = GetCVar("statusTextDisplay");
    if (textDisplay == "BOTH" and not statusFrame.showPercentage) then
        if (statusFrame.LeftText and statusFrame.RightText) then
            if (not statusFrame.powerToken or statusFrame.powerToken == "MANA") then
                statusFrame.LeftText:SetText(mceil((value / valueMax) * 100) .. "%");
                statusFrame.RightText:SetText(true_format(valueDisplay));
            end
        end
    end
end

hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", Text_UpdateStringValues)