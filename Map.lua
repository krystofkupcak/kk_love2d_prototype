TILE_SIZE = 16

TILE_WALL = 1
TILE_EMPTY = 0

Map = Class{}

function Map:init()
    self.mapWidth = VIRTUAL_WIDTH / TILE_SIZE
    self.mapHeight = VIRTUAL_HEIGHT / TILE_SIZE

    self.player = Player()

    self.level1 = {
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
    }

    self.tiles = self.level1
end

function Map:update(dt)
    self.player:update(dt)

    if love.mouse.wasPressed(1) then
        local tile = self:tileAtPixel(love.mouse.buttonsPressed['x'], love.mouse.buttonsPressed['y'])
        self:setTile(tile.x, tile.y, 1)
    end
    if love.mouse.wasPressed(2) then
        print(tostring(self:tileAtPixel(love.mouse.buttonsPressed['x'], love.mouse.buttonsPressed['y']).id))
    end
end

function Map:render()
    for y = 1, self.mapHeight, 1 do
        for x = 1, self.mapWidth, 1 do
            if self:getTile(x, y) == TILE_WALL then
                love.graphics.draw(gTextures['tiles'], gQuads['tiles'][TILE_WALL], (x - 1) * TILE_SIZE , (y - 1) * TILE_SIZE)
            end
        end
    end
    self.player:render()
end


-- Map Tiles Code

-- returns an integer value for the tile at a given tileMap x-y coordinate
function Map:getTile(x, y)
    return self.tiles[(y - 1) * self.mapWidth + x]
end

-- sets a tile at a given tileMap x-y coordinate to an integer value
function Map:setTile(x, y, id)
    self.tiles[(y - 1) * self.mapWidth + x] = id
end

-- gets the tile type at a given pixel coordinate
function Map:tileAtPixel(x, y)
    return {
        x = math.floor(x / TILE_SIZE) + 1,
        y = math.floor(y / TILE_SIZE) + 1,
        id = self:getTile(math.floor(x / TILE_SIZE) + 1, math.floor(y / TILE_SIZE) + 1)
    }
end