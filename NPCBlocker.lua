NPCBlocker = LibStub("AceAddon-3.0"):NewAddon("NPCBlocker", "AceConsole-3.0")

local myOptions = {
    name = "Status",
    handler = NPCBlocker,
    type = 'group',
    args = {
        msg = {
            type = 'toggle',
            name = 'Enabled',
            desc = 'if the addon is enabled of not',
            set = 'SetStatus',
        },
    },
}

local AceConfig = LibStub("AceConfig-3.0")
AceConfig:RegisterOptionsTable("NPCBlocker", myOptions)

function NPCBlocker:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("NPCBlockerDB")
end

function NPCBlocker:SetStatus(info, input)
  self.db.char.info = value   -- we use the db names in our settings for Zzz
  NPCBlocker:Print("The " .. info .. " was set to: " .. tostring(value) )
end

NPCBlocker:RegisterChatCommand("npcblock", "ToggleStatus")

function NPCBlocker:ToggleStatus(input)
	if self.db.char.NPCBlocker_Status == true then
	    self.db.char.NPCBlocker_Status = false;
		NPCBlocker:Print("Ace3: NPC Blocker is now off.");
	else
		self.db.char.NPCBlocker_Status = true;
		NPCBlocker:Print("Ace3: NPC Blocker is now on.");
	end
end

-- OLD CODE HERE

-- frame and register events
local frame, events = CreateFrame("FRAME"), {}; -- Need a frame to respond to events

-- Topper McNabb

-- If not set, set the addon status to on
if NPCBlocker_Status == nil then
    NPCBlocker_Status = true;
--    self.db.char.NPCBlocker_Status = true;
end
-- Functions Section
function events:ADDON_LOADED()
 if arg1 == "NPCBlocker_Status" then
  -- Our saved variables are ready at this point. If there are none, both variables will set to nil.
  NPCBlocker:Print("NPC Blocker Loaded.");
 end
end
local function NPCBlocker__ChannelMsgFilter(self, event, msg, author, ...)
  if author == "Topper McNabb" then
    return true
  end
  if author == "Morris Lawry" then
    return true
  end
  if event == "CHAT_MSG_YELL" then
    return true
  end
end

frame:SetScript("OnEvent", function(self, event, ...)
 events[event](self, ...); -- call one of the functions above
end);
for k, v in pairs(events) do
 frame:RegisterEvent(k); -- Register all events for which handlers have been defined
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_SAY", NPCBlocker__ChannelMsgFilter);
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", NPCBlocker__ChannelMsgFilter);
