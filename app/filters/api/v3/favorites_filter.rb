class Api::V3::FavoritesFilter < Api::V3::BaseFilter

  def collection
    favorites = self.resource

		unless params[:user_id].blank?
			favorites = favorites.where('favorites.user_id = ?', params[:user_id])
		end

		unless params[:real_estate_id].blank?
			favorites = favorites.where('favorites.real_estate_id = ?', params[:real_estate_id])
		end

   return self.with_associations(favorites)
  end

end
