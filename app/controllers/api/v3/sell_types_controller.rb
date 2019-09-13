class Api::V3::SellTypesController < Api::V3::BaseController

	def index
		@sell_types = Api::V3::SellTypesFilter.new(SellType.all, params).collection
		render :json => array_serializer(@sell_types)
	end

	def show
		@sell_type = SellType.find_by_id(params[:id])
		return render :json => [] unless !@sell_type.blank?
		render :json => @sell_type.render_api
	end

	def create
		@sell_type = SellType.new(permitted_params)
		return render :json => [] unless @sell_type.save
		render(
			json: @sell_type.render_api,
			status: 201,
			location: api_v3_sell_type_path(@sell_type.id)
		)
	end

	def update
		@sell_type = SellType.find_by_id(params[:id])
		return render :json => [] unless @sell_type.update_attributes(permitted_params)
		render(
			json: @sell_type.render_api,
			status: 201,
			location: api_v3_sell_type_path(@sell_type.id)
		)
	end

	def destroy
		@sell_type = SellType.find(params[:id])
		return api_error(status: 422, errors: @sell_type.errors) unless @sell_type.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_sell_type_path(@sell_type.id)
		)
	end

	private

	def permitted_params
		params.require(:sell_type).permit(
			:name,
			:icon,
			:compagny_id
		)
	end

	def array_serializer sell_types
		sell_types_serialized = Array.new
		sell_types.each do |sell_type|
			sell_types_serialized.push(sell_type.render_api)
		end
		sell_types_serialized
	end

end
