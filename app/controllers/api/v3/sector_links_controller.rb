class Api::V3::SectorLinksController < Api::V3::BaseController

	def index
		@sector_links = Api::V3::SectorLinksFilter.new(SectorLink.all, params).collection
		render :json => array_serializer(@sector_links)
	end

	def show
		@sector_link = SectorLink.find_by_id(params[:id])
		return render :json => [] unless !@sector_link.blank?
		render :json => @sector_link.render_api
	end

	def create
		@sector_link = SectorLink.new(permitted_params)
		return render :json => [] unless @sector_link.save
		render(
			json: @sector_link.render_api,
			status: 201,
			location: api_v3_sector_link_path(@sector_link.id)
		)
	end

	def update
		@sector_link = SectorLink.find_by_id(params[:id])
		return render :json => [] unless @sector_link.update_attributes(permitted_params)
		render(
			json: @sector_link.render_api,
			status: 201,
			location: api_v3_sector_link_path(@sector_link.id)
		)
	end

	def destroy
		@sector_link = SectorLink.find(params[:id])
		return api_error(status: 422, errors: @sector_link.errors) unless @sector_link.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_sector_link_path(@sector_link.id)
		)
	end

	private

	def permitted_params
		params.require(:sector_link).permit(
			:need_id,
			:real_estate_id,
			:sector_id
		)
	end

	def array_serializer sector_links
		sector_links_serialized = Array.new
		sector_links.each do |sector_link|
			sector_links_serialized.push(sector_link.render_api)
		end
		sector_links_serialized
	end

end
