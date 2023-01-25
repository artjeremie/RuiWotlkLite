local function RuiWotlkPartyFrames()
    local useCompact = GetCVarBool("useCompactPartyFrames");
    if IsInGroup(player) and (not IsInRaid(player)) and (not useCompact) then
        for i = 1, 4 do
            _G["PartyMemberFrame"..i.."HealthBar"]:SetStatusBarTexture("Interface\\AddOns\\RuiWotlkLite\\Media\\Unitframes\\Flat")
            _G["PartyMemberFrame"..i.."ManaBar"]:SetStatusBarTexture("Interface\\AddOns\\RuiWotlkLite\\Media\\Unitframes\\Flat")
            _G["PartyMemberFrame"..i.."Name"]:SetSize(75,10);
            _G["PartyMemberFrame"..i.."Texture"]:SetTexture("Interface\\Addons\\RuiWotlkLite\\Media\\Unitframes\\UI-PartyFrame");
            _G["PartyMemberFrame"..i.."Flash"]:SetTexture("Interface\\Addons\\RuiWotlkLite\\Media\\Unitframes\\UI-PARTYFRAME-FLASH");
            _G["PartyMemberFrame"..i.."HealthBar"]:ClearAllPoints();
            _G["PartyMemberFrame"..i.."HealthBar"]:SetPoint("TOPLEFT", 45, -13);
            _G["PartyMemberFrame"..i.."HealthBar"]:SetHeight(12);
            _G["PartyMemberFrame"..i.."ManaBar"]:ClearAllPoints();
            _G["PartyMemberFrame"..i.."ManaBar"]:SetPoint("TOPLEFT", 45, -26);
            _G["PartyMemberFrame"..i.."ManaBar"]:SetHeight(5);
        end
    end
end
hooksecurefunc("UnitFrame_Update", RuiWotlkPartyFrames)
hooksecurefunc("PartyMemberFrame_ToPlayerArt", RuiWotlkPartyFrames)