class Api::V3::SectorsController < Api::V3::BaseController

	def index
		@sectors = Api::V3::SectorsFilter.new(Sector.all, params).collection
		render :json => array_serializer(@sectors)
	end

	def show
		@sector = Sector.find_by_id(params[:id])
		return render :json => [] unless !@sector.blank?
		render :json => @sector.render_api
	end

	def create
		@sector = Sector.new(permitted_params)
		return render :json => [] unless @sector.save
		render(
			json: @sector.render_api,
			status: 201,
			location: api_v3_sector_path(@sector.id)
		)
	end

	def update
		@sector = Sector.find_by_id(params[:id])
		return render :json => [] unless @sector.update_attributes(permitted_params)
		render(
			json: @sector.render_api,
			status: 201,
			location: api_v3_sector_path(@sector.id)
		)
	end

	def destroy
		@sector = Sector.find(params[:id])
		return api_error(status: 422, errors: @sector.errors) unless @sector.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_sector_path(@sector.id)
		)
	end

	private

	def permitted_params
		params.require(:sector).permit(
			:name
		)
	end

	def array_serializer sectors
		sectors_serialized = Array.new
		sectors.each do |sector|
			sectors_serialized.push(sector.render_api)
		end
		sectors_serialized
	end

end
