class Api::V3::NeedLinksController < Api::V3::BaseController

	def index
		@need_links = Api::V3::NeedLinksFilter.new(NeedLink.all, params).collection
		render :json => array_serializer(@need_links)
	end

	def show
		@need_link = NeedLink.find_by_id(params[:id])
		return render :json => [] unless !@need_link.blank?
		render :json => @need_link.render_api
	end

	def create
		@need_link = NeedLink.new(permitted_params)
		return render :json => [] unless @need_link.save
		render(
			json: @need_link.render_api,
			status: 201,
			location: api_v3_need_link_path(@need_link.id)
		)
	end

	def update
		@need_link = NeedLink.find_by_id(params[:id])
		return render :json => [] unless @need_link.update_attributes(permitted_params)
		render(
			json: @need_link.render_api,
			status: 201,
			location: api_v3_need_link_path(@need_link.id)
		)
	end

	def destroy
		@need_link = NeedLink.find(params[:id])
		return api_error(status: 422, errors: @need_link.errors) unless @need_link.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_need_link_path(@need_link.id)
		)
	end

	private

	def permitted_params
		params.require(:need_link).permit(
			:real_estate_id,
			:need_id
		)
	end

	def array_serializer need_links
		need_links_serialized = Array.new
		need_links.each do |need_link|
			need_links_serialized.push(need_link.render_api)
		end
		need_links_serialized
	end

end
