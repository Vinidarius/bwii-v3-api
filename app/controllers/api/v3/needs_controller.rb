class Api::V3::NeedsController < Api::V3::BaseController

	def index
		@needs = Api::V3::NeedsFilter.new(Need.all, params).collection
		render :json => array_serializer(@needs)
	end

	def show
		@need = Need.find_by_id(params[:id])
		return render :json => [] unless !@need.blank?
		render :json => @need.render_api
	end

	def create
		@need = Need.new(permitted_params)
		return render :json => [] unless @need.save
		render(
			json: @need.render_api,
			status: 201,
			location: api_v3_need_path(@need.id)
		)
	end

	def update
		@need = Need.find_by_id(params[:id])
		return render :json => [] unless @need.update_attributes(permitted_params)
		render(
			json: @need.render_api,
			status: 201,
			location: api_v3_need_path(@need.id)
		)
	end

	def destroy
		@need = Need.find(params[:id])
		return api_error(status: 422, errors: @need.errors) unless @need.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_need_path(@need.id)
		)
	end

	private

	def permitted_params
		params.require(:need).permit(
			:name,
			:area_min,
			:area_max,
			:city,
			:zipcode,
			:user_id
		)
	end

	def array_serializer needs
		needs_serialized = Array.new
		needs.each do |need|
			needs_serialized.push(need.render_api)
		end
		needs_serialized
	end

end
