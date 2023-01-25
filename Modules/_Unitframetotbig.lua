-- ToT Big Frame
local function RuiWotlkBigToT()
    TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\AddOns\\RuiWotlkLite\\Media\\Unitframes\\Flat")
    TargetFrameToTManaBar:SetStatusBarTexture("Interface\\AddOns\\RuiWotlkLite\\Media\\Unitframes\\Flat")
    TargetFrameToTTextureFrameDeadText:ClearAllPoints();
    TargetFrameToTTextureFrameDeadText:SetPoint("CENTER", "TargetFrameToTHealthBar","CENTER",1, 0);
    TargetFrameToTTextureFrameName:SetSize(65,10);
    TargetFrameToTTextureFrameTexture:SetTexture("Interface\\Addons\\RuiWotlkLite\\Media\\Unitframes\\UI-TargetofTargetFrame");
    TargetFrameToTHealthBar:ClearAllPoints();
    TargetFrameToTHealthBar:SetPoint("TOPLEFT", 45, -15);
    TargetFrameToTHealthBar:SetHeight(10);
    TargetFrameToTManaBar:ClearAllPoints();
    TargetFrameToTManaBar:SetPoint("TOPLEFT", 45, -25);
    TargetFrameToTManaBar:SetHeight(5);
    FocusFrameToTTextureFrameDeadText:ClearAllPoints();
    FocusFrameToTTextureFrameDeadText:SetPoint("CENTER", "FocusFrameToTHealthBar" ,"CENTER",1, 0);
    FocusFrameToTTextureFrameName:SetSize(65,10);
    FocusFrameToTTextureFrameTexture:SetTexture("Interface\\Addons\\RuiWotlkLite\\Media\\Unitframes\\UI-TargetofTargetFrame");
    FocusFrameToTHealthBar:ClearAllPoints();
    FocusFrameToTHealthBar:SetPoint("TOPLEFT", 43, -15);
    FocusFrameToTHealthBar:SetHeight(10);
    FocusFrameToTManaBar:ClearAllPoints();
    FocusFrameToTManaBar:SetPoint("TOPLEFT", 43, -25);
    FocusFrameToTManaBar:SetHeight(5);
end
hooksecurefunc("TargetFrame_CheckClassification", RuiWotlkBigToT)