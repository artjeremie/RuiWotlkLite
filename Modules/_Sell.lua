local g = CreateFrame("Frame")
g:RegisterEvent("MERCHANT_SHOW")
g:SetScript("OnEvent", function()
    totalPrice = 0
    for bags = 0,4 do
        for slots = 1, C_Container.GetContainerNumSlots(bags) do
            CurrentItemLink = C_Container.GetContainerItemLink(bags, slots)
            if CurrentItemLink then
                _, _, itemRarity, _, _, _, _, _, _, _, itemSellPrice = GetItemInfo(CurrentItemLink)
                MyContainerItemInfo = C_Container.GetContainerItemInfo(bags, slots)
                itemCount = MyContainerItemInfo.stackCount
                if itemRarity == 0 and itemSellPrice ~= 0 then
                    totalPrice = totalPrice + (itemSellPrice * itemCount)
                    C_Container.UseContainerItem(bags, slots)
                end
            end
        end
    end
    if totalPrice ~= 0 then
        print("|cffFFC125Sold all items for:|r " .. GetCoinTextureString(totalPrice))
    else
        print("|cff00ff00No junk to sell.|r")
    end
end)
