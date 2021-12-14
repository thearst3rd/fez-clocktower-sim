-- FEZ clocktower time simulation in Love2D
-- by thearst3rd

-- graphics improvement by Krzyhau

local times =	-- in seconds
{
	60,					-- minute
	60 * 60,			-- hour
	60 * 60 * 24,		-- day
	60 * 60 * 24 * 7,	-- week
}
local colors =
{
	{1.0, 0.0, 0.0},	-- minute
	{0.0, 0.0, 1.0},	-- hour
	{0.0, 1.0, 0.0},	-- day
	{1.0, 1.0, 1.0},	-- week
}

local time = 0.0
local timescale = 10000

local radius = 100

local drawRotAng = 0
local destRotAng = 0


function drawClock(x, y, angle)
	love.graphics.push();
	love.graphics.translate(x, y);
	for i = 1, 4 do
		local clockAng = angle + 90 * i
		while clockAng > 180 do clockAng = clockAng - 360 end
		while clockAng < -180 do clockAng = clockAng + 360 end

		if math.abs(clockAng) < 90 then
			local clockColor = colors[i]
			local clockDarkerColor = {colors[i][1] * 0.5, colors[i][2] * 0.5, colors[i][3] * 0.5}
			local clockTime = times[i]

			love.graphics.push()
			local clockAngRad = clockAng / 180.0 * math.pi
			love.graphics.translate(math.sin(clockAngRad) * radius * 1.05, 0)
			love.graphics.scale(math.cos(clockAngRad), 1)

			love.graphics.setLineWidth(radius * 0.1);

			-- drawing border of the clock
			love.graphics.setColor(clockDarkerColor)
			love.graphics.rectangle("line", -radius, -radius, radius * 2, radius * 2)
			love.graphics.setColor(0.0, 0.0, 0.0)

			-- drawing 12th hour indicator
			love.graphics.rectangle("fill", -radius * 0.1, -radius, radius * 0.2, radius * 0.2)

			love.graphics.setColor(clockDarkerColor)
			love.graphics.setLineWidth(radius * 0.1);
			love.graphics.rectangle("line", -radius * 0.1, -radius, radius * 0.2, radius * 0.2)

			love.graphics.setColor(clockColor)
			love.graphics.setLineWidth(radius * 0.05);
			love.graphics.rectangle("line", -radius * 0.1, -radius, radius * 0.2, radius * 0.2)

			-- drawing clock hand
			local timeRadians = 2 * math.pi * (time / clockTime)
			love.graphics.rotate(timeRadians)

			love.graphics.setColor(clockDarkerColor)
			love.graphics.setLineWidth(radius * 0.1);
			love.graphics.line(0, 0, -radius * 0.7, 0)

			love.graphics.setColor(clockColor)
			love.graphics.setLineWidth(radius * 0.05);
			love.graphics.line(-radius * 0.03, 0, -radius * 0.67, 0)

			love.graphics.pop()
		end
	end
	love.graphics.pop();
end


--------------------
-- MAIN CALLBACKS --
--------------------

function love.load()
	love.graphics.setFont(love.graphics.newFont(36))
end


function love.update(dt)
	time = time + dt * timescale
	if time >= times[4] then time = time - times[4] end

	drawRotAng = drawRotAng + (destRotAng - drawRotAng) * dt * 5;
end


function love.draw()
	local width = love.graphics.getWidth()
	local centerY = math.floor(love.graphics.getHeight() / 2)
	for i = 1, 4 do
		local centerX = math.floor((i - 0.5) * love.graphics.getWidth() / 4)
		drawClock(centerX, centerY, -90 * i - drawRotAng)
	end
	love.graphics.setColor(1.0, 1.0, 1.0)
	love.graphics.print(string.format("%.2f", time), 100, 100)
end


---------------------
-- OTHER CALLBACKS --
---------------------

function love.keypressed(key, scancode, isrepeat)
	if key == "d" then
		destRotAng = destRotAng + 90
	elseif key == "a" then
		destRotAng = destRotAng - 90
	end
end
