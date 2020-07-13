class Api::V3::RealEstateSellTypesController < Api::V3::BaseController

	def index
		@real_estate_sell_types = Api::V3::RealEstateSellTypesFilter.new(RealEstateSellType.all, params).collection
		render :json => array_serializer(@real_estate_sell_types)
	end

	def show
		@real_estate_sell_type = RealEstateSellType.find_by_id(params[:id])
		return render :json => [] unless !@real_estate_sell_type.blank?
		render :json => @real_estate_sell_type.render_api
	end

	def create
		@real_estate_sell_type = RealEstateSellType.new(permitted_params)
		return render :json => [] unless @real_estate_sell_type.save
		render(
			json: @real_estate_sell_type.render_api,
			status: 201,
			location: api_v3_real_estate_sell_type_path(@real_estate_sell_type.id)
		)
	end

	def update
		@real_estate_sell_type = RealEstateSellType.find_by_id(params[:id])
		return render :json => [] unless @real_estate_sell_type.update_attributes(permitted_params)
		render(
			json: @real_estate_sell_type.render_api,
			status: 201,
			location: api_v3_real_estate_sell_type_path(@real_estate_sell_type.id)
		)
	end

	def destroy
		@real_estate_sell_type = RealEstateSellType.find(params[:id])
		return api_error(status: 422, errors: @real_estate_sell_type.errors) unless @real_estate_sell_type.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_real_estate_sell_type_path(@real_estate_sell_type.id)
		)
	end

	private

	def permitted_params
		params.require(:real_estate_sell_type).permit(
			:name,
			:icon,
			:compagny_id
		)
	end

	def array_serializer real_estate_sell_types
		real_estate_sell_types_serialized = Array.new
		real_estate_sell_types.each do |real_estate_sell_type|
			real_estate_sell_types_serialized.push(real_estate_sell_type.render_api)
		end
		real_estate_sell_types_serialized
	end

end
