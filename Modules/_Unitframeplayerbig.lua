-- Player Big frame
local function RuiWotlkBigPlayer(self)
    PlayerFrameTexture:SetTexture("Interface\\Addons\\RuiWotlkLite\\Media\\UnitFrames\\UI-TargetingFrame");
    self.healthbar:SetStatusBarTexture("Interface\\AddOns\\RuiWotlkLite\\Media\\Unitframes\\Flat")
    self.name:Hide();
    self.name:ClearAllPoints();
    self.name:SetPoint("CENTER", PlayerFrame, "CENTER",50.5, 36);
    self.healthbar:SetPoint("TOPLEFT",106,-24);
    self.healthbar:SetHeight(26);
    self.healthbar.LeftText:ClearAllPoints();
    self.healthbar.LeftText:SetPoint("LEFT",self.healthbar,"LEFT",8,0);
    self.healthbar.RightText:ClearAllPoints();
    self.healthbar.RightText:SetPoint("RIGHT",self.healthbar,"RIGHT",-5,0);
    self.healthbar.TextString:SetPoint("CENTER", self.healthbar, "CENTER", 0, 0);
    self.manabar:SetPoint("TOPLEFT",106,-52);
    self.manabar:SetHeight(13);
    self.manabar.LeftText:ClearAllPoints();
    self.manabar.LeftText:SetPoint("LEFT",self.manabar,"LEFT",8,0)      ;
    self.manabar.RightText:ClearAllPoints();
    self.manabar.RightText:SetPoint("RIGHT",self.manabar,"RIGHT",-5,0);
    self.manabar.TextString:SetPoint("CENTER",self.manabar,"CENTER",0,0);
    PlayerFrameGroupIndicatorText:ClearAllPoints();
    PlayerFrameGroupIndicatorText:SetPoint("BOTTOMLEFT", PlayerFrame,"TOP",0,-20);
    PlayerFrameGroupIndicatorLeft:Hide();
    PlayerFrameGroupIndicatorMiddle:Hide();
    PlayerFrameGroupIndicatorRight:Hide();
end
hooksecurefunc("PlayerFrame_ToPlayerArt", RuiWotlkBigPlayer)