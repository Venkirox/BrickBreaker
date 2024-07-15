math.randomseed(os.time())
Newplayer = require('player')
ActivePowerups  = require('activepowerups')
Walls           = require('walls')
Blocks          = require('blocks')
Balls           = require('balls')
Sound = love.audio.newSource("bounce.wav", "static")
Powerup = love.audio.newSource("powerup.wav", "static")
Music = love.audio.newSource("music.wav", "stream") 
Music:setVolume(0.005)
Sound:setVolume(0.01)
Powerup:setVolume(0.01)


function BeginContact(a, b, coll)
	Blocks:BeginContact(a, b, coll)
	Player:BeginContact(a, b, coll)
	ActivePowerups:BeginContact(a, b, coll)
end

function EndContact(a, b, coll)

end

function PreSolve(a, b, coll)

end

function PostSolve(a, b, coll, normalimpulse, tangentimpulse)

end

love.physics.setMeter(64)
World1 = love.physics.newWorld(0, 0)
World1:setCallbacks(BeginContact, EndContact, PreSolve, PostSolve)

ActiveBalls = {}

function love.load()
	Music:play()
	Walls:load()
	Blocks:load()
	Player = Newplayer.new({})
	Balls:load()
	
end

function love.keypressed(key)
	if key == "r" then
		love.event.quit("restart")
	end
	Player:keypressed(key)
end

local crtShader = love.graphics.newShader [[
    extern number time;
    vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
        // Distortion
        vec2 position = (screen_coords / love_ScreenSize.xy) + vec2(sin(time), cos(time)) * 0.01;

        // Scanlines
        float scanlines = sin((position.y + time * -0.02) * love_ScreenSize.y * 0.5);  // Add time offset
        vec4 pixel = Texel(texture, position);
        pixel.rgb -= vec3(0.1) * clamp(scanlines, 0.0, 1.0);

        return pixel * color;
    }
]]

function love.update(dt)
	if not Music:isPlaying( ) then
		love.audio.play( Music )
	end
	crtShader:send("time", love.timer.getTime())
	World1:update(dt)
	Player:update(dt)
	-- Blocks:DropPowerup()
	Blocks:update(dt)
	Balls:update(dt)
	ActivePowerups:update(dt)

end

function love.draw()
	love.graphics.setBackgroundColor(0.3, 0.3, 0)
	love.graphics.setShader(crtShader)
	love.graphics.setColor(0.3, 0.3, 0)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
	love.graphics.setColor(1, 1, 1)
	Blocks:draw()
	Player:draw()
	Balls:draw()
	ActivePowerups:draw()
	love.graphics.setShader() -- Reset the shader
	love.graphics.printf(tostring(Score), 0, 20, love.graphics.getWidth(), 'center')
end
