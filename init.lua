-- Ouch - Client Side Mod

local modname = minetest.get_current_modname()
local heartbeat = false
local handle

function immortal()
    minetest.send_chat_message("/immortal")
    minetest.display_chat_message("Immortal!")
end

minetest.register_on_mods_loaded(function()
    minetest.after(60.0, immortal)
    return false
end)

function is_player_in_air()
	pos = minetest.localplayer:get_pos()
    local my_node = minetest.get_node_or_nil(pos)
    local node_name = my_node and my_node.name or "ignore"
    minetest.display_chat_message("Node name: " .. node_name)
	if node_name == "air" then
		return true
	end
	return false
end

minetest.register_on_damage_taken(function(hp)
    if is_player_in_air() == false then
        minetest.sound_play("drowning", {gain = 0.9})
        minetest.display_chat_message("DROWNING!")
    else
        local n = math.random(1,2)
        if n == 1 then
            -- https://en.wiktionary.org/wiki/File:en-us-inlandnorth-ouch.ogg
            minetest.sound_play("ouch", {gain = 0.9})
            minetest.display_chat_message("OUCH!")
        elseif n == 2 then
            -- https://bigsoundbank.com/detail-0477-wilhelm-scream.html
            minetest.sound_play("scream", {gain = 0.9})
            minetest.display_chat_message("AHHH!")
        end
    end
    return false
end)

minetest.register_on_hp_modification(function(hp)
    --minetest.display_chat_message("Heartbeat: " .. tostring(heartbeat))
    if heartbeat == true then
        --minetest.display_chat_message("Handle: " .. handle)
        if hp >= 15 then
            --minetest.sound_stop(handle)
            local step = 1
            local gain = 0
            minetest.sound_fade(handle, step, gain)
            heartbeat = false
        end
    else
        if (hp < 15 and heartbeat == false) then
            heartbeat = true
            -- https://bigsoundbank.com/detail-1930-heart-beat-5.html
            handle = minetest.sound_play("heartbeat", {
                gain = 0.9,
                loop = true
            })
        end
    end
    return false
end)

minetest.register_on_death(function()
    -- https://bigsoundbank.com/detail-1640-strangled-man-2.html
    minetest.display_chat_message("...")
    minetest.sound_play("death", {gain = 0.5})
    return false
end)

minetest.register_on_item_use(function(item, pointed_thing)
    local n = math.random(1,7)
    if n == 1 then
        -- https://bigsoundbank.com/detail-1795-whoosh-3.html
        minetest.sound_play("whoosh3", {gain = 0.5})
    elseif n == 2 then
        -- https://bigsoundbank.com/detail-1796-whoosh-4.html
        minetest.sound_play("whoosh4", {gain = 0.5})
    elseif n == 3 then
        -- https://bigsoundbank.com/detail-1797-whoosh-5.html
        minetest.sound_play("whoosh5", {gain = 0.5})
    elseif n == 4 then
        -- https://bigsoundbank.com/detail-1799-whoosh-6.html
        minetest.sound_play("whoosh6", {gain = 0.5})
    elseif n == 5 then
        -- https://bigsoundbank.com/detail-1800-whoosh-7.html
        minetest.sound_play("whoosh7", {gain = 0.5})
    elseif n == 6 then
        -- https://bigsoundbank.com/detail-1802-whoosh-9.html
        minetest.sound_play("whoosh9", {gain = 0.5})
    elseif n == 7 then
        -- https://bigsoundbank.com/detail-1798-whoosh-10.html
        minetest.sound_play("whoosh10", {gain = 0.5})
    end
    return false
end)

-- This part needs work; no erros, but no result.
minetest.register_on_formspec_input(function(formname, fields)
    -- https://bigsoundbank.com/detail-2191-thermostat-1.html
    minetest.sound_play("click", {gain = 0.5})
    minetest.display_chat_message("Formspec clicked.")
    return false
end)

-- * `minetest.register_on_formspec_input(function(formname, fields))`
--     * Called when a button is pressed in the local player's inventory form
--     * Newest functions are called first
--     * If function returns `true`, remaining functions are not called

-- minetest.register_on_craft(function(itemstack, player, old_craft_grid, craft_inv) -- a nil value
--     -- https://bigsoundbank.com/detail-2191-thermostat-1.html
--     minetest.sound_play("click", {gain = 0.5})
--     minetest.display_chat_message("Formspec clicked.")
--     return false
-- end)
