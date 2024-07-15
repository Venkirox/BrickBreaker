Newpowerup = require('powerup')
local Timer = require('timer')
local newBall = require('ball')

ActivePowerups = { activePowerups = {} }

function ActivePowerups:load()

end

function ActivePowerups:BeginContact(a, b, coll)
	for _, powerup in ipairs(self.activePowerups) do
		powerup:BeginContact(a, b, coll)
	end
end

function ActivePowerups:update(dt)
	for i = #self.activePowerups, 1, -1 do
		if #self.activePowerups > 0 then
			self.activePowerups[i]:update(dt)
			if self.activePowerups[i].remove then
				if self.activePowerups[i].powerupType == 1 then
					if self.activePowerups[i].remove then
						Player.uShape = true
						Player.w = Player.w + 12
						-- Timers:create(10)
						
						
					end
				
				elseif self.activePowerups[i].powerupType == 2 then
					if self.activePowerups[i].remove then
						for i = 1, #Balls.activeBalls do
							table.insert(Balls.activeBalls, newBall.new({x = Balls.activeBalls[i].body:getX()+ math.random(-30,30), y = Balls.activeBalls[i].body:getY() + math.random(-30,30), speedY = -300 }))
							table.insert(Balls.activeBalls, newBall.new({x = Balls.activeBalls[i].body:getX()+ math.random(-30,30), y = Balls.activeBalls[i].body:getY() + math.random(-30,30), speedX = -300, speedY = -300 }))
						end
						
					end
				
				elseif self.activePowerups[i].powerupType == 3 then
					if self.activePowerups[i].remove then
						table.insert(Balls.activeBalls, newBall.new({x = Player.body:getX(), y = Player.body:getY() - 30, speedX = math.random(-2,2)*50, speedY = -300, radius = 10 }))
					end
				end
				self.activePowerups[i].body:destroy()
				table.remove(ActivePowerups.activePowerups, i)
				Powerup:play()
			end
		end
	end
end

function ActivePowerups:draw()
	for i = #self.activePowerups, 1, -1 do
		if #self.activePowerups > 0 then
			if self.activePowerups[i].powerupType == 1 then
				love.graphics.setColor(1,0,0)
				self.activePowerups[i]:draw()
				love.graphics.setColor(1,1,1)
			end
			if self.activePowerups[i].powerupType == 2 then
				love.graphics.setColor(0,1,0)
				self.activePowerups[i]:draw()
				love.graphics.setColor(1,1,1)
			end
			if self.activePowerups[i].powerupType == 3 then
				love.graphics.setColor(0,0,1)
				self.activePowerups[i]:draw()
				love.graphics.setColor(1,1,1)
			end
		end
	end
end

return ActivePowerups
