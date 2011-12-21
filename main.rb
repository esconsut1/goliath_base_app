#- Our main app
require './config/startup'

#- This gets called and instantiated
class Main < Goliath::API

	#- Default routes
	map '/:controller/(/:action(/:id))', Dispatch

	def response(env)
		AUDIT_LOG.info env.inspect
		#AUDIT_LOG.info params.inspect
		AUDIT_LOG.info '-----'

		[200, {}, "hola!"]
	end
end

