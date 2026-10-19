local SnakeGame = require("snake_game")

local PlayingState = {
    game = nil
}

function PlayingState:restart()
    self.game = SnakeGame:new()
end

function PlayingState:update(dt)
    if self.game then
        self.game:update(dt)
    end
end

function PlayingState:draw()
    if self.game then
        self.game:draw()
    end
end

function PlayingState:changeDirection(dx, dy)
    if self.game then
        self.game:changeDirection(dx, dy)
    end
end

return PlayingState