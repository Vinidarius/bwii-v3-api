class Api::V3::RealEstateTypesFilter < Api::V3::BaseFilter

  def collection
    real_estate_types = self.resource

		unless params[:compagny_id].blank?
			real_estate_types = real_estate_types.where('real_estate_types.compagny_id = ?', params[:compagny_id])
		end

   return self.with_associations(real_estate_types)
  end

end
