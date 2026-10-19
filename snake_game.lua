local Entity = require("entity")
local Vector2 = require("vector2")
local HighScore = require("highscore")
local Events = require("events")

local SnakeGame = {}
SnakeGame.__index = SnakeGame

local GRID = 20
local CELL = 30
local MOVE_DELAY = 0.20

local function drawSparkle(x, y, size)
    love.graphics.setColor(Colors.sparkle[1], Colors.sparkle[2], Colors.sparkle[3], 0.85)
    love.graphics.setLineWidth(1.5)

    love.graphics.line(x - size, y, x + size, y)
    love.graphics.line(x, y - size, x, y + size)
    love.graphics.line(x - size * 0.6, y - size * 0.6, x + size * 0.6, y + size * 0.6)
    love.graphics.line(x - size * 0.6, y + size * 0.6, x + size * 0.6, y - size * 0.6)
end

local function drawGrid(size)
    love.graphics.setColor(Colors.grid)
    for i = 0, 20 do
        love.graphics.line(i * size, 0, i * size, 600)
        love.graphics.line(0, i * size, 600, i * size)
    end
end

-- Create a new snake game
function SnakeGame:new()
    local game = setmetatable({
        snake = {
            {x = 5, y = 10},
            {x = 4, y = 10},
            {x = 3, y = 10}
        },
        direction = Vector2:new(1, 0),
        nextDirection = Vector2:new(1, 0),
        food = nil,
        score = 0,
        highScore = HighScore:load(),
        gameOver = false,
        timer = 0,
        entity = Entity:new()
    }, SnakeGame)

    game.entity:addComponent("position", {
        x = 5, y = 10
    })

    game.entity:addComponent("movement", {
        dx = 1, dy = 0
    })

    game.entity:addComponent("renderer", {
        color = {0.3, 0.9, 0.4},
        size = CELL
    })

    game:spawnFood()
    return game
end

-- Spawn food in a free random cell
function SnakeGame:spawnFood()
    local emptyCells = {}

    for y = 0, GRID - 1 do
        for x = 0, GRID - 1 do
            local occupied = false

            for _, segment in ipairs(self.snake) do
                if segment.x == x and segment.y == y then
                    occupied = true
                    break
                end
            end

            if not occupied then
                table.insert(emptyCells, {x = x, y = y})
            end
        end
    end

    if #emptyCells == 0 then
        self.food = nil
        self.gameOver = true
        return
    end

    self.food = emptyCells[
        love.math.random(#emptyCells)
    ]
end

-- Change snake direction
function SnakeGame:changeDirection(dx, dy)
    if self.gameOver then return end

    if math.abs(dx) + math.abs(dy) ~= 1 then
        return
    end

    -- Prevent reverse movement
    if dx == -self.direction.x
        and dy == -self.direction.y then
        return
    end

    self.nextDirection = Vector2:new(dx, dy)
end

-- Move the snake one cell
function SnakeGame:move()
    self.direction = self.nextDirection

    local movement =
        self.entity:getComponent("movement")

    movement.dx = self.direction.x
    movement.dy = self.direction.y

    local position =
        self.entity:getComponent("position")

    local newPosition =
        Vector2:new(position.x, position.y)
        + self.direction

    local x = newPosition.x
    local y = newPosition.y

    -- Wall collision
    if x < 0 or x >= GRID
        or y < 0 or y >= GRID then
        self.gameOver = true
        return
    end

    local eating = self.food
        and x == self.food.x
        and y == self.food.y

    -- Check self collision
    local checkUntil = eating
        and #self.snake
        or #self.snake - 1

    for i = 1, checkUntil do
        local segment = self.snake[i]

        if segment.x == x and segment.y == y then
            self.gameOver = true
            return
        end
    end

    -- Add new head
    table.insert(self.snake, 1, {x = x, y = y})

    position.x = x
    position.y = y

    if eating then
        self.score = self.score + 1

        -- Save high score
        if self.score > self.highScore then
            local saved = HighScore:save(self.score)

            if saved then
                self.highScore = self.score
            end
        end

        -- Bonus: Notify listeners when food is eaten
        Events:emit("food_eaten", {
            score = self.score
        })

        self:spawnFood()
    else
        -- Remove tail if no food was eaten
        table.remove(self.snake)
    end
end

-- Update game movement
function SnakeGame:update(dt)
    if self.gameOver then return end

    self.timer = self.timer + dt

    while self.timer >= MOVE_DELAY
        and not self.gameOver do
        self.timer = self.timer - MOVE_DELAY
        self:move()
    end
end

-- Draw snake, food and score
function SnakeGame:draw()
    local renderer = self.entity:getComponent("renderer")
    local size = renderer.size

    love.graphics.clear(Colors.bg)

    -- grid background
    drawGrid(size)

    -- top info panel
    love.graphics.setColor(Colors.panel)
    love.graphics.rectangle("fill", 10, 8, 240, 34, 10, 10)

    love.graphics.setFont(Fonts.body)
    love.graphics.setColor(Colors.text)
    love.graphics.print(
        "Score: " .. self.score .. "   High Score: " .. self.highScore,
        20, 17
    )

    -- Draw food
    if self.food then
        love.graphics.setColor(Colors.food[1], Colors.food[2], Colors.food[3], 0.28)
        love.graphics.circle(
            "fill",
            self.food.x * size + size / 2,
            self.food.y * size + size / 2,
            13
        )

        love.graphics.setColor(Colors.food)
        love.graphics.circle(
            "fill",
            self.food.x * size + size / 2,
            self.food.y * size + size / 2,
            9
        )

        drawSparkle(
            self.food.x * size + size / 2 + 10,
            self.food.y * size + size / 2 - 10,
            4
        )
    end

    -- Draw snake
    for i, segment in ipairs(self.snake) do
        if i == 1 then
            love.graphics.setColor(Colors.snakeHead)
        else
            love.graphics.setColor(Colors.snake)
        end

        love.graphics.rectangle(
            "fill",
            segment.x * size + 2,
            segment.y * size + 2,
            size - 4,
            size - 4,
            8, 8
        )
    end

    -- tiny sparkles near top area
    drawSparkle(565, 26, 5)
    drawSparkle(535, 48, 4)

    -- Game Over popup
    if self.gameOver then
        love.graphics.setColor(0, 0, 0, 0.55)
        love.graphics.rectangle("fill", 0, 0, 600, 600)

        love.graphics.setColor(Colors.panel)
        love.graphics.rectangle("fill", 130, 200, 340, 180, 18, 18)

        love.graphics.setColor(Colors.panelSoft)
        love.graphics.rectangle("fill", 145, 215, 310, 150, 14, 14)

        love.graphics.setFont(Fonts.title)
        love.graphics.setColor(Colors.text)
        love.graphics.printf("GAME OVER", 0, 225, 600, "center")

        love.graphics.setFont(Fonts.body)
        love.graphics.setColor(Colors.muted)
        love.graphics.printf("Score: " .. self.score, 0, 280, 600, "center")
        love.graphics.printf("Press R to restart", 0, 310, 600, "center")
        love.graphics.printf("Press ESC for menu", 0, 335, 600, "center")

        drawSparkle(175, 235, 6)
        drawSparkle(425, 345, 6)
    end
end

return SnakeGame