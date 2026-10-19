local Input = {}
Input.__index = Input

function Input:new()
    local input = {
        commands = {}
    }

    return setmetatable(input, Input)
end

-- Bind a keyboard key to a command
function Input:bind(key, command)
    self.commands[key] = command
end

-- Execute the command assigned to a key
function Input:handleKey(key)
    local command = self.commands[key]

    if command then
        command()
    end
end

return Input