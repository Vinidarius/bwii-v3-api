class Api::V3::BuildingsController < Api::V3::BaseController

	def index
		@buildings = Api::V3::BuildingsFilter.new(Building.all, params).collection
		render :json => array_serializer(@buildings)
	end

	def show
		@building = Building.find_by_id(params[:id])
		return render :json => [] unless !@building.blank?
		render :json => @building.render_api
	end

	def create
		@building = Building.new(permitted_params)
		return render :json => [] unless @building.save
		render(
			json: @building.render_api,
			status: 201,
			location: api_v3_building_path(@building.id)
		)
	end

	def update
		@building = Building.find_by_id(params[:id])
		return render :json => [] unless @building.update_attributes(permitted_params)
		render(
			json: @building.render_api,
			status: 201,
			location: api_v3_building_path(@building.id)
		)
	end

	def destroy
		@building = Building.find(params[:id]);
		return api_error(status: 422, errors: @building.errors) unless @building.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_building_path(@building.id)
		)
	end

	private

	def permitted_params
		params.require(:building).permit(
			:name,
			:area,
			:divisible,
			:terrace,
			:real_estate_id
		)
	end

	def array_serializer buildings
		buildings_serialized = Array.new
		buildings.each do |building|
			buildings_serialized.push(building.render_api)
		end
		buildings_serialized
	end

end
