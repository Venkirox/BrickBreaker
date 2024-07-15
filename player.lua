local Player = {}
Player.__index = Player

function Player.new(settings)
	local instance   = setmetatable({}, Player)
	instance.x       = settings.x or love.graphics.getWidth() / 2 - 50
	instance.y       = settings.y or love.graphics.getHeight() - 20
	instance.w       = settings.w or 100
	instance.h       = settings.h or 20
	instance.speed   = settings.speed or (50 * GWidth)
	instance.body    = love.physics.newBody(World1, instance.x, instance.y, 'dynamic')
	instance.shape   = love.physics.newRectangleShape(instance.w, instance.h)
	instance.fixture = love.physics.newFixture(instance.body, instance.shape, instance.density)
	instance.body:setFixedRotation(true)
	instance.fixture:setRestitution(0)
	instance.fixture:setDensity(1000)
	instance.uShape = false
	return instance
end

function Player:keypressed(key)
	if key == 'space' and BallStart == 0 then
		for i = #Balls.activeBalls, 1, -1 do
			BallStart = 1
			Balls.activeBalls[i].speed = 300
			if love.keyboard.isDown('a') then
				Balls.activeBalls[i].body:setLinearVelocity(-300, -300)
			elseif love.keyboard.isDown('d') then
				Balls.activeBalls[i].body:setLinearVelocity(300, -300)
			else
				Balls.activeBalls[i].body:setLinearVelocity(math.random(-100,100), -300)
			end
		end
	end
end

function Player:update(dt)
	self.body:setY(self.y)
	
	if love.keyboard.isDown('a') then
		self.body:setLinearVelocity(-400, 0)
	elseif love.keyboard.isDown('d') then
		self.body:setLinearVelocity(400, 0)
	else
		self.body:setLinearVelocity(0, 0)
	end
	
	if self.uShape then
		self.shape = nil
        self.fixture:destroy()

		self.shape = love.physics.newRectangleShape(self.w, self.h)
		self.fixture = love.physics.newFixture(self.body, self.shape, self.density)
	end
end

function Player:draw()
	love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
end

function Player:BeginContact(a, b, coll)
	local isPlayerFixture = a == self.fixture or b == self.fixture
	if not isPlayerFixture then return end
	for _, ball in ipairs(Balls.activeBalls) do
        if a == ball.fixture or b == ball.fixture then
			Sound:play()
           ball.body:setLinearVelocity(ball.vx, -ball.speed)
		   
        end
    end
	
end 

return Player
