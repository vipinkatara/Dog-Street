

Rock = Class{}



local PIPE_SCROLL = -60

function Rock:init()
    self.x = VIRTUAL_WIDTH

    -- set the Y to a random value halfway below the screen
    

    self.width = rock_1:getWidth()
    self.height = rock_1:getHeight()
    self.y = math.random(VIRTUAL_HEIGHT - self.height , VIRTUAL_HEIGHT  )
    --self.xx = self.x
    --self.height = y
end

--rock_width = self.width
 --rock_height = self.height

function Rock:update(dt)
    self.x = self.x + PIPE_SCROLL * dt
end




function Rock:render()
	love.graphics.setColor(255,255,255,255)
    love.graphics.draw(rock_1, (self.x - 30), (self.y))
    --love.graphics.setColor(50,050,50,255)
    --love.graphics.print(tostring(math.floor(self.y)), (self.x), (self.y))
    --love.graphics.print(tostring(self.height), 50, 50)
end