local HighScore = {}

local FILE_NAME = "highscore54.txt"

function HighScore:save(score)
    local oldScore = self:load()

    if score <= oldScore then
        return false
    end

    -- Lua 5.4: <close> automatically closes the file.
    local file <close> = assert(io.open(FILE_NAME, "w"))

    file:write(tostring(score))
    return true
end

function HighScore:load()
    -- Lua 5.4 to-be-closed variable
    local file <close> = io.open(FILE_NAME, "r")

    if file then
        local content = file:read("*a")
        return tonumber(content) or 0
    end

    return 0
end

return HighScore