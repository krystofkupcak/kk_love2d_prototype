love.graphics.setDefaultFilter('nearest', 'nearest')
push = require 'lib/push'
Class = require 'lib/class'

require 'Util'
require 'Player'
require 'Map'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 256
VIRTUAL_HEIGHT = 144

gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/pixelgame_design_test.png')
}

gQuads = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], TILE_SIZE, TILE_SIZE)
}

function love.load()
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    map = Map()

    -- initialize mouse input table
    love.mouse.buttonsPressed = {}
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.mousepressed(x, y, button)
    local x_pos, y_pos = push:toGame(x, y) -- switch to game coordiantes, based by virtual resolution
    love.mouse.buttonsPressed[button] = true
    love.mouse.buttonsPressed['x'] = math.floor(x_pos)
    love.mouse.buttonsPressed['y'] = math.floor(y_pos)
end

function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end

function love.update(dt)
    map:update(dt)

    love.mouse.buttonsPressed = {}
end

function love.draw()
    push:start()
    map:render()
    push:finish()
end