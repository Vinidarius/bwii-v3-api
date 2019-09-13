class Api::V3::RealEstateTypesController < Api::V3::BaseController

	def index
		@real_estate_types = Api::V3::RealEstateTypesFilter.new(RealEstateType.all, params).collection
		render :json => array_serializer(@real_estate_types)
	end

	def show
		@real_estate_type = RealEstateType.find_by_id(params[:id])
		return render :json => [] unless !@real_estate_type.blank?
		render :json => @real_estate_type.render_api
	end

	def create
		@real_estate_type = RealEstateType.new(permitted_params)
		return render :json => [] unless @real_estate_type.save
		render(
			json: @real_estate_type.render_api,
			status: 201,
			location: api_v3_real_estate_type_path(@real_estate_type.id)
		)
	end

	def update
		@real_estate_type = RealEstateType.find_by_id(params[:id])
		return render :json => [] unless @real_estate_type.update_attributes(permitted_params)
		render(
			json: @real_estate_type.render_api,
			status: 201,
			location: api_v3_real_estate_type_path(@real_estate_type.id)
		)
	end

	def destroy
		@real_estate_type = RealEstateType.find(params[:id])
		return api_error(status: 422, errors: @real_estate_type.errors) unless @real_estate_type.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_real_estate_type_path(@real_estate_type.id)
		)
	end

	private

	def permitted_params
		params.require(:real_estate_type).permit(
			:name,
			:icon,
			:compagny_id
		)
	end

	def array_serializer real_estate_types
		real_estate_types_serialized = Array.new
		real_estate_types.each do |real_estate_type|
			real_estate_types_serialized.push(real_estate_type.render_api)
		end
		real_estate_types_serialized
	end

end
