function(states, event, message)
    if not message then
        return false
    end
    
    local index = string.find(message, aura_env.receivingTemplate)
    if not index then
        return false
    end
    
    local playerName = strsub(message, 0, index - 1)
    local item = strsub(message, index + strlen(aura_env.receivingTemplate))
    local itemId = select(3, strfind(item, "item:(%d+)"))
    local name,_,quality,_,_,type,subType,_,_,_,_,_,_,bindType = GetItemInfo(itemId)
    aura_env.debug("Who: "..playerName)
    aura_env.debug("Item: "..item)
    aura_env.debug("ItemId: "..itemId)
    aura_env.debug("ItemName: "..name)
    
    local itemInList = aura_env.isItemInList(itemId, name)
    
    if itemInList then
        if aura_env.config.needToWrite then
            aura_env.debug("Writing to "..playerName.." PM with \""..aura_env.config.message.."\"")
            SendChatMessage(aura_env.config.message, "WHISPER", nil, playerName)
        end
        
        states["player"] = {
            name = "Snatch detected\n"..WA_ClassColorName(playerName),
            duration = 5,
            expirationTime = GetTime() + 5,
            progressType = "timed",
            autoHide = true,
            unit = "player",
            show = true,
            changed = true
        }
        return true
    end
    
    return false
end