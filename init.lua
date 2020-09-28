aura_env.debug = function(string)
    if aura_env.config.debug then
        print(string)
    end
end

aura_env.isItemInList = function(itemId, name)
    local items = aura_env.config.items
    if not items then
        return false
    end
    
    for i, v in ipairs(items) do
        if v and v.value and (v.value == itemId or v.value == name) then
            aura_env.debug("Found item in list for either itemId: ".. itemId .." or name: ".. name)
            return true
        end
    end
    
    return false
end

aura_env.createMessageTemplate = function(lootMessageTemplate)
    return string.match(lootMessageTemplate, "%s[%D ]+:%s")
end

aura_env.receivingTemplate = aura_env.createMessageTemplate(LOOT_ITEM)
aura_env.debug("Receiving loot template: \""..aura_env.receivingTemplate.."\"")