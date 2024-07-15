local newBall = require('ball')

local Balls = { activeBalls = {} }
BallStart = 0
function Balls:load()
	table.insert(self.activeBalls, newBall.new({x = Player.x, y = Player.y - Player.h/2 - 20, speed = 0}))
end

function Balls:update(dt)
	for i = #self.activeBalls, 1, -1 do
		if #self.activeBalls > 0 then
			self.activeBalls[i]:update(dt)
		end
		if BallStart == 0 then
			for i = #self.activeBalls, 1, -1 do
				self.activeBalls[i].body:setX(Player.body:getX())
		end
		end
	end
end


function Balls:draw() 
	for i = #self.activeBalls, 1, -1 do
		if #self.activeBalls > 0 then
			self.activeBalls[i]:draw()
		end
		if self.activeBalls[i].body:getY() > love.graphics.getHeight() + self.activeBalls[i].radius * 2 then
			self.activeBalls[i].body:destroy()
			table.remove(self.activeBalls, i)
		end
	end
end


function Balls:BeginContact(a, b, coll)

end

return Balls
