class Api::V3::RealEstateActorsController < Api::V3::BaseController

	def index
		@real_estate_actors = Api::V3::RealEstateActorsFilter.new(RealEstateActor.all, params).collection
		render :json => array_serializer(@real_estate_actors)
	end

	def show
		@real_estate_actor = RealEstateActor.find_by_id(params[:id])
		return render :json => [] unless !@real_estate_actor.blank?
		render :json => @real_estate_actor.render_api
	end

	def create
		@real_estate_actor = RealEstateActor.new(permitted_params)
		return render :json => [] unless @real_estate_actor.save
		render(
			json: @real_estate_actor.render_api,
			status: 201,
			location: api_v3_real_estate_actor_path(@real_estate_actor.id)
		)
	end

	def update
		@real_estate_actor = RealEstateActor.find_by_id(params[:id])
		return render :json => [] unless @real_estate_actor.update_attributes(permitted_params)
		render(
			json: @real_estate_actor.render_api,
			status: 201,
			location: api_v3_real_estate_actor_path(@real_estate_actor.id)
		)
	end

	def destroy
		@real_estate_actor = RealEstateActor.find(params[:id]);
		return render :json => [] unless @real_estate_actor.destroy
		render(
			json: {},
			status: 201,
			location: api_v3_real_estate_actor_path(@real_estate_actor.id)
		)
	end

	private

	def permitted_params
		params.require(:real_estate_actor).permit(
			:title,
			:icon,
			:category,
			:multiple
		)
	end

	def array_serializer real_estate_actors
		real_estate_actors_serialized = Array.new
		real_estate_actors.each do |real_estate_actor|
			real_estate_actors_serialized.push(real_estate_actor.render_api)
		end
		real_estate_actors_serialized
	end

end
