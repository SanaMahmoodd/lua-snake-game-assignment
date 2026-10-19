local HighScore = {}

local FILE_NAME = "highscore.txt"

-- LÖVE uses LuaJIT, so Lua 5.4's <close>
-- syntax is not supported here.
-- love.filesystem manages opening and closing files.

function HighScore:save(score)
    local oldScore = self:load()

    if score <= oldScore then
        return true
    end

    local success, message =
        love.filesystem.write(FILE_NAME, tostring(score))

    return success, message
end

function HighScore:load()
    local content = love.filesystem.read(FILE_NAME)

    return tonumber(content) or 0
end

return HighScore