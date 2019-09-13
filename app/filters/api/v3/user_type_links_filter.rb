class Api::V3::UserTypeLinksFilter < Api::V3::BaseFilter

  def collection
    user_type_links = self.resource

		unless params[:user_id].blank?
			user_type_links = user_type_links.where('user_type_links.user_id = ?', params[:user_id])
		end

		unless params[:user_type_id].blank?
			user_type_links = user_type_links.where('user_type_links.user_type_id = ?', params[:user_type_id])
		end

   return self.with_associations(user_type_links)
  end

end
