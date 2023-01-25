-- Target Big Frame
local function RuiWotlkBigTarget(self, forceNormalTexture)
    local classification = UnitClassification(self.unit);
    self.healthbar:SetStatusBarTexture("Interface\\AddOns\\RuiWotlkLite\\Media\\Unitframes\\Flat")
    self.highLevelTexture:SetPoint("CENTER", self.levelText, "CENTER", 0,0);
    self.deadText:SetPoint("CENTER", self.healthbar, "CENTER",0,0);
    self.nameBackground:Hide();
    self.name:SetPoint("LEFT", self, 15, 36);
    self.healthbar:SetSize(119, 26);
    self.healthbar:SetPoint("TOPLEFT", 5, -24);
    self.healthbar.LeftText:SetPoint("LEFT", self.healthbar, "LEFT", 8, 0);
    self.healthbar.RightText:SetPoint("RIGHT", self.healthbar, "RIGHT", -5, 0);
    self.healthbar.TextString:SetPoint("CENTER", self.healthbar, "CENTER", 0, 0);
    self.manabar:SetPoint("TOPLEFT", 5, -52);
    self.manabar:SetSize(119, 13);
    self.manabar.LeftText:SetPoint("LEFT", self.manabar, "LEFT", 8, 0);
    self.manabar.RightText:ClearAllPoints();
    self.manabar.RightText:SetPoint("RIGHT", self.manabar, "RIGHT", -5, 0);
    self.manabar.TextString:SetPoint("CENTER", self.manabar, "CENTER", 0, 0);
    if (forceNormalTexture) then
        self.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame");
    elseif ( classification == "minus" ) then
        self.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Minus");
        forceNormalTexture = true;
    elseif ( classification == "worldboss" or classification == "elite" ) then
        self.borderTexture:SetTexture("Interface\\Addons\\RuiWotlkLite\\Media\\UnitFrames\\UI-TargetingFrame-Elite");
    elseif ( classification == "rareelite" ) then
        self.borderTexture:SetTexture("Interface\\Addons\\RuiWotlkLite\\Media\\UnitFrames\\UI-TargetingFrame-Rare-Elite");
    elseif ( classification == "rare" ) then
        self.borderTexture:SetTexture("Interface\\Addons\\RuiWotlkLite\\Media\\UnitFrames\\UI-TargetingFrame-Rare");
    else
        self.borderTexture:SetTexture("Interface\\Addons\\RuiWotlkLite\\Media\\UnitFrames\\UI-TargetingFrame");
        forceNormalTexture = true;
    end
    if (forceNormalTexture) then
        self.haveElite = nil;
        if (classification == "minus") then
            self.Background:SetSize(119,12);
            self.Background:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 7, 47);
            self.name:SetPoint("LEFT", self, 16, 19);
            self.healthbar:ClearAllPoints();
            self.healthbar:SetPoint("LEFT", 5, 3);
            self.healthbar:SetHeight(12);
            self.healthbar.LeftText:SetPoint("LEFT", self.healthbar, "LEFT", 3, 0);
            self.healthbar.RightText:SetPoint("RIGHT", self.healthbar, "RIGHT", -2, 0);
        else
            self.Background:SetSize(119,42);
            self.Background:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 7, 35);
        end
    else
        self.haveElite = true;
        self.Background:SetSize(119,42);
    end
    self.healthbar.lockColor = true;
end
hooksecurefunc("TargetFrame_CheckClassification", RuiWotlkBigTarget)