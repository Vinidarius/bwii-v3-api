class Api::V3::UserTypeLinksController < Api::V3::BaseController

	def index
		@user_type_links = Api::V3::UserTypeLinksFilter.new(UserTypeLink.all, params).collection
		render :json => array_serializer(@user_type_links)
	end

	def show
		@user_type_link = UserTypeLink.find_by_id(params[:id])
		return render :json => [] unless !@user_type_link.blank?
		render :json => @user_type_link.render_api
	end

	def create
		@user_type_link = UserTypeLink.new(permitted_params)
		return render :json => [] unless @user_type_link.save
		render(
			json: @user_type_link.render_api,
			status: 201,
			location: api_v3_user_type_link_path(@user_type_link.id)
		)
	end

	def update
		@user_type_link = UserTypeLink.find_by_id(params[:id])
		return render :json => [] unless @user_type_link.update_attributes(permitted_params)
		render(
			json: @user_type_link.render_api,
			status: 201,
			location: api_v3_user_type_link_path(@user_type_link.id)
		)
	end

	def destroy
		@user_type_link = UserTypeLink.find(params[:id]);
		return api_error(status: 422, errors: @user_type_link.errors) unless @user_type_link.destroy
		render(
			json: {},
			status: 204,
			location: api_v3_user_type_link_path(@user_type_link.id)
		)
	end

	private

	def permitted_params
		params.require(:user_type_link).permit(
			:user_id,
			:user_type_id
		)
	end

	def array_serializer user_type_links
		user_type_links_serialized = Array.new
		user_type_links.each do |user_type_link|
			user_type_links_serialized.push(user_type_link.render_api)
		end
		user_type_links_serialized
	end

end
