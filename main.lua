	
function love.load()
	world = love.physics.newWorld(love.graphics.getWidth(), love.graphics.getHeight())
	world:setGravity(0, 5)
	love.graphics.setBackgroundColor(34,34,34)
--	ground = love.physics.newBody(world, 0, 50, 0, 0)
--	ball = newBall(world, 300, 0)

	body = love.physics.newBody(world,300,200,1)
	circle = love.physics.newCircleShape(body,body:getX(), body:getY(), 50)
	body:setMassFromShapes()
end

function love.update(dt)
	world:update(dt)
end

function love.draw()
--	 love.graphics.setColor(0,0,255)
--	 love.graphics.setBackgroundColor(0,0,0)
	love.graphics.print("FPS: " .. love.timer.getFPS(), 50, 50)	
	love.graphics.circle("fill", body:getX(), body:getY(), circle:getRadius())
 --	 love.graphics.print("something", body:getX(), body:getY())
	love.graphics.print(body:getX(), 400, 350)
	love.graphics.print(string.format("%.3f %.3f", body:getLinearVelocity()), body:getPosition())
 --	 love.graphics.line( body:getPosition(), body:getLinearVelocity())
end

-- x = 300, y = 0
function newBall(world, x, y)
	local t = {}
	t.body = love.physics.newBody(world, x, y, 10, 0)
	t.shape = love.physics.newCircleShape(t.body, x, y)
end


function love.keypressed(key, unicode)
	local force =	{
		w=		{0, -1},
		a=		{-1, 0},
		s=		{0, 1},
		d=		{1, 0},
		q=		{0, 1, -1, 1},
		e=		{0, 1, 1, 1}
	 }
	 
	callbacks = {
		escape = 
			function(unicode)
				love.event.push('q')
			end
	}
	
--	for letter in {'w', 'a', 's', 'd'} do
--		callbacks[letter] = 
--			function(unicode) 
--				body:applyImpulse(unpack(force[key]))
--			end
--	end
	
	callbacks[' '] = 
		function(unicode)
			-- Kick the ball up
			body:applyImpulse(0, -5)
		end
	
	if callbacks[key] then
		callbacks[key](unicode)
	end
end