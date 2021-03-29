class Api::V3::UserTeamsFilter < Api::V3::BaseFilter

  def collection
    user_teams = self.resource

   return self.with_associations(user_teams)
  end

end
