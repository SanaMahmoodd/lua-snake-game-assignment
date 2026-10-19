local MenuState = {}

local function drawSparkle(x, y, size)
    love.graphics.setColor(Colors.sparkle[1], Colors.sparkle[2], Colors.sparkle[3], 0.9)
    love.graphics.setLineWidth(2)

    love.graphics.line(x - size, y, x + size, y)
    love.graphics.line(x, y - size, x, y + size)

    love.graphics.setLineWidth(1)
    love.graphics.line(x - size * 0.6, y - size * 0.6, x + size * 0.6, y + size * 0.6)
    love.graphics.line(x - size * 0.6, y + size * 0.6, x + size * 0.6, y - size * 0.6)
end

function MenuState:update(dt)
    -- no menu logic for now
end

function MenuState:draw()
    love.graphics.clear(Colors.bg)

    -- soft background sparkles
    drawSparkle(90, 90, 8)
    drawSparkle(500, 110, 6)
    drawSparkle(120, 500, 7)
    drawSparkle(530, 470, 9)

    -- main panel
    love.graphics.setColor(Colors.panel)
    love.graphics.rectangle("fill", 110, 130, 380, 300, 18, 18)

    -- inner soft panel
    love.graphics.setColor(Colors.panelSoft)
    love.graphics.rectangle("fill", 130, 150, 340, 260, 14, 14)

    -- title
    love.graphics.setFont(Fonts.title)
    love.graphics.setColor(Colors.text)
    love.graphics.printf("SNAKE GAME", 0, 190, 600, "center")

    -- subtitle
    love.graphics.setFont(Fonts.subtitle)
    love.graphics.setColor(Colors.muted)
    love.graphics.printf("cute edition ✨", 0, 235, 600, "center")

    love.graphics.setFont(Fonts.body)
    love.graphics.setColor(Colors.text)
    love.graphics.printf("Press ENTER to Play", 0, 300, 600, "center")

    love.graphics.setColor(Colors.accent)
    love.graphics.printf("ESC to Quit", 0, 330, 600, "center")

    love.graphics.setFont(Fonts.small)
    love.graphics.setColor(Colors.muted)
    love.graphics.printf("Made with Lua + LOVE2D", 0, 385, 600, "center")

    -- cute snake preview circles
    love.graphics.setColor(Colors.snakeHead)
    love.graphics.circle("fill", 220, 265, 10)
    love.graphics.setColor(Colors.snake)
    love.graphics.circle("fill", 200, 265, 8)
    love.graphics.circle("fill", 182, 265, 7)

    -- food preview
    love.graphics.setColor(Colors.food)
    love.graphics.circle("fill", 385, 265, 8)
    drawSparkle(405, 250, 5)
end

return MenuState