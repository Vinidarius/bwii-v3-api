class Api::V3::RealEstateTypeLinksController < Api::V3::BaseController

	def index
		@real_estate_type_links = Api::V3::RealEstateTypeLinksFilter.new(RealEstateTypeLink.all, params).collection
		render :json => array_serializer(@real_estate_type_links)
	end

	def show
		@real_estate_type_link = RealEstateTypeLink.find_by_id(params[:id])
		return render :json => [] unless !@real_estate_type_link.blank?
		render :json => @real_estate_type_link.render_api
	end

	def create
		@real_estate_type_link = RealEstateTypeLink.new(permitted_params)
		return render :json => [] unless @real_estate_type_link.save
		render(
			json: @real_estate_type_link.render_api,
			status: 201,
			location: api_v3_real_estate_type_link_path(@real_estate_type_link.id)
		)
	end

	def update
		@real_estate_type_link = RealEstateTypeLink.find_by_id(params[:id])
		return render :json => [] unless @real_estate_type_link.update_attributes(permitted_params)
		render(
			json: @real_estate_type_link.render_api,
			status: 201,
			location: api_v3_real_estate_type_link_path(@real_estate_type_link.id)
		)
	end

	def destroy
		@real_estate_type_link = RealEstateTypeLink.find(params[:id]);
		return api_error(status: 422, errors: @real_estate_type_link.errors) unless @real_estate_type_link.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_real_estate_type_link_path(@real_estate_type_link.id)
		)
	end

	private

	def permitted_params
		params.require(:real_estate_type_link).permit(
			:need_id,
			:parking_id,
			:room_id,
			:real_estate_id,
			:real_estate_type_id
		)
	end

	def array_serializer real_estate_type_links
		real_estate_type_links_serialized = Array.new
		real_estate_type_links.each do |real_estate_type_link|
			real_estate_type_links_serialized.push(real_estate_type_link.render_api)
		end
		real_estate_type_links_serialized
	end

end
