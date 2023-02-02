local g = CreateFrame("Frame")
g:RegisterEvent("MERCHANT_SHOW")
g:SetScript("OnEvent", function()
    if(CanMerchantRepair()) then
        local cost = GetRepairAllCost()
        if cost > 0 then
            local money = GetMoney()
            if IsInGuild() then
                local guildMoney = GetGuildBankWithdrawMoney()
                if guildMoney > GetGuildBankMoney() then
                    guildMoney = GetGuildBankMoney()
                end

                if guildMoney > cost and CanGuildBankRepair() then
                    RepairAllItems(1)
                    print('|cffff6060Repairing all items for|r ' .. GetCoinTextureString(cost))
                    return
                end
            end
            if money > cost then
                RepairAllItems()
                print('|cffff6060Repairing all items for|r ' .. GetCoinTextureString(cost))
            else
                print("|cffff0000Not enough gold to cover the repair cost.|r")
            end
        end
    end
end)
