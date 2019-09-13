class Api::V3::UsersFilter < Api::V3::BaseFilter

  def collection
    users = self.resource

		unless params[:compagny_id].blank?
			users = users.where('users.compagny_id = ?', params[:compagny_id])
		end

   return self.with_associations(users)
  end

end
