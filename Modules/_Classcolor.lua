local function FriendColor_ClassColor(class)
    local localClass

    if(class == "DRUID") then
        class = "Druid"
    end

    if(class == "HUNTER") then
        class = "Hunter"
    end

    if(class == "MAGE") then
        class = "Mage"
    end

    if(class == "PALADIN") then
        class = "Paladin"
    end

    if(class == "PRIEST") then
        class = "Priest"
    end

    if(class == "ROGUE") then
        class = "Rogue"
    end

    if(class == "WARLOCK") then
        class = "Warlock"
    end

    if(class == "WARRIOR") then
        class = "Warrior"
    end

    if GetLocale() ~= "enUS" then
        for k,v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do
            if class == v then
                localClass = k
            end
        end
    else
        for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
            if class == v then
                localClass = k
            end
        end
    end

    local classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[localClass]
    if class == "Shaman" then
        classColor.r = 0.00
        classColor.g = 0.44
        classColor.b = 0.87
    end
    return classColor -- check nil
end

local function FriendColor_BNetFriend(i, friendOffset, numOnline)
    local bnetIDAccount,
        accountName,
        battleTag,
        isBattleTagPresence,
        characterName,
        bnetIDGameAccount,
        client,
        isOnline,
        lastOnline,
        isAFK,
        isDND,
        messageText,
        noteText,
        isRIDFriend,
        messageTime,
        canSoR,
        isReferAFriend,
        canSummonFriend = BNGetFriendInfo(i)

    if isOnline == false then
        return
    end

    if client ~= BNET_CLIENT_WOW then
        return
    end

    local hasFocus,
        characterName,
        client,
        realmName,
        realmID,
        faction,
        race,
        class,
        guild,
        zoneName,
        level,
        gameText,
        broadcastText,
        broadcastTime,
        canSoR,
        toonID,
        bnetIDAccount,
        isGameAFK,
        isGameBusy = BNGetGameAccountInfo(bnetIDGameAccount)

    local classc = FriendColor_ClassColor(class)
    if not classc then
        return
    end

    local index = i-friendOffset+numOnline

    local nameString = _G["FriendsFrameFriendsScrollFrameButton" .. (index) .. "Name"]
    if nameString then
        nameString:SetText(accountName .. " (" .. characterName .. ", L" .. level .. ")")
        nameString:SetTextColor(classc.r, classc.g, classc.b)
    end

    if CanCooperateWithGameAccount(toonID) ~= true then
        local nameString = _G["FriendsFrameFriendsScrollFrameButton" .. (index) .."Info"]
        if nameString then
            nameString:SetText(zoneName .. " (" .. realmName .. ")")
        end
    end
end

local function FriendColor_Friend(i, friendOffset)
    local friendInfo = C_FriendList.GetFriendInfoByIndex(i)

    if friendInfo.connected == false then
        return
    end

    local classc = FriendColor_ClassColor(friendInfo.className)
    if not classc then
        return
    end

    local index = i-friendOffset

    local nameString = _G["FriendsFrameFriendsScrollFrameButton" .. (index) .. "Name"]
    if nameString and friendInfo.name then
        nameString:SetText(friendInfo.name .. ", L" .. friendInfo.level)
        nameString:SetTextColor(classc.r, classc.g, classc.b)
    end
end

local function GuildColor_Class(i, numGuildOnline)
    local name,
        rankName,
        rankIndex,
        level,
        classDisplayName,
        zone,
        publicNote,
        officerNote,
        isOnline,
        status,
        class,
        achievementPoints,
        achievementRank,
        isMobile,
        canSoR,
        repStanding,
        GUID = GetGuildRosterInfo(i)

    local classc = FriendColor_ClassColor(class)
    if not classc then
        return
    end

    index = i + numGuildOnline

    local nameString = _G["GuildFrameButton" .. (i) .. "Name"]
    if nameString and name then
        nameString:SetTextColor(classc.r, classc.g, classc.b)
    end

    local classString = _G["GuildFrameButton" .. (i) .. "Class"]
    if classString and name then
        classString:SetTextColor(classc.r, classc.g, classc.b)
    end
end

local function GuildColor_Class()
    local playerzone = GetRealZoneText()
    local off = FauxScrollFrame_GetOffset(GuildListScrollFrame)

    for i=1, GUILDMEMBERS_TO_DISPLAY, 1 do
        local name, _, _, level, class, zone, _, _, online = GetGuildRosterInfo(off + i)

        if name then
            if class then
                local classc = FriendColor_ClassColor(class)
                if online then
                    _G['GuildFrameGuildStatusButton' .. i .. 'Name']:SetTextColor(classc.r, classc.g, classc.b)
                    local onlineString = _G['GuildFrameGuildStatusButton' .. i .. 'Online']
                    if onlineString then
                        if onlineString:GetText() == 'Online' then
                            onlineString:SetTextColor(.5, 1, 1, 1)
                        end
                        if onlineString:GetText() == '<AFK>' then
                            onlineString:SetTextColor(1, 1, .4)
                        end
                    end
                    -- Online
                    -- Rank
                    local nameString = _G["GuildFrameButton" .. (i) .. "Name"]
                    if nameString and name then
                        nameString:SetTextColor(classc.r, classc.g, classc.b)
                    end

                    local classString = _G["GuildFrameButton" .. (i) .. "Class"]
                    if classString and name then
                        classString:SetTextColor(classc.r, classc.g, classc.b)
                    end
                else
                    _G['GuildFrameGuildStatusButton' .. i .. 'Name']:SetTextColor(classc.r, classc.g, classc.b, .5)
                    local nameString = _G["GuildFrameButton" .. (i) .. "Name"]
                    if nameString and name then
                        nameString:SetTextColor(classc.r, classc.g, classc.b, .5)
                    end

                    local classString = _G["GuildFrameButton" .. (i) .. "Class"]
                    if classString and name then
                        classString:SetTextColor(classc.r, classc.g, classc.b, .5)
                    end
                end
            end

            if level then
            end

            if zone and zone == playerzone then
                if online then
                    _G["GuildFrameButton" .. i .. "Zone"]:SetTextColor(.5, 1, 1, 1)
                else
                    _G["GuildFrameButton" .. i .. "Zone"]:SetTextColor(.5, 1, 1, .5)
                end
            end
        end
    end
end

local function FriendColor_GetFriendOffset()
    local friendOffset = HybridScrollFrame_GetOffset(FriendsFrameFriendsScrollFrame)
    if not friendOffset then
        friendOffset = 0
    end
    if friendOffset < 0 then
        friendOffset = 0
    end
    return friendOffset
end

local function WhoColor_Class()
    for i = 1, _G.WHOS_TO_DISPLAY do
        _G["WhoFrameButton" .. i .. "Variable"]:SetTextColor(1, 1, 1)
    end

    do
        local button, level, name, class
        local whoIndex
        local whoOffset = FauxScrollFrame_GetOffset(WhoListScrollFrame)
        local columnTable

        for i = 1, _G.WHOS_TO_DISPLAY do
            whoIndex = whoOffset + i
            button = _G['WhoFrameButton' .. i]
            level = _G['WhoFrameButton' .. i .. 'Level']
            name = _G['WhoFrameButton' .. i .. 'Name']
            class = _G['WhoFrameButton' .. i .. 'Class']
            variableText = _G["WhoFrameButton" .. i .. "Variable"]

            local info = C_FriendList.GetWhoInfo(whoIndex)
            if info then
                guild = info.fullGuildName
                name = info.fullName
                class = info.classStr
                zone = info.area
                race = info.raceStr

                local classc = FriendColor_ClassColor(class)
                local nameString = _G['WhoFrameButton' .. i .. 'Name']
                nameString:SetTextColor(classc.r, classc.g, classc.b)
                local selectedID = UIDropDownMenu_GetSelectedID(WhoFrameDropDown)

                if selectedID == 1 then
                    local playerzone = GetRealZoneText()
                    if zone and zone == playerzone then
                        _G["WhoFrameButton" .. i .. "Variable"]:SetTextColor(.5, 1, 1, 1)
                    end
                elseif selectedID == 2 then
                    local playerGuild = GetGuildInfo("player")
                    if guild and guild == playerGuild then
                        _G["WhoFrameButton" .. i .. "Variable"]:SetTextColor(.5, 1, 1, 1)
                    end
                else
                    local playerRace = UnitRace("player")
                    if race and race == playerRace then
                        _G["WhoFrameButton" .. i .. "Variable"]:SetTextColor(.5, 1, 1, 1)
                    end
                end
            end
        end
    end
end

local function FriendColor_Hook_FriendsList_Update()
    local friendOffset = FriendColor_GetFriendOffset()
    local numBNetTotal, numBNetOnline = BNGetNumFriends()
    -- Online WoW friends
    local numFriends = C_FriendList.GetNumFriends() or 0
    local numOnline = C_FriendList.GetNumOnlineFriends() or 0
    local off = FauxScrollFrame_GetOffset(GuildListScrollFrame)
    local playerzone = GetRealZoneText()
    local numTotalGuildMembers,
        numOnlineGuildMembers,
        numOnlineAndMobileMembers = GetNumGuildMembers()
    local numWhos,
        totalNumWhos = C_FriendList.GetNumWhoResults()

    if numOnline > 0 then
        for i=1, numOnline, 1 do
            FriendColor_Friend(i, friendOffset)
        end
    end

    -- Online Battlenet Friends
    if numBNetOnline > 0 then
        for i=1, 1+numBNetOnline, 1 do
            FriendColor_BNetFriend(i, friendOffset, numOnline)
        end
    end

    if numOnlineGuildMembers > 0 then
        for i=1, numOnlineGuildMembers, 1 do
            GuildColor_Class()
        end
    end
end
hooksecurefunc("FriendsList_Update", FriendColor_Hook_FriendsList_Update)
hooksecurefunc("HybridScrollFrame_Update", FriendColor_Hook_FriendsList_Update)
hooksecurefunc("GuildStatus_Update", FriendColor_Hook_FriendsList_Update)
hooksecurefunc("WhoList_Update", FriendColor_Hook_FriendsList_Update)
