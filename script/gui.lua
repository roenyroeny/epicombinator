
local function on_gui_opened(e)
	if not (e.entity and e.entity.name == 'signal-filter-combinator') then return end
	
    if not getEntity(e.entity.unit_number) then return end
	
    local player = game.players[e.player_index]
    global.opened_entity[e.player_index] = e.entity.unit_number
    
    local gui_elements = {}
    local control_mode = e.entity.get_control_behavior().parameters.second_constant

    gui_elements.waypoint = "default"

    local frame = player.gui.screen.add{type="frame", caption={"gui.title"}, direction="vertical"}
    frame.force_auto_center()
    gui_elements.frame = frame

    local vertical_flow_1 = frame.add{type="frame", style="item_and_count_select_background", direction="horizontal"}
    vertical_flow_1.add{type="label", style="heading_2_label", caption={"gui.control-wire"}, tooltip={"gui.control-wire-tooltip"}}
    gui_elements.switch = vertical_flow_1.add{
        type="slider",
        name="control-wire-switch",
        horizontal_align="right",
        allow_none_state = false,
        minimum_value = 0,
        maximum_value = 10,
        value = control_mode,
        tooltip={"gui.control-wire-tooltip"}
    }

    gui_elements.text = vertical_flow_1.add{
        type="label",
        name="control-wire-text"
    }
    
    player.opened = frame
end

local function on_gui_closed(e)
    if not (e.element and global.opened_entity) then return end

    local unit_number = global.opened_entity[e.player_index]

    -- Check if the entity is owned by this mod
    if not getEntity(unit_number) then
        return
    end

    e.element.destroy()
    e.element = nil
    game.players[e.player_index].opened = nil
    global.opened_entity[e.player_index] = nil
end

local function on_gui_value_changed(e)

    local meep = e.element.parent
    if not (e.element and global.opened_entity) then return end

    local unit_number = global.opened_entity[e.player_index]
    if not (unit_number and getEntity(unit_number)) then return end

    local entity = getEntity(unit_number).main_entity
    if not entity.valid then return end

    local control_mode = entity.get_control_behavior().parameters.second_constant

    if not (entity and control_mode) then return end

    if e.element.name == "control-wire-text" then
    end

    if e.element.name == "control-wire-switch" then
        control_mode = e.element.slider_value
        meep.children[3].caption=""..e.element.slider_value
    end

    entity.get_control_behavior().parameters = {second_constant = control_mode}
end

script.on_event(defines.events.on_gui_opened, on_gui_opened)
script.on_event(defines.events.on_gui_closed, on_gui_closed)
script.on_event(defines.events.on_gui_value_changed, on_gui_value_changed)