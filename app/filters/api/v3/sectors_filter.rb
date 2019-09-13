class Api::V3::SectorsFilter < Api::V3::BaseFilter

  def collection
    sectors = self.resource

		unless params[:compagny_id].blank?
			sectors = sectors.where('sectors.compagny_id = ?', params[:compagny_id])
		end

   return self.with_associations(sectors)
  end

end
