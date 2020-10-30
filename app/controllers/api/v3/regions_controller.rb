class Api::V3::RegionsController < Api::V3::BaseController

	def index
		@regions = Api::V3::RegionsFilter.new(Region.all, params).collection
		render :json => array_serializer(@regions)
	end

	def show
		@region = Region.find_by_id(params[:id])
		return render :json => [] unless !@region.blank?
		render :json => @region.render_api
	end

	def create
		@region = Region.new(permitted_params)
		return render :json => [] unless @region.save
		render(
			json: @region.render_api,
			status: 201,
			location: api_v3_region_path(@region.id)
		)
	end

	def update
		@region = Region.find_by_id(params[:id])
		return render :json => [] unless @region.update_attributes(permitted_params)
		render(
			json: @region.render_api,
			status: 201,
			location: api_v3_region_path(@region.id)
		)
	end

	def destroy
		@region = Region.find(params[:id])
		return api_error(status: 422, errors: @region.errors) unless @region.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_region_path(@region.id)
		)
	end

	private

	def permitted_params
		params.require(:region).permit(
			:name,
			:number,
		)
	end

	def array_serializer regions
		regions_serialized = Array.new
		regions.each do |region|
			regions_serialized.push(region.render_api)
		end
		regions_serialized
	end

end
