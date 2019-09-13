class Api::V3::FavoritesController < Api::V3::BaseController

	def index
		@favorites = Api::V3::FavoritesFilter.new(Favorite.all, params).collection
		render :json => array_serializer(@favorites)
	end

	def show
		@favorite = Favorite.find_by_id(params[:id])
		return render :json => [] unless !@favorite.blank?
		render :json => @favorite.render_api
	end

	def create
		@favorite = Favorite.new(permitted_params)
		return render :json => [] unless @favorite.save
		render(
			json: @favorite.render_api,
			status: 201,
			location: api_v3_favorite_path(@favorite.id)
		)
	end

	def update
		@favorite = Favorite.find_by_id(params[:id])
		return render :json => [] unless @favorite.update_attributes(permitted_params)
		render(
			json: @favorite.render_api,
			status: 201,
			location: api_v3_favorite_path(@favorite.id)
		)
	end

	def destroy
		@favorite = Favorite.find(params[:id])
		return api_error(status: 422, errors: @favorite.errors) unless @favorite.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_favorite_path(@favorite.id)
		)
	end

	private

	def permitted_params
		params.require(:favorite).permit(
			:user_id,
			:real_estate_id
		)
	end

	def array_serializer favorites
		favorites_serialized = Array.new
		favorites.each do |favorite|
			favorites_serialized.push(favorite.render_api)
		end
		favorites_serialized
	end

end
