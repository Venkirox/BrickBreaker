local Walls = {}

function Walls:load()
	-- Walls.bodyD = love.physics.newBody(World1, love.graphics.getWidth()/2, love.graphics.getHeight())
	-- Walls.shapeD = love.physics.newRectangleShape(love.graphics.getWidth(), 1)
	-- Walls.fixtureD = love.physics.newFixture(Walls.bodyD, Walls.shapeD)

	self.bodyU = love.physics.newBody(World1, love.graphics.getWidth() / 2, -1)
	self.shapeU = love.physics.newRectangleShape(love.graphics.getWidth(), 1)
	self.fixtureU = love.physics.newFixture(self.bodyU, self.shapeU)

	self.bodyL = love.physics.newBody(World1, 0, love.graphics.getHeight() / 2)
	self.shapeL = love.physics.newRectangleShape(1, love.graphics.getHeight())
	self.fixtureL = love.physics.newFixture(self.bodyL, self.shapeL)

	self.bodyR = love.physics.newBody(World1, love.graphics.getWidth() + 1, love.graphics.getHeight() / 2)
	self.shapeR = love.physics.newRectangleShape(1, love.graphics.getHeight())
	self.fixtureR = love.physics.newFixture(self.bodyR, self.shapeR)
end

return Walls
