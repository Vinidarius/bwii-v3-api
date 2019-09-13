class Api::V3::FloorsFilter < Api::V3::BaseFilter

  def collection
    floors = self.resource

		unless params[:real_estate_id].blank?
			floors = floors.where('floors.real_estate_id = ?', params[:real_estate_id])
		end

   return self.with_associations(floors)
  end

end
