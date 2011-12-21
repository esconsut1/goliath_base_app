#- Dispatcher
#- This kind of mimics rails in calling the apropo @controller and @actions

class Dispatch < Goliath::API
	def response(env)
		router = env['router.params']
		http_status = 200
		content_type = 'text/html'

		#- Define @controller and router
		controller = router[:controller].downcase.capitalize + 'Controller'
		action = router[:action] || 'index'

		#- Try to execute
		msg = nil
		begin
			if obj = Object.const_get(controller).new(env)
				if obj.respond_to?(action)
					
					#- Set controller and action
					obj.controller = router[:controller]
					obj.action = action

					out = obj.send(action)

					if !obj.rendered
						#- Officially call render
						msg = obj.render(action)
					else
						#- Otherwise just take what was returned
						msg = out
					end
				else
					msg = "#{@controller}##{@action} does not exist"
				end
			else
				msg = "Controller: #{@controller} does not exist."
			end
		rescue
			msg = $!
		end

		[http_status, {'Content-Type' => content_type}, msg]
	end
end


