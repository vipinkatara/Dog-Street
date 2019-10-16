push = require 'push'
Class = require 'class'
require 'rock'
require 'dog'

require 'crow'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local x = 280
local y =400
local orientation = 1
local  spawnTimer1 = 0
count = 0

score = 0

sounds = {
	['music'] = love.audio.newSource('music.mp3','static'),
	['jump'] = love.audio.newSource('jump.wav','static'),
	['hit'] = love.audio.newSource('hit.wav','static'),
	['crow'] = love.audio.newSource('crow.wav','static')
}



crow = love.graphics.newImage('crow.png')

local background = love.graphics.newImage('background1.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('ground.png')

 rock_1 = love.graphics.newImage('rock_1.png')

local smallFont = love.graphics.newFont('font.ttf')

local start = love.graphics.newImage('start.png')

 dog = love.graphics.newImage('dog_test_img.png')

img_1 = love.graphics.newImage('1.png')

img_2 = love.graphics.newImage('2.png')

local roccks = {}
local spawnTimer = 0
local crowss = {}
gameState = 'start'

dog = Dog()

img_choose = 1
crowtimer = 0

--local ground = 0

local BACKGROUND_SCROLL_SPEED = 15
GROUND_SCROLL_SPEED = 30
local BACKGROUND_LOOPING_POINT =  571 -- WORK ON IT REFRESH BACKGROUnD
groundScroll = 0
function love.load()
	love.graphics.setDefaultFilter('nearest','nearest')
	love.window.setTitle('Dog Street')

	push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
		fullscreen = false,
		resizable = true,
		vsync = true 
    })

	love.keyboard.keysPressed = {}

end

 function love.resize(w,h)
	push:resize(w,h)
	-- body
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
    	--sounds['jump']:play()
        return true
    else
        return false
    end
end

function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
    if love.keyboard.keysPressed[key] == true then
    	sounds['jump']:play()
    end

    count1 = 0
    countn = 0
    
    if key == 'escape' then
        love.event.quit()
    end


	if key == 'return' then
		sounds['jump']:stop()
		if gameState == 'gameOver' then
			gameState = 'start'
		else
			gameState = 'play'
		end
	end




end

function love.update(dt)
	if gameState ~= 'start' then

	if gameState == 'gameOver' then
		countn = countn + 1
		if countn == 70 then
			sounds['hit']:stop()
			end
		
	--end
	else
	--if scrolling == true then

	--scroll background by preset speed * dt,looping back to 0 after looping point
	if gameState == 'play' then
		backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
		% BACKGROUND_LOOPING_POINT

		groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
		% VIRTUAL_WIDTH

		sounds['music']:play()
	
		score = score + dt
		
	if crowtimer > 2 and crowtimer < 5 then
    	sounds['crow']:play()
    end
    if crowtimer > 4.3 then
    	sounds['crow']:stop()
    	crowtimer = 0
    end
		--sounds['crow']:play()
	end
	spawnTimer = spawnTimer + dt
	crowtimer = crowtimer + dt

	if spawnTimer > 2 then
        table.insert(roccks, Rock())
        print('Added new rock!')
        spawnTimer = 0
        --sounds['crow']:stop()
    end

    for k, rock in pairs(roccks) do
        rock:update(dt)

        if rock.y >= 256 then
        	table.remove(roccks,k)
        	--break
        end

        --for l, pipe in pairs(roccks) do
            if dog:collides(rock) then
            	sounds['music']:stop()
            	sounds['crow']:stop()
            	sounds['hit']:play()
                gameState = 'gameOver'
                score = math.floor(score)
                --if(countn == 3) then
                --sounds['hit']:stop()
            	--end
            	--countn = countn + 1


            end
        

        
        if rock.x < -rock.width then
            table.remove(roccks, k)
        end
    end
    
    spawnTimer1 = spawnTimer1 + dt
    if spawnTimer1 > 2 then
        table.insert(crowss, Crow())
        print('Added new crow!')
        spawnTimer1 = 0
    end

    for k, crw in pairs(crowss) do
        crw:update(dt)


        if crw.x < -crw.width then
            table.remove(crowss, k)
        end
        --end
    end


    

    --gameState = 'gameOver'

	dog:update(dt)

		

	--table.remove(love.keyboard.keysPressed,key)
	if gameState == 'gameOver' then
		score = score
		--if love.keypressed

	end
	end
end
end

function love.draw()

	push:start()

	if gameState == 'start' then

	love.graphics.draw(start, 0 , 0) 
	end

	if gameState == 'play' then
	love.graphics.draw(background,-backgroundScroll,0)
	love.graphics.setColor(50,050,50,255)
	love.graphics.print('Score : ' .. tostring(tonumber(math.floor(score))), VIRTUAL_WIDTH - 110, 10)
	love.graphics.setColor(255,255,255,255)
	
	for k, rock in pairs(roccks) do
        rock:render()
    end
    for k, crw in pairs(crowss) do
        crw:render()
    end


	
	love.graphics.draw(ground,-groundScroll,VIRTUAL_HEIGHT - 16)
	
			dog:render()
	
	end
	if gameState == 'gameOver' then
		love.graphics.print('game Over',VIRTUAL_WIDTH / 3 + 40, VIRTUAL_HEIGHT / 2)
		love.graphics.print('Score : ' .. tostring(tonumber(score)), VIRTUAL_WIDTH / 3 + 40, VIRTUAL_HEIGHT / 3)
	end

	displayFPS()
	push:finish()
	
end

function displayFPS()
	love.graphics.setFont(smallFont)
	love.graphics.setColor(50,050,50,255)
	love.graphics.print('FPS : ' .. tostring(love.timer.getFPS()),10,10)
end
