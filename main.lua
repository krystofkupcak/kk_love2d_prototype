love.graphics.setDefaultFilter('nearest', 'nearest')
push = require 'lib/push'
Class = require 'lib/class'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 256
VIRTUAL_HEIGHT = 144

TILE_SIZE = 16
require 'Util'
require 'Player'

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

    player = Player()
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    push:start()
    love.graphics.draw(gTextures['tiles'], gQuads['tiles'][1], 0 , 0)
    love.graphics.draw(gTextures['tiles'], gQuads['tiles'][2], 16 , 0)
    player:render()
    push:finish()
end