class Api::V3::RealEstateSellTypeLinksFilter < Api::V3::BaseFilter

  def collection
    real_estate_sell_type_links = self.resource

		unless params[:real_estate_id].blank?
			real_estate_sell_type_links = real_estate_sell_type_links.where('real_estate_sell_type_links.real_estate_id = ?', params[:real_estate_id])
		end

		unless params[:real_estate_sell_type_id].blank?
			real_estate_sell_type_links = real_estate_sell_type_links.where('real_estate_sell_type_links.real_estate_sell_type_id = ?', params[:real_estate_sell_type_id])
		end

   return self.with_associations(real_estate_sell_type_links)
  end

end
