class Api::V3::ParkingsFilter < Api::V3::BaseFilter

  def collection
    parkings = self.resource

		unless params[:real_estate_id].blank?
			parkings = parkings.where('parkings.real_estate_id = ?', params[:real_estate_id])
		end

   return self.with_associations(parkings)
  end

end
