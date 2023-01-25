-- Class icon alternative portrait
-- Credits to Shagu
hooksecurefunc("UnitFramePortrait_Update",function(self)
    if self.portrait then
        if UnitIsPlayer(self.unit) then 
            local t = CLASS_ICON_TCOORDS[select(2, UnitClass(self.unit))]
            if t then
                self.portrait:SetTexture("Interface\\AddOns\\RuiWotlkLite\\Media\\AltPortraits\\UI-Classes-Circles")
                self.portrait:SetTexCoord(unpack(t))
            end
        else
            self.portrait:SetTexCoord(0,1,0,1)
        end
    end
end)