SLASH_NPCBLOCKER1 = '/npcblock';

local function ToggleStatus(opcode, editbox)
	if npcBlockerStatus == true then
	    npcBlockerStatus = false;
		print("NPC Blocker is now off.");
	else
        	npcBlockerStatus = true;
		print("NPC Blocker is now on.");
	end
end

--------------------------------

SLASH_HELLOWORLD1, SLASH_HELLOWORLD2 = '/hiw', '/hellow';
local function handler(msg, editBox)
    if msg == 'bye' then
        print('Goodbye, World!')
    else
        print("Hello, World!")
    end
end
SlashCmdList["HELLOWORLD"] = handler; -- Also a valid assignment strategy

--------------------------

SlashCmdList["NPCBLOCKER"] = ToggleStatus; -- Also a valid assignment strategy


-- OLD CODE HERE

-- frame and register events
local frame, events = CreateFrame("FRAME"), {}; -- Need a frame to respond to events

-- Topper McNabb

-- If not set, set the addon status to on
if npcBlockerStatus == nil then
    npcBlockerStatus = true;
end
-- Functions Section
function events:ADDON_LOADED()
 if arg1 == "npcBlockerStatus" then
  -- Our saved variables are ready at this point. If there are none, both variables will set to nil.
  print("NPC Blocker Loaded.");
 end
end
local function npcBlocker__ChannelMsgFilter(self, event, msg, author, ...)
    -- Block says from npcs  
    if author == "Topper McNabb" then return true
        elseif author == "Morris Lawry" then return true
  
        -- Celestial court noodle vendors
        elseif author == "Brother Noodle" then return true
        elseif author == "Great Chief Woo" then return true
        elseif author == "Sapmaster Vu" then return true
        elseif author == "Healthminder Diago" then return true
        elseif author == "Master Mian Tiao" then return true
        elseif author == "Noodle-Maker Monmon" then return true
        elseif author == "Brewmaster Tzu" then return true
        elseif author == "Big Dan Stormstout" then return true
        elseif author == "Galu Wellspring" then return true
        elseif author == "Grimhorn Redbeard" then return true
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

ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_SAY", npcBlocker__ChannelMsgFilter);
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", npcBlocker__ChannelMsgFilter);
