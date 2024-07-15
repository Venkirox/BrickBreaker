Ball = {}
Ball.__index = Ball

function Ball.new(settings)
	local instance       = setmetatable({}, Ball)
	instance.x           = settings.x or love.graphics.getWidth() / 2
	instance.y           = settings.y or love.graphics.getHeight() / 2
	instance.radius      = settings.radius or 15
	instance.speed       = settings.speed or 300
	instance.speedX      = settings.speedX or instance.speed
	instance.speedY		 = settings.speedY or instance.speed
	instance.remove      = false
	instance.density     = settings.density or 1
	instance.body        = love.physics.newBody(World1, instance.x, instance.y, 'dynamic')
	instance.shape       = love.physics.newCircleShape(instance.radius)
	instance.fixture     = love.physics.newFixture(instance.body, instance.shape, instance.density)
	instance.restitution = settings.restitution or 1
	instance.fixture:setRestitution(instance.restitution)
	instance.fixture:setFriction(0)
	instance.body:setLinearVelocity(instance.speedX, instance.speedY)
	instance.currentSpeed = 0
	instance.vx           = 0
	instance.vy           = 0
	return instance
end

function Ball:update(dt)
	self.vx, self.vy = self.body:getLinearVelocity()
	self.currentSpeed = math.sqrt(self.vx ^ 2 + self.vy ^ 2)

	if self.currentSpeed < self.speed then
		-- Calculate the direction of the velocity vector
		local directionX, directionY = self.vx / self.currentSpeed, self.vy / self.currentSpeed

		-- If current speed is below the desired speed, set velocity to desired speed
		self.body:setLinearVelocity(directionX * self.speed, directionY * self.speed)
	end
end

function Ball:draw()
	love.graphics.circle('fill', self.body:getX(), self.body:getY(), self.shape:getRadius())
end

return Ball
