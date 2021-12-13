-- FEZ clocktower time simulation in Love2D
-- by thearst3rd


local times = {60, 60*60, 60*60*24, 60*60*24*7}
local colors =
{
	{1.0, 0.0, 0.0},
	{0.0, 0.0, 1.0},
	{0.0, 1.0, 0.0},
	{1.0, 1.0, 1.0},
}

local time = 0.0

local radius = 100


--------------------
-- MAIN CALLBACKS --
--------------------

function love.load()
	love.graphics.setFont(love.graphics.newFont(36))
end


function love.update(dt)
	time = time + 10000 * dt
	if time >= times[4] then time = time - times[4] end
end


function love.draw()
	local width = love.graphics.getWidth()
	local centerY = math.floor(love.graphics.getHeight() / 2)
	for i = 1, 4 do
		love.graphics.setColor(colors[i])
		local centerX = math.floor((i - 0.5) * love.graphics.getWidth() / 4)
		love.graphics.rectangle("line", centerX - radius, centerY - radius, 2 * radius, 2 * radius)

		local lineWidth = love.graphics.getLineWidth()
		love.graphics.setLineWidth(10)
		local timeRadians = 2 * math.pi * (time / times[i]) - math.pi
		local dx = radius * math.cos(timeRadians)
		local dy = radius * math.sin(timeRadians)
		love.graphics.line(centerX, centerY, centerX + dx, centerY + dy)
		love.graphics.setLineWidth(lineWidth)
	end
	love.graphics.setColor(1.0, 1.0, 1.0)
	love.graphics.print(string.format("%.2f", time), 100, 100)
end
