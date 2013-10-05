-- create a frame to listen to the chat events
local frame, events = CreateFrame("FRAME"), {};

-- this is the chat filter that hides the chat messages we don't want.
local function npcBlocker__ChannelMsgFilter(self, event, msg, author, ...)
    -- Block says from npcs  
    if author == "Topper McNabb" then return true
        elseif author == "Morris Lawry" then return true
  
        -- Celestial court noodle vendors
        elseif author == "Brother Noodle" then return true
        elseif author == "Great Chef Woo" then return true
        elseif author == "Sapmaster Vu" then return true
        elseif author == "Hearthminder Diago" then return true
        elseif author == "Master Miantiao" then return true
        elseif author == "Noodle-Maker Monmon" then return true
        elseif author == "Brewmaster Tzu" then return true
        elseif author == "Big Dan Stormstout" then return true
        elseif author == "Galu Wellspring" then return true
        elseif author == "Grimthorn Redbeard" then return true
        elseif author == "Crafter Kwon" then return true
        elseif author == "Smiling Jade" then return true
        elseif author == "Graceful Swan" then return true
        elseif author == "Drix Blackwrench" then return true

        -- Block all yells from players
        elseif event == "CHAT_MSG_YELL" then return true
    end
end

frame:SetScript("OnEvent", function(self, event, ...)
 events[event](self, ...); -- call one of the functions above
end);
for k, v in pairs(events) do
 frame:RegisterEvent(k); -- Register all events for which handlers have been defined
end

-- has the addon ever been run? if not, set the addon status to on
if npcBlockerStatus == nil then
    npcBlockerStatus = true;
end

-- has the addon been loaded?
function events:ADDON_LOADED()
 if arg1 == "npcBlockerStatus" then
  -- Our saved variables are ready at this point. If there are none, both variables will set to nil.
  print("NPC Blocker Loaded.");
 end
end

-- add chat filter for npc says
ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_SAY", npcBlocker__ChannelMsgFilter);
-- add chat filter for player yells
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", npcBlocker__ChannelMsgFilter);

-- create the slash command
SLASH_NPCBLOCKER1 = '/npcblock';

-- function to turn npcBlocker on and off
local function ToggleStatus(opcode, editbox)
    if npcBlockerStatus == true then
        npcBlockerStatus = false;
        -- add chat filter for npc says
        ChatFrame_RemoveMessageEventFilter("CHAT_MSG_MONSTER_SAY", npcBlocker__ChannelMsgFilter);
        -- add chat filter for player yells
        ChatFrame_RemoveMessageEventFilter("CHAT_MSG_YELL", npcBlocker__ChannelMsgFilter);
        print("NPC Blocker is now off.");
    else
       	npcBlockerStatus = true;
        -- add chat filter for npc says
        ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_SAY", npcBlocker__ChannelMsgFilter);
        -- add chat filter for player yells
        ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", npcBlocker__ChannelMsgFilter);
	print("NPC Blocker is now on.");
    end
end

-- assign slash command to the handler function
SlashCmdList["NPCBLOCKER"] = ToggleStatus; -- Also a valid assignment strategy



