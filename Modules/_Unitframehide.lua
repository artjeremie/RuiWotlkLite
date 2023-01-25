-- Hide Some Shit
hooksecurefunc("PlayerFrame_UpdateStatus",function()
    -- Status glow
    PlayerStatusTexture:Hide()
    PlayerRestGlow:Hide()
    PlayerStatusGlow:Hide()
    -- Rested Icon
    PlayerRestIcon:SetAlpha(0)
    -- Pvp Badge
    PlayerPVPIcon:SetAlpha(0)
    TargetFrameTextureFramePVPIcon:SetAlpha(0)
end)

hooksecurefunc('TargetFrame_CheckFaction', function(self)
    self.nameBackground:SetVertexColor(0.0, 0.0, 0.0, 0.5);
end)

-- Hide Text
PlayerFrameGroupIndicator:SetAlpha(0)
PlayerHitIndicator:SetText(nil)
PlayerHitIndicator.SetText = function() end
PetHitIndicator:SetText(nil)
PetHitIndicator.SetText = function() end