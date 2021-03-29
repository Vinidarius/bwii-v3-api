class UserTeamLink < ApplicationRecord

		belongs_to :user_team
		belongs_to :user

		def render_api
			{
				id: self.id,
				user_team_id: self.user_team_id ? UserTeam.find_by(id: self.user_team_id).render_api : nil,
				user_id: self.user_id ? User.find_by(id: self.user_id).render_api : nil,
				team_id: self.team_id ? User.find_by(id: self.team_id).render_info_api : nil,
			}
		end

		def render_id_api
			{
				id: self.id,
				user_team_id: self.user_team_id,
				user_id: self.user_id ? User.find_by(id: self.user_id).render_info_api : nil,
				team_id: self.team_id ? User.find_by(id: self.team_id).render_info_api : nil,
			}
		end

end
