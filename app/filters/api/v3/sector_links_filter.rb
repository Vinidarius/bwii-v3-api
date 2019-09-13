class Api::V3::SectorLinksFilter < Api::V3::BaseFilter

  def collection
    sector_links = self.resource

		unless params[:real_estate_id].blank?
			sector_links = sector_links.where('sector_links.real_estate_id = ?', params[:real_estate_id])
		end

		unless params[:need_id].blank?
			sector_links = sector_links.where('sector_links.need_id = ?', params[:need_id])
		end

		unless params[:sector_id].blank?
			sector_links = sector_links.where('sector_links.sector_id = ?', params[:sector_id])
		end

   return self.with_associations(sector_links)
  end

end
