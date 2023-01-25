-- Class icon
local TEXTURE_NAME = "Interface\\AddOns\\RuiWotlkLite\\Media\\Classportraits\\%s.tga"
hooksecurefunc("UnitFramePortrait_Update", function(self)
    if self.portrait then
        if UnitIsPlayer(self.unit) then
            local _, class = UnitClass(self.unit)
            if class then
                self.portrait:SetTexture(TEXTURE_NAME:format(class))
            end
        end
    end
end)