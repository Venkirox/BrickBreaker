local newCell = require("cell")
local Blocks = {}
Score = 0
function Blocks:load()
	local cellH = 20 * GHeigth
	local cellW = 40 * GWidth
	local colNr = 16
	local rowNr = 5
	local totalCell = colNr * rowNr 
	local pixelsBetweenX = 10 * GWidth
	local pixelsBetweenY = 10 * GHeigth
	local allCellW = (cellW + pixelsBetweenX) * colNr - pixelsBetweenX
	local freeSpace = (love.graphics.getWidth() - allCellW) / 2
	local baseX = freeSpace - pixelsBetweenX
	local x = baseX
	local y = 70
	local curRow = 0
	local color = 1
	local spacePrevious = 0
	local rowW = (cellW + pixelsBetweenX) * (colNr) + x
	local colH = (cellH + pixelsBetweenY) * (rowNr) + y
	CurrentBlocks = totalCell
	for i = 1, totalCell do
		local spaceBetween = (pixelsBetweenX * i) - spacePrevious
		color = color + 1
		x = baseX
		x = x + (cellW * (i - (curRow * colNr) - 1)) + spaceBetween

		if ((y + cellH) / rowNr) - 1 > colH / rowNr then
			break
		end
		table.insert(Blocks, newCell.new({ x = x + cellW / 2, y = y - cellH / 2, f = 'fill', w = cellW, h = cellH }))

		if x + cellW >= rowW then
			y = y + cellH + pixelsBetweenY
			curRow = curRow + 1
			spacePrevious = spacePrevious + spaceBetween
			if colNr % 2 == 0 then
				color = color + 1
			end
		end
	end
end

function Blocks:BeginContact(a, b, coll)
	for _, cell in ipairs(Blocks) do
		cell:BeginContact(a, b, coll)
	end
end

function Blocks:update(dt)
	for i, cell in ipairs(Blocks) do
		if cell.remove then
			if cell.powerup == 4 then
				table.insert(ActivePowerups.activePowerups, Newpowerup.new({ x = cell.x, y = cell.y }))
			end
			table.remove(Blocks, i)
			cell.body:destroy()
			CurrentBlocks = CurrentBlocks - 1
			if CurrentBlocks == 0 then
				Blocks:load()
				Score = Score + 1
			end
		end
	end
end

function Blocks:draw()
	for _, cell in ipairs(Blocks) do
		cell:draw()
	end
end

-- function Blocks:DropPowerup()
-- 	table.insert(ActivePowerups.activePowerups, Newpowerup.new({ x = cell.x, y = cell.y }))
-- end

return Blocks
