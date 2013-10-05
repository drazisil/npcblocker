-- create a frame to listen to game events
local mainFrame, mainFrameEvents = CreateFrame("FRAME"), {};

--------------------------------------------------------------------------------
-- Initialize the npcSay table
local function tblNpcSay_Init()

    -- Create the table to hold the npcs we want to block says for
    tblNpcSay = {};

    -- Populate the tblNpcSay table

    -- Block says from npcs  
    table.insert(tblNpcSay, "Topper McNabb");
    table.insert(tblNpcSay, "Morris Lawry");
  
    -- Celestial court noodle vendors
    table.insert(tblNpcSay, "Brother Noodle");
    table.insert(tblNpcSay, "Great Chef Woo");
    table.insert(tblNpcSay, "Sapmaster Vu");
    table.insert(tblNpcSay, "Hearthminder Digao");
    table.insert(tblNpcSay, "Master Miantiao");
    table.insert(tblNpcSay, "Noodle-Maker Monmon");
    table.insert(tblNpcSay, "Brewmaster Tzu");
    table.insert(tblNpcSay, "Big Dan Stormstout");
    table.insert(tblNpcSay, "Galu Wellspring");
    table.insert(tblNpcSay, "Grimthorn Redbeard");
    table.insert(tblNpcSay, "Crafter Kwon");
    table.insert(tblNpcSay, "Smiling Jade");
    table.insert(tblNpcSay, "Graceful Swan");
    table.insert(tblNpcSay, "Drix Blackwrench");

end

function npcBlocker__dumpDB()

   for i,npc in ipairs(tblNpcSay) do
        print(npc);
   end
end

function npcBlocker__reloadDB()

    tblNpcSay = nil;
    tblNpcSay_Init()
end


-- this is the chat filter that hides the chat messages we don't want.
function npcBlocker__ChannelMsgFilterNPCSay(self, event, msg, author, ...)
    -- print the lines
    for i,npc in ipairs(tblNpcSay) do
        if author == npc then 
            return true
        end
    end
    -- Block all yells from players
    if event == "CHAT_MSG_YELL" then return true
    end
end

--------------------------------------------------------------------------------
-- ADDON_LOADED event handler
function mainFrameEvents:ADDON_LOADED(arg1)
    if arg1 == "npcBlocker" then
        if npcBlockerStatus == nil then
            npcBlockerStatus = true;
        end
        if tblNpcSay == nil then
            tblNpcSay_Init();
        end
        -- Our saved variables are ready at this point. If there are none, both variables will set to nil.
        print("NPC Blocker Loaded.");
    end
end

--------------------------------------------------------------------------------
-- Register defigned events
mainFrame:SetScript("OnEvent", function(self, event, ...)
 mainFrameEvents[event](self, ...); -- call one of the functions above
end);
for k, v in pairs(mainFrameEvents) do
 mainFrame:RegisterEvent(k); -- Register all events for which handlers have been defined
end

-- add chat filter for npc says
ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_SAY", npcBlocker__ChannelMsgFilterNPCSay);
-- add chat filter for player yells
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", npcBlocker__ChannelMsgFilterNPCSay);

--------------------------------------------------------------------------------
-- Slash command handler function
function npcBlocker__slashCmdHandler(opcode, editbox)
    if npcBlockerStatus == true then
        npcBlockerStatus = false;
        -- add chat filter for npc says
        ChatFrame_RemoveMessageEventFilter("CHAT_MSG_MONSTER_SAY", npcBlocker__ChannelMsgFilterNPCSay);
        -- add chat filter for player yells
        ChatFrame_RemoveMessageEventFilter("CHAT_MSG_YELL", npcBlocker__ChannelMsgFilterNPCSay);
        print("NPC Blocker is now off.");
    else
       	npcBlockerStatus = true;
        -- add chat filter for npc says
        ChatFrame_AddMessageEventFilter("CHAT_MSG_MONSTER_SAY", npcBlocker__ChannelMsgFilterNPCSay);
        -- add chat filter for player yells
        ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", npcBlocker__ChannelMsgFilterNPCSay);
	print("NPC Blocker is now on.");
    end
end

--------------------------------------------------------------------------------
-- Create the slash command
SLASH_NPCBLOCKER1 = '/npcblock';
SLASH_NPCBLOCKER_DUMP1 = '/npcblock_dump';
SLASH_NPCBLOCKER_RELOAD1 = '/npcblock_reload';

-- Assign slash command to the handler function
SlashCmdList["NPCBLOCKER"] = npcBlocker__slashCmdHandler;
SlashCmdList["NPCBLOCKER_DUMP"] = npcBlocker__dumpDB;
SlashCmdList["NPCBLOCKER_RELOAD"] = npcBlocker__reloadDB;



