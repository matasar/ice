speed = 15	

function love.load()
	width = love.graphics.getWidth()
	height = love.graphics.getHeight()
	world = love.physics.newWorld(width, height)
	world:setGravity(0, speed)
	love.graphics.setBackgroundColor(34,34,34)
--	ground = love.physics.newBody(world, 0, 50, 0, 0)
	ball = newBall(world, 300,0)
	floor = makeFloor(world)
	world:setCallbacks(
		function(first, second, contact)
			puts("COLLISION!",40)
		end,
		function(first, second, contact)
			puts("OAWAKHSAJHSAKHAS", 20)
		end,
		nil,
		nil)
end

function love.update(dt)
	world:update(dt)
end

function puts(string, y) 
	love.graphics.print(tostring(string), 200, 60+y)
end

function love.draw()
	love.graphics.print("FPS: " .. love.timer.getFPS(), 50, 50)	
 --	 love.graphics.print("something", body:getX(), body:getY())
	ball:draw()
	floor:draw()
 --	 love.graphics.line( body:getPosition(), body:getLinearVelocity())
end

function makeFloor(world)
	local floor = {}
	floor.body = love.physics.newBody(world, 0, 0, 0, 0)
	floor.shape = love.physics.newRectangleShape(floor.body, 0, height-50, width, 50, 0)
	function floor:draw()
		love.graphics.rectangle("fill", self.body:getX(), self.body:getY(), width, 50)
	end
	return floor
end

-- x = 300, y = 0
function newBall(world, x, y)
	local t = {}
	t.body = love.physics.newBody(world, x, y, 10, 0)
	t.shape = love.physics.newCircleShape(t.body, x, y, 50)
	t.body:setMassFromShapes()
	t.color = {255, 0, 0, 87}
	function t:draw()
		love.graphics.print(self.body:getX(), 400, 350)
		love.graphics.print(string.format("%.1f %.1f", self.body:getLinearVelocity()), self.body:getPosition())
		local r,g,b,a = love.graphics.getColor()
		love.graphics.setColor(unpack(self.color))
		love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius(), 50)
		love.graphics.setColor(r,g,b,a)
	end
	function t:applyImpulse(x, y)
		return self.body:applyImpulse(x * speed,y * speed)
	end
	return t
end


function love.keypressed(key, unicode)
	
	local force =	{
		w=		{0, -1},
		a=		{-1, 0},
		s=		{0, 1},
		d=		{1, 0}--[[,
		q=		{0, 1, -1, 1},
		e=		{0, 1, 1, 1}
]]
	 }
	 
	callbacks = {
		escape = 
			function(unicode)
				love.event.push('q')
			end
	}
	
	for index, letter in ipairs({'w', 'a', 's', 'd'}) do
		callbacks[letter] = 
			function(unicode) 
--				local x, y = unpack(force[key])
				ball:applyImpulse(unpack(force[key]))
			end
	end 
	
	callbacks[' '] = 
		function(unicode)
			-- Kick the ball up
			ball:applyImpulse(0, -1)
		end
	
	if callbacks[key] then
		callbacks[key](unicode)
	end
end