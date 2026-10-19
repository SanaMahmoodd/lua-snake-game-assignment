local Events = {}

local listeners = {}

-- Register a listener for an event
function Events:subscribe(event, callback)
    if not listeners[event] then
        listeners[event] = {}
    end

    table.insert(listeners[event], callback)
end

-- Notify all listeners of an event
function Events:emit(event, data)
    local callbacks = listeners[event]

    if not callbacks then
        return
    end

    for _, callback in ipairs(callbacks) do
        callback(data)
    end
end

return Events