class Api::V3::BuildingsFilter < Api::V3::BaseFilter

  def collection
    buildings = self.resource

		unless params[:real_estate_id].blank?
			buildings = buildings.where('buildings.real_estate_id = ?', params[:real_estate_id])
		end

   return self.with_associations(buildings)
  end

end
