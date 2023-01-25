-- Mana Texture
local function RuiWotlkTexture(manaBar)
    local powerType, powerToken, altR, altG, altB = UnitPowerType(manaBar.unit);
    local info = PowerBarColor[powerToken];
    if ( info ) then
        if ( not manaBar.lockColor ) then
            if not ( info.atlas ) then
                manaBar:SetStatusBarTexture("Interface\\Addons\\RuiWotlkLite\\Media\\Unitframes\\Minimalist");
            end
        end
    end
end
hooksecurefunc("UnitFrameManaBar_UpdateType", RuiWotlkTexture)