Dog = Class{}

ANTI_GRAVITY = -1
count1 = 0
GRAVITY = 5

PIPE_WIDTH = 90
PIPE_HEIGHT = 72

math.randomseed(os.time())


function Dog:init()
	x = 0
	y = 240
	dy = 0
	dy_g = 0
	width = dog:getWidth()
    height = dog:getHeight()
end


function Dog:update(dt)

	 

	if img_choose == 1 then
		if count == 30 then
			img_choose = 2
			count = 0
		else
			count = count + 1
		end
	
	else
		if count == 30 then
			img_choose = 1
			count = 0
		else
			count = count + 1
		end
		--img_choose = 1
	end

	if love.keyboard.wasPressed('space') then
		--sounds['jump']:play()

        dy = ANTI_GRAVITY
        x = x + 0.5
        --sounds['jump']:stop()

        --count = 0
        --dy_g = 3
    end
    
    if count1 == 50 then
    	--dy = 50
    	if y < 240 then
    		y = y + -(dy)
    	else
    		dy = 0
    		x = x - 0.5
    		if(x > 0) then
    			x = x - 0.5
    		end
    		--count1 = 0
    		table.remove(love.keyboard.keysPressed,key)
    		--love.keyboard.keysPressed[key] = false
    		
    	end
    	
    else
    	if dy == ANTI_GRAVITY then
    		y = y + dy --+ dy_g
    	--if(dy < 0) then
    	--	dy = dy + 1
    	--dy = 0
    	
    	count1 = count1 + 1
    end
    end

    dy = 0
    --sounds['jump']:play()
    --table.remove(love.keyboard.keysPressed,key)
	-- body
end

function Dog:render()
	if img_choose == 1 then
				love.graphics.draw(img_1, x, y)
			else
				love.graphics.draw(img_2, x, y)
			end
	-- body
end

function Dog:collides(pipe)
    -- the 2's are left and top offsets
    -- the 4's are right and bottom offsets
    -- both offsets are used to shrink the bounding box to give the player
    -- a little bit of leeway with the collision
    if (x + 2) + (width - 4) >= pipe.x + 15 and x + 2 <= pipe.x  then
        if (y + 2) + (height - 4) >= pipe.y + 20 and y + 2 <= pipe.y + 20 then
            return true
        end
    end

    return false
	-- body
end
   
