-- Ouch - Client side mod for Minetest
-- Scripted by: RB

local modname = minetest.get_current_modname()
local heartbeat = false     -- Always start false
local handle

-- Configurable
-- Integer, at what hp value to enable the life_alert triggering the heartbeat sound.
local life_alert = 15
-- End Configurable

minetest.register_on_mods_loaded(function()
    minetest.display_chat_message("Ouch mod loaded. May the sound be with you!")
    return false
end)

function is_player_in_air()
    local pos = minetest.localplayer:get_pos()
    local my_node = minetest.get_node_or_nil(pos)
    local node_name = my_node and my_node.name or "ignore"
    --minetest.display_chat_message("Node name: " .. node_name)
    if node_name == "air" then
            return true
    end
    return false
end

minetest.register_on_damage_taken(function(hp)
    if is_player_in_air() == false then
        minetest.sound_play("ouch_drowning", {gain = 0.9})
        minetest.display_chat_message("GET OUT OF THE WATER!")
    else
        local n = math.random(1,2)
        if n == 1 then
            minetest.sound_play("ouch_ouch", {gain = 0.9})
            minetest.display_chat_message("OUCH!")
        elseif n == 2 then
            minetest.sound_play("ouch_scream", {gain = 0.9})
            minetest.display_chat_message("AAAH!")
        end
    end
    return false
end)

minetest.register_on_hp_modification(function(hp)
    --minetest.display_chat_message("Heartbeat: " .. tostring(heartbeat))
    if heartbeat == true then
        --minetest.display_chat_message("Handle: " .. handle)
        if hp >= life_alert then
            --minetest.sound_stop(handle)
            local step = 1
            local gain = 0
            minetest.sound_fade(handle, step, gain)
            heartbeat = false
        end
    else
        if (hp < life_alert and heartbeat == false) then
            heartbeat = true
            handle = minetest.sound_play("ouch_heartbeat", {
                gain = 0.9,
                loop = true
            })
        end
    end
    return false
end)

minetest.register_on_death(function()
    minetest.display_chat_message("...")
    minetest.sound_play("ouch_death", {gain = 0.5})
    return false
end)

minetest.register_on_item_use(function(item, pointed_thing)
    minetest.sound_play("ouch_whoosh", {gain = 0.5})
    return false
end)

minetest.register_on_inventory_open(function(inventory)
    minetest.sound_play("ouch_inventory", {gain = 0.5})
    minetest.display_chat_message("Formspec clicked.")
    return false
end)
