local GameState = require("gamestate")
local Input = require("input")
local Events = require("events")
local lastEvent = "Waiting for food..."

local gameState
local input

-- Start a new game
local function startGame()
    local playing = gameState.states.playing

    playing:restart()
    gameState:switch("playing")
end

-- Send movement to the snake
local function moveSnake(dx, dy)
    if gameState.current == "playing" then
        local playing = gameState.states.playing
        playing:changeDirection(dx, dy)
    end
end

-- Configure keyboard commands
local function setupInput()
    input = Input:new()

    -- ENTER: Start the game
    input:bind("return", function()
        if gameState.current == "menu" then
            startGame()
        end
    end)

    -- ESC: Menu or Quit
    input:bind("escape", function()
        if gameState.current == "playing" then
            gameState:switch("menu")
        else
            love.event.quit()
        end
    end)

    -- R: Restart after Game Over
    input:bind("r", function()
        if gameState.current == "playing" then
            local playing = gameState.states.playing

            if playing.game
                and playing.game.gameOver then
                playing:restart()
            end
        end
    end)

    -- Arrow keys
    input:bind("up", function()
        moveSnake(0, -1)
    end)

    input:bind("down", function()
        moveSnake(0, 1)
    end)

    input:bind("left", function()
        moveSnake(-1, 0)
    end)

    input:bind("right", function()
        moveSnake(1, 0)
    end)

    -- WASD keys
    input:bind("w", function()
        moveSnake(0, -1)
    end)

    input:bind("s", function()
        moveSnake(0, 1)
    end)

    input:bind("a", function()
        moveSnake(-1, 0)
    end)

    input:bind("d", function()
        moveSnake(1, 0)
    end)
end

function love.load()
    love.filesystem.setIdentity("snake_assignment")

    love.window.setMode(600, 600)
    love.window.setTitle("Snake Game")

    love.graphics.setBackgroundColor(0.09, 0.08, 0.13)

    Fonts = {
        title = love.graphics.newFont(34),
        subtitle = love.graphics.newFont(18),
        body = love.graphics.newFont(14),
        small = love.graphics.newFont(12)
    }

    Colors = {
        bg = {0.09, 0.08, 0.13},
        panel = {0.16, 0.14, 0.22, 0.92},
        panelSoft = {0.20, 0.17, 0.28, 0.85},
        text = {1.0, 0.95, 0.98},
        muted = {0.85, 0.78, 0.90},
        snake = {0.47, 0.90, 0.68},
        snakeHead = {0.72, 1.0, 0.80},
        food = {1.0, 0.45, 0.65},
        sparkle = {1.0, 0.92, 0.65},
        grid = {0.20, 0.17, 0.27, 0.35},
        accent = {0.90, 0.70, 1.0}
    }

     gameState = GameState:new()

    -- Bonus: Listen for food eaten events
    Events:subscribe("food_eaten", function(data)
        lastEvent = "Yay! Food eaten! Score: "
            .. data.score

        print(lastEvent)
    end)

    setupInput()
end

function love.update(dt)
    gameState:update(dt)
end

function love.draw()
    gameState:draw()

    love.graphics.setColor(1, 1, 1)
    love.graphics.print(lastEvent, 10, 575)
end

function love.keypressed(key)
    input:handleKey(key)
end