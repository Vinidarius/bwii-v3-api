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

	def delete_user
		@need_links = NeedLink.where(need_id: params[:need_id], user_id: params[:user_id])
		return api_error(status: 422, errors: @need_links.errors) unless @need_links.destroy_all
		render(
			json: {},
			status: 204
		)
	end

	def test
		@hasValidNeeds = Api::V3::NeedLinksFilter.new(NeedLink.where(user_id: params[:user_id]), params).need_links
		if @hasValidNeeds.length == 0
			@agent_choice = NeedLink.new({user_id: params[:user_id], real_estate_id: params[:real_estate_id], need_id: nil, agent_choice: true, body: params[:body]})
			@agent_choice.save
		else
			@hasValidNeeds.each do |valid_need|
				@need = NeedLink.new({user_id: params[:user_id], real_estate_id: params[:real_estate_id], need_id: valid_need, agent_choice: false, body: params[:body]})
				@need.save
			end
		end
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
			:user_id,
			:real_estate_id,
			:need_id,
			:agent_choice,
			:body,
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
