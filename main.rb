#- Our main app
require './config/startup'

#- This gets called and instantiated
class Main < Goliath::API

	#- Load static assets. Remove when your app is behind a proxy
	#  let the proxy do the dirty work
	use(Rack::Static,
		:root => Goliath::Application.app_path("public"),
		:urls => ["/favicon.ico", '/stylesheets', '/javascripts', '/images', '/robots.txt']
	)

	#- Some other routes to your custom Goliath class
	# For more routing examples, see:
	# https://github.com/postrank-labs/goliath/blob/master/examples/rack_routes.rb 

	# map '/fun/:id', MyClass

	#- Default route to automate controllers
	map '/:controller/(/:action(/:id))', Dispatch

	def response(env)
		AUDIT_LOG.info env.inspect
		#AUDIT_LOG.info params.inspect
		AUDIT_LOG.info '-----'

		[200, {}, "hola!"]
	end
end

