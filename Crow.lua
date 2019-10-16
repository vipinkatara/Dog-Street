

Crow = Class{}



local PIPE_SCROLL = -60

function Crow:init()
    self.x = VIRTUAL_WIDTH 

    -- set the Y to a random value halfway below the screen
    

    self.width = crow:getWidth()
    self.height = crow:getHeight()
    self.y = math.random(VIRTUAL_HEIGHT - 280  , VIRTUAL_HEIGHT - 100 )
    --self.xx = x
end

--rock_width = self.width
 --rock_height = self.height

function Crow:update(dt)
    self.x = self.x + PIPE_SCROLL * dt
end

function Crow:render()
    love.graphics.draw(crow, math.floor(self.x + 0.5), math.floor(self.y))
end