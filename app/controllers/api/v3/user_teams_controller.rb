class Api::V3::UserTeamsController < Api::V3::BaseController

	def index
		@user_teams = Api::V3::UserTeamsFilter.new(UserTeam.all, params).collection
		render :json => array_serializer(@user_teams)
	end

	def show
		@user_team = UserTeam.find_by_id(params[:id])
		return render :json => [] unless !@user_team.blank?
		render :json => @user_team.render_api
	end

	def create
		@user_team = UserTeam.new(permitted_params)
		return render :json => [] unless @user_team.save
		render(
			json: @user_team.render_api,
			status: 201,
			location: api_v3_user_team_path(@user_team.id)
		)
	end

	def update
		@user_team = UserTeam.find_by_id(params[:id])
		return render :json => [] unless @user_team.update_attributes(permitted_params)
		render(
			json: @user_team.render_api,
			status: 201,
			location: api_v3_user_team_path(@user_team.id)
		)
	end

	def destroy
		@user_team = UserTeam.find(params[:id]);
		return render :json => [] unless @user_team.destroy
		render(
			json: {},
			status: 201,
			location: api_v3_user_team_path(@user_team.id)
		)
	end

	private

	def permitted_params
		params.require(:user_team).permit(
			:title,
			:icon
		)
	end

	def array_serializer user_teams
		user_teams_serialized = Array.new
		user_teams.each do |user_team|
			user_teams_serialized.push(user_team.render_api)
		end
		user_teams_serialized
	end

end
