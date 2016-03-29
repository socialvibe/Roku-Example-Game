function obj_ball()
	return function(object)

		' ################ What we are doing here is modifying the empty object with our ball specific function overrides ###################

		object.onCreate = function()
			m.x = 640
			m.y = 360
			m.dead = false
			m.xspeed = (5.5*60)*m.direction
	    	m.computer = m.gameEngine.getInstanceByName("computer")
	    	m.computer.ball = m
	    	m.player = m.gameEngine.getInstanceByName("player")
			if rnd(2) = 1 then : m.yspeed = 5*60*-1 : else : m.yspeed = 5*60 : end if
			m.addColliderRectangle("main_collider", -16, -16, 32, 32)
			m.addImage(m.gameEngine.getBitmap("ball"), 0, 0, 16, 16)
			m.gameEngine.cameraSetFollow(m)
		end function


		' Detect collision with other object
		object.onCollision = function(collider, other_collider, other_object)

			if not m.dead and other_object.name = "player" and other_collider = "front" then
				m.xspeed = Abs(m.xspeed)
			end if

			if not m.dead and other_object.name = "computer" and other_collider = "front" then
				m.xspeed = Abs(m.xspeed)*-1
			end if

			if (other_object.name = "player" or other_object.name = "computer") then
				if other_collider = "top" then
					m.yspeed = Abs(m.yspeed)*-1
				end if
				if other_collider = "bottom" then
					m.yspeed = Abs(m.yspeed)
				end if
			end if

		end function


		' This is run on every frame
		object.onUpdate = function(dt)
			' Handle Movement

			if m.x-16 <= 50 then
			    m.dead = true
			    if m.x <= -100
			    	m.computer.score = m.computer.score+1
			    	m.gameEngine.removeInstance(m.id)
			    end if
			end if

			if m.x+16 >= 1280-50 then
				m.dead = true
			    if m.x >= 1280+100
			    	m.player.score = m.player.score+1
			    	m.gameEngine.removeInstance(m.id)
			    end if
			end if

			if m.y-16 <= 50 then
			    m.yspeed = abs(m.yspeed)
			end if

			if m.y+16 >= 720-50 then
				m.yspeed = abs(m.yspeed)*-1
			end if

			percentage = abs(640-m.x)/640
			m.gameEngine.cameraSetZoom(1+percentage)

		end function

		' This function is called when I get destroyed
		object.onDestroy = function()
			m.gameEngine.currentRoom.ball = invalid
			m.computer.ball = invalid
			m.gameEngine.cameraSetZoom(1) 
			m.gameEngine.currentRoom.ball_spawn_timer.Mark()
		end function
	end function
end function