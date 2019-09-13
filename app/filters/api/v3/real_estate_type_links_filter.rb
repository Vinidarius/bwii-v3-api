class Api::V3::RealEstateTypeLinksFilter < Api::V3::BaseFilter

  def collection
    real_estate_type_links = self.resource

		unless params[:need_id].blank?
			real_estate_type_links = real_estate_type_links.where('real_estate_type_links.need_id = ?', params[:need_id])
		end

		unless params[:parking_id].blank?
			real_estate_type_links = real_estate_type_links.where('real_estate_type_links.parking_id = ?', params[:parking_id])
		end

		unless params[:real_estate_id].blank?
			real_estate_type_links = real_estate_type_links.where('real_estate_type_links.real_estate_id = ?', params[:real_estate_id])
		end

		unless params[:real_estate_type_id].blank?
			real_estate_type_links = real_estate_type_links.where('real_estate_type_links.real_estate_type_id = ?', params[:real_estate_type_id])
		end

   return self.with_associations(real_estate_type_links)
  end

end
