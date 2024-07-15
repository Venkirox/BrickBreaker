local Cell = {}
Cell.__index = Cell

function Cell.new(settings)
	local instance   = setmetatable({}, Cell)
	instance.x       = settings.x or 0
	instance.y       = settings.y or 0
	instance.w       = settings.w or 10
	instance.h       = settings.h or 10
	instance.f       = settings.f or 'line'
	instance.remove  = false
	instance.body    = love.physics.newBody(World1, instance.x, instance.y, 'static')
	instance.shape   = love.physics.newRectangleShape(instance.w, instance.h)
	instance.fixture = love.physics.newFixture(instance.body, instance.shape, instance.density)
	instance.remove  = false
	instance.powerup = math.random(1, 4)
	return instance
end

function Cell:update(dt)

end

function Cell:draw()
	love.graphics.polygon(self.f, self.body:getWorldPoints(self.shape:getPoints()))
	-- love.graphics.setColor(1, 0, 0)
	-- love.graphics.print(self.powerup, self.x, self.y)
	-- love.graphics.setColor(1, 1, 1)
end

function Cell:BeginContact(a, b, coll)
	local isCellFixture = a == self.fixture or b == self.fixture
	if not isCellFixture then return end
	for _, ball in ipairs(Balls.activeBalls) do
		if a == ball.fixture or b == ball.fixture then
			self.remove = true
			break
		end
	end
end

return Cell
