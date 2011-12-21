#- All controllers inherit from this
class ApplicationController < Goliath::API
	use Goliath::Rack::Params
	use Goliath::Rack::Validation::RequestMethod, %w(GET POST PUT)
	include Goliath::Rack::Templates

	attr_accessor :controller, :action, :rendered, :http_status, :content_type

	#- This is like a filter
	def initialize(env)
	end

	#- Render something
	def render(template = nil, p={})
		return nil if !template

		#- Double rendering
		if @rendered
			return 'Double Rendering... cleanup'
		end

		#- Setup layout
		if p.include?(:layout) && p[:layout] == false
			#- No layout
		elsif p.include?(:layout) && File.exists(Goliath::Application.app_path('app/views/layouts/' + p[:layout] + '.erb'))
			p[:layout] = 'app/views/layouts/' + p[:layout]
		else
			#- Default layout
			p[:layout] = 'app/views/layouts/application'
		end
		
		#- Setup template
		t = "app/views/#{@controller}/" + (template || self.action)

		if layout = Tilt.new(p[:layout] + '.erb')
			#- Render with the layout
			@rendered = true
			return layout.render(self) { Tilt.new(t + '.erb').render(self) }
		end

	end
end
