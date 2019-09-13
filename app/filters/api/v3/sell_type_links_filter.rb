class Api::V3::SellTypeLinksFilter < Api::V3::BaseFilter

  def collection
    sell_type_links = self.resource

		unless params[:real_estate_id].blank?
			sell_type_links = sell_type_links.where('sell_type_links.real_estate_id = ?', params[:real_estate_id])
		end

		unless params[:sell_type_id].blank?
			sell_type_links = sell_type_links.where('sell_type_links.sell_type_id = ?', params[:sell_type_id])
		end

   return self.with_associations(sell_type_links)
  end

end
