class Api::V3::UserTypesFilter < Api::V3::BaseFilter

  def collection
    user_types = self.resource

		unless params[:compagny_id].blank?
			user_types = user_types.where('user_types.compagny_id = ?', params[:compagny_id])
		end

   return self.with_associations(user_types)
  end

end
