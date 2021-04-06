class Api::V3::UserTeamLinksController < Api::V3::BaseController

	def index
		@user_team_links = Api::V3::UserTeamLinksFilter.new(UserTeamLink.all, params).collection
		render :json => array_serializer(@user_team_links)
	end

	def show
		@user_team_link = UserTeamLink.find_by_id(params[:id])
		return render :json => [] unless !@user_team_link.blank?
		render :json => @user_team_link.render_api
	end

	def create
		if UserTeamLink.exists?(user_id: params[:user_id], user_team_id: params[:user_team_id])
			params[:id] = UserTeamLink.find_by(user_id: params[:user_id], user_team_id: params[:user_team_id]).id
			self.update();
		else
			@user_team_link = UserTeamLink.new(permitted_params)
			return render :json => [] unless @user_team_link.save
			render(
				json: @user_team_link.render_api,
				status: 201,
				location: api_v3_user_team_link_path(@user_team_link.id)
			)
		end
	end

	def update
		@user_team_link = UserTeamLink.find_by_id(params[:id])
		return render :json => [] unless @user_team_link.update_attributes(permitted_params)
		render(
			json: @user_team_link.render_api,
			status: 201,
			location: api_v3_user_team_link_path(@user_team_link.id)
		)
	end

	def destroy
		@user_team_link = UserTeamLink.find(params[:id]);
		return render :json => [] unless @user_team_link.destroy
		render(
			json: {},
			status: 201,
			location: api_v3_user_team_link_path(@user_team_link.id)
		)
	end

	private

	def permitted_params
		params.require(:user_team_link).permit(
			:user_team_id,
			:user_id,
			:team_id
		)
	end

	def array_serializer user_team_links
		user_team_links_serialized = Array.new
		user_team_links.each do |user_team_link|
			user_team_links_serialized.push(user_team_link.render_api)
		end
		user_team_links_serialized
	end

end
