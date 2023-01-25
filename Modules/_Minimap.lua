-- Hide Zoom in/out
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()

MinimapBorderTop:Hide()
MiniMapWorldMapButton:SetAlpha(0)
MiniMapWorldMapButton:EnableMouse(false)

GameTimeFrame:Hide()
GameTimeFrame:UnregisterAllEvents()
GameTimeFrame.Show = kill

MiniMapTracking:Hide()
MiniMapTracking.Show = kill
MiniMapTracking:UnregisterAllEvents()

-- Right click calendar
Minimap:SetScript("OnMouseUp", function(self, btn)
    if btn == "RightButton" then
        _G.GameTimeFrame:Click()
    elseif btn == "MiddleButton" then
        _G.ToggleDropDownMenu(1, nil, _G.MiniMapTrackingDropDown, self)
    else
        _G.Minimap_OnClick(self)
    end
end)

-- Adjust zone text
MinimapZoneText:SetPoint("CENTER", Minimap, 0, 80)
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, z)
    local c = Minimap:GetZoom()
    if (z > 0 and c < 5) then
        Minimap:SetZoom(c + 1)
    elseif (z < 0 and c > 0) then
        Minimap:SetZoom(c - 1)
    end
end)