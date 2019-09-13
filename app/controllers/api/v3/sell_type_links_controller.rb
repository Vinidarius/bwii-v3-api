class Api::V3::SellTypeLinksController < Api::V3::BaseController

	def index
		@sell_type_links = Api::V3::SellTypeLinksFilter.new(SellTypeLink.all, params).collection
		render :json => array_serializer(@sell_type_links)
	end

	def show
		@sell_type_link = SellTypeLink.find_by_id(params[:id])
		return render :json => [] unless !@sell_type_link.blank?
		render :json => @sell_type_link.render_api
	end

	def create
		@sell_type_link = SellTypeLink.new(permitted_params)
		return render :json => [] unless @sell_type_link.save
		render(
			json: @sell_type_link.render_api,
			status: 201,
			location: api_v3_sell_type_link_path(@sell_type_link.id)
		)
	end

	def update
		@sell_type_link = SellTypeLink.find_by_id(params[:id])
		return render :json => [] unless @sell_type_link.update_attributes(permitted_params)
		render(
			json: @sell_type_link.render_api,
			status: 201,
			location: api_v3_sell_type_link_path(@sell_type_link.id)
		)
	end

	def destroy
		@sell_type_link = SellTypeLink.find(params[:id])
		return api_error(status: 422, errors: @sell_type_link.errors) unless @sell_type_link.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_sell_type_link_path(@sell_type_link.id)
		)
	end

	private

	def permitted_params
		params.require(:sell_type_link).permit(
			:real_estate_id,
			:sell_type_id
		)
	end

	def array_serializer sell_type_links
		sell_type_links_serialized = Array.new
		sell_type_links.each do |sell_type_link|
			sell_type_links_serialized.push(sell_type_link.render_api)
		end
		sell_type_links_serialized
	end

end
