class Api::V3::RealEstateSellTypesFilter < Api::V3::BaseFilter

  def collection
    real_estate_sell_types = self.resource

		unless params[:compagny_id].blank?
			real_estate_sell_types = real_estate_sell_types.where('real_estate_sell_types.compagny_id = ?', params[:compagny_id])
		end

   return self.with_associations(real_estate_sell_types)
  end

end
