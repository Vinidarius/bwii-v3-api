class Api::V3::RealEstatesFilter < Api::V3::BaseFilter

  def collection
    real_estates = self.resource

		unless params[:compagny_id].blank?
			real_estates = real_estates.where('real_estates.compagny_id = ?', params[:compagny_id])
		end

   return self.with_associations(real_estates)
  end

end
