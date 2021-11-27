
local function getOutputParameters(entity)
    local control_behavior = entity.main_entity.get_control_behavior()
    local red = control_behavior.get_circuit_network(defines.wire_type.red, defines.circuit_connector_id.combinator_input)
    local green = control_behavior.get_circuit_network(defines.wire_type.green, defines.circuit_connector_id.combinator_input)

    local control_mode = control_behavior.parameters.second_constant or 0    
    local input = {}
    if (green and green.signals) then
        for _, signal in pairs(green.signals) do
            table.insert(input, signal)
        end
    end
    if (red and red.signals) then
        for _, signal in pairs(red.signals) do
            table.insert(input, signal)
        end
    end

    
    table.sort(input, function(a, b) return a.count > b.count end)
    

    local parameters = {}
    local index = 1
    for _, signal in pairs(input) do
        if index > control_mode then
            break
        end
        parameters[index] = { index = index, signal = signal.signal, count = signal.count }
        index = index + 1
    end    
    
    return parameters
end

local function onTick(e)
	for _, entity in pairs(global.entities) do
        if 
            entity.main_entity
            and entity.main_entity.valid
            and entity.main_entity.active
            and entity.output_entity
            and entity.output_entity.valid
        then
            if  entity.main_entity.status == defines.entity_status.no_power or
                entity.main_entity.status == defines.entity_status.low_power
            then
                entity.output_entity.get_control_behavior().parameters = nil
            else
                entity.output_entity.get_control_behavior().parameters = getOutputParameters(entity)                
            end
        end
    end
end

script.on_event(defines.events.on_tick, onTick)
