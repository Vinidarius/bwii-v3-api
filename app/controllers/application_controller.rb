class ApplicationController < ActionController::Base
        include DeviseTokenAuth::Concerns::SetUserByToken
  # protect_from_forgery with: :exception

	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
		@routing = request.original_fullpath["/api/v3".length..-1]

		if @routing == "/auth_compagnies"
			devise_parameter_sanitizer.permit(:sign_up, keys: [
				:name,
				:email,
				:background_color,
				:text_color,
				:comparution_text,
				:archived
			])
		elsif @routing == "/auth_agents"
			devise_parameter_sanitizer.permit(:sign_up, keys: [
				:firstname,
				:lastname,
				:email,
				:phone_number,
				:archived,
				:compagny_id
			])
		elsif @routing == "/auth_users"
			devise_parameter_sanitizer.permit(:sign_up, keys: [
				:firstname,
				:lastname,
				:email,
				:phone_number,
				:company,
				:job,
				:comparution_text,
				:archived,
				:compagny_id
			])
		end

  end
end
