Player = Class{}

function Player:init()
    self.x = 16
    self.y = 16

    self.width = 16
    self.height = 16

    -- velocity
    self.dx = 100
    self.dy = 0
end

function Player:update(dt)
    if love.keyboard.isDown('d') then
        self.x = self.x + self.dx * dt
    end
    if love.keyboard.isDown('a') then
        self.x = self.x - self.dx * dt
    end
end

function Player:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end