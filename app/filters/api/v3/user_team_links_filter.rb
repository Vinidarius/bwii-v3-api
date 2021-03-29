class Api::V3::UserTeamLinksFilter < Api::V3::BaseFilter

  def collection
    user_team_links = self.resource

		unless params[:user_id].blank?
			user_team_links = user_team_links.where('user_team_links.user_id = ?', params[:user_id])
		end

   return self.with_associations(user_team_links)
  end

end
