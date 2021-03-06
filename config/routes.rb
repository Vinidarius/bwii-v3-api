Rails.application.routes.default_url_options[:host] = "staging-bwii-v3-api.herokuapp.com"

Rails.application.routes.draw do

	namespace :api do
		namespace :v3 do

			mount_devise_token_auth_for 'Compagny', at: 'auth_compagnies'
			mount_devise_token_auth_for 'Agent', at: 'auth_agents'
			mount_devise_token_auth_for 'User', at: 'auth_users'

			resources :compagnies, only: [:index, :show, :create, :update, :destroy]
			resources :agents, only: [:index, :show, :create, :update, :destroy]

			resources :users, only: [:index, :show, :create, :update, :destroy]
			resources :user_pictures, only: [:index, :show, :create, :update, :destroy]

			resources :user_types, only: [:index, :show, :create, :update, :destroy]
			resources :user_type_links, only: [:index, :show, :create, :update, :destroy]

			resources :real_estates, only: [:index, :show, :create, :update, :destroy]
			resources :real_estate_pictures, only: [:index, :show, :create, :update, :destroy]
			resources :buildings, only: [:create, :update, :destroy]
			resources :floors, only: [:create, :update, :destroy]
			resources :rooms, only: [:create, :update, :destroy]
			resources :parkings, only: [:create, :update, :destroy]
			resources :plans, only: [:index, :show, :create, :update, :destroy]

			resources :real_estate_types, only: [:index, :show, :create, :update, :destroy]
			resources :real_estate_type_links, only: [:index, :show, :create, :update, :destroy]

			resources :real_estate_actors, only: [:index, :show, :create, :update, :destroy]
			resources :real_estate_actor_links, only: [:index, :show, :create, :update, :destroy]

			resources :user_teams, only: [:index, :show, :create, :update, :destroy]
			resources :user_team_links, only: [:index, :show, :create, :update, :destroy]

			resources :real_estate_sell_types, only: [:index, :show, :create, :update, :destroy]
			resources :real_estate_sell_type_links, only: [:index, :show, :create, :update, :destroy]

			resources :sector_links, only: [:index, :show, :create, :update, :destroy]

			resources :needs, only: [:index, :shown, :create, :update, :destroy]
			resources :need_links, only: [:index, :shown, :create, :update, :destroy]
			resources :favorites, only: [:index, :shown, :create, :update, :destroy]
			resources :notes, only: [:index, :shown, :create, :update, :destroy]
			resources :note_links, only: [:index, :shown, :create, :update, :destroy]
			resources :visits, only: [:index, :shown, :create, :update, :destroy]

			resources :regions, only: [:index, :shown, :create, :update, :destroy]
			resources :sectors, only: [:index, :shown, :create, :update, :destroy]

			get '/compagnies_list', to: 'compagnies#list'

			get '/agents_list', to: 'agents#list'
			get '/agents_connect/:id', to: 'agents#connect'

			get '/users_list', to: 'users#list'
			get '/users_connect/:id', to: 'users#connect'
			get '/users_details/:id', to: 'users#details'

			get '/real_estates_list', to: 'real_estates#list'
			get '/real_estate_details/:id', to: 'real_estates#details'
			post '/real_estate_duplicate/:id', to: 'real_estates#duplicate'
			get '/real_estates_all', to: 'real_estates#all'

			get '/needs_list', to: 'needs#list'
			get '/need_link_delete', to: 'need_links#destroy'
			delete '/user_needs', to: 'need_links#delete_user'

			get 'password_users', to: 'password_users#index'
			put 'password_users', to: 'password_users#update'

		end
	end

end
