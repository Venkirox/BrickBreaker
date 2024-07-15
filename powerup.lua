local Powerup = {}
Powerup.__index = Powerup
--setmetatable(childmeta, Powerup)

function Powerup.new(settings)
	local instance       = setmetatable({}, Powerup)
	--local instance = setmetatable(Powerup.new(settings), childmeta)
	instance.x           = settings.x or 0
	instance.y           = settings.y or 0
	instance.radius      = settings.radius or 5
	instance.speed       = settings.speed or 50
	instance.remove      = false
	instance.density     = settings.density or 1
	instance.body        = love.physics.newBody(World1, instance.x, instance.y, 'dynamic')
	instance.shape       = love.physics.newCircleShape(instance.radius)
	instance.fixture     = love.physics.newFixture(instance.body, instance.shape, instance.density)
	instance.restitution = settings.restitution or 0
	instance.fixture:setRestitution(instance.restitution)
	instance.fixture:setFriction(0)
	instance.body:setLinearVelocity(0, instance.speed)
	instance.powerupType = math.random(1, 3)
	instance.fixture:setSensor(true)
	return instance
end

function Powerup:BeginContact(a, b, coll)
	local isPowerupFixture = a == self.fixture or b == self.fixture
	if not isPowerupFixture then return end
	if a == Player.fixture or b == Player.fixture then
		self.remove = true
	end
end

function Powerup:update(dt)

end

function Powerup:draw()
	love.graphics.circle('fill', self.body:getX(), self.body:getY(), self.shape:getRadius())
	-- love.graphics.setColor(1, 0, 0)
	-- love.graphics.print(self.powerupType, self.x, self.y)
	-- love.graphics.setColor(1, 1, 1)
end

return Powerup
