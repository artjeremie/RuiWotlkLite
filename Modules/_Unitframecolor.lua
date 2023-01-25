-- Class color
local function RuiWotlkClass(healthbar, unit)
    if UnitIsPlayer(unit) and UnitIsConnected(unit) and UnitClass(unit) then
        _, class = UnitClass(unit);
        local c = RAID_CLASS_COLORS[class];
        healthbar:SetStatusBarColor(c.r, c.g, c.b);
    elseif UnitIsPlayer(unit) and (not UnitIsConnected(unit)) then
        healthbar:SetStatusBarColor(0.5,0.5,0.5);
    else
        healthbar:SetStatusBarColor(0,0.9,0);
    end
end
hooksecurefunc("UnitFrameHealthBar_Update", RuiWotlkClass)
hooksecurefunc("HealthBar_OnValueChanged", function(self)
    RuiWotlkClass(self, self.unit)
end)

-- Faction Color
local function RuiWotlkReaction(healthbar, unit)
    if UnitExists(unit) and (not UnitIsPlayer(unit)) then
        if (UnitIsTapDenied(unit)) and not UnitPlayerControlled(unit) then
            healthbar:SetStatusBarColor(0.5, 0.5, 0.5)
        elseif (not UnitIsTapDenied(unit)) then
            local reaction = FACTION_BAR_COLORS[UnitReaction(unit,"player")];
            if reaction then
                healthbar:SetStatusBarColor(reaction.r, reaction.g, reaction.b);
            else
                healthbar:SetStatusBarColor(0,0.6,0.1)
            end
        end
    end
end
hooksecurefunc("UnitFrameHealthBar_Update", RuiWotlkReaction)
hooksecurefunc("HealthBar_OnValueChanged", function(self)
    RuiWotlkReaction(self, self.unit)
end)