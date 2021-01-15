class Api::V3::PasswordUsersController < Api::V3::BaseController

	require "net/https"
	require "uri"

	def index
		@user = User.find_by_uid(params[:uid])
	end

	def update
		url = "https://prod-bwii-v3-api.herokuapp.com/api/v3/auth_user/password"
		encoded_url = URI.encode(url)
		uri = URI.parse(encoded_url)
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		request = Net::HTTP::Put.new(uri.request_uri, initheader = {'Content-Type' =>'application/json', 'access-token' =>  params["user"]["access_token"], 'client' =>  params["user"]["client"], 'uid' => params["user"]["uid"]})
		body = {
		"password": params["user"]["password"],
		"password_confirmation":  params["user"]["password_confirmation"]
		}.to_json
		request.body = body
		response = http.request(request)
		parsed_json = ActiveSupport::JSON.decode(response.body)
		if parsed_json["success"] == false
				 if parsed_json["errors"][0] == "Unauthorized"
					 flash[:error] = "Vous n'êtes pas autorisé à effectuer l'action demandé."
				 elsif parsed_json["errors"]["password_confirmation"]
							flash[:error] = "La confirmation ne correspond pas au mot de passe."
				 elsif parsed_json["errors"]["password"]
						flash[:error] = "Le mot de passe doit contenir 8 caractères au minimum."
				 end
				 redirect_to :action => "index", :token => params["user"]["access_token"], :client_id  => params["user"]["client"], :uid => params["user"]["uid"]
		elsif parsed_json["success"] == true
			flash[:success] = "success"
			redirect_to :action => "index"
		else
			flash[:error] = "Erreur Serveur ! Veuillez réessayer plus tard"
			redirect_to :action => "index", :token => params["user"]["access_token"], :client_id  => params["user"]["client"], :uid => params["user"]["uid"]
		end
	end

end
