class Api::V3::SellTypesFilter < Api::V3::BaseFilter

  def collection
    sell_types = self.resource

		unless params[:compagny_id].blank?
			sell_types = sell_types.where('sell_types.compagny_id = ?', params[:compagny_id])
		end

   return self.with_associations(sell_types)
  end

end
