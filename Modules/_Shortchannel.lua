-- Lets make it short
CHAT_SAY_GET = "[S] %s: "
CHAT_YELL_GET = "[Y] %s: "
CHAT_WHISPER_GET = "[F] %s: "
CHAT_WHISPER_INFORM_GET = "[T] %s: "

CHAT_FLAG_AFK = "[AFK] "
CHAT_FLAG_DND = "[DND] "
CHAT_FLAG_GM = "[GM] "

CHAT_MONSTER_PARTY_GET = CHAT_PARTY_GET
CHAT_MONSTER_SAY_GET = CHAT_SAY_GET
CHAT_MONSTER_WHISPER_GET = CHAT_WHISPER_GET
CHAT_MONSTER_YELL_GET = CHAT_YELL_GET

local gsub = gsub
local time = _G.time
local newAddMsg = {}

local rplc = {
    "[GEN]", --General
    "[T]",   --Trade
    "[WD]",  --WorldDefense
    "[LD]",  --LocalDefense
    "[LFG]", --LookingForGroup
    "[GR]",  --GuildRecruitment
    "[I]",   --Instance
    "[IL]",  --Instance Leader
    "[G]",   --Guild
    "[P]",   --Party
    "[PL]",  --Party Leader
    "[PL]",  --Party Leader (Guide)
    "[O]",   --Officer
    "[R]",   --Raid
    "[RL]",  --Raid Leader
    "[RW]",  --Raid Warning
    "[%1]",  --Custom Channels
}

local chn = {
    "%[%d0?%. General.-%]",
    "%[%d0?%. Trade.-%]",
    "%[%d0?%. WorldDefense%]",
    "%[%d0?%. LocalDefense.-%]",
    "%[%d0?%. LookingForGroup%]",
    "%[%d0?%. GuildRecruitment.-%]",
    gsub(CHAT_INSTANCE_CHAT_GET, ".*%[(.*)%].*", "%%[%1%%]"),
    gsub(CHAT_INSTANCE_CHAT_LEADER_GET, ".*%[(.*)%].*", "%%[%1%%]"),
    gsub(CHAT_GUILD_GET, ".*%[(.*)%].*", "%%[%1%%]"),
    gsub(CHAT_PARTY_GET, ".*%[(.*)%].*", "%%[%1%%]"),
    gsub(CHAT_PARTY_LEADER_GET, ".*%[(.*)%].*", "%%[%1%%]"),
    gsub(CHAT_PARTY_GUIDE_GET, ".*%[(.*)%].*", "%%[%1%%]"),
    gsub(CHAT_OFFICER_GET, ".*%[(.*)%].*", "%%[%1%%]"),
    gsub(CHAT_RAID_GET, ".*%[(.*)%].*", "%%[%1%%]"),
    gsub(CHAT_RAID_LEADER_GET, ".*%[(.*)%].*", "%%[%1%%]"),
    gsub(CHAT_RAID_WARNING_GET, ".*%[(.*)%].*", "%%[%1%%]"),
    -- Custom Channels
    "%[(%d0?)%. (.-)%]",
}

local AddMessage = function(frame, text, ...)
    for i = 1, 17 do
        text = gsub(text, chn[i], rplc[i])
    end
    -- Custom Channels
    text = gsub(text, "%[(%d0?)%. .-%]", "[%1]")
    return newAddMsg[frame:GetName()](frame, text, ...)
end

for i = 1, 10 do
    local fcl = _G[format("%s%d", "ChatFrame", i)]
    -- Skip Combat Log
    if i ~= 2 then
        newAddMsg[format("%s%d", "ChatFrame", i)] = fcl.AddMessage
        fcl.AddMessage = AddMessage
    end
end
