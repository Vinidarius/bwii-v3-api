class Api::V3::NeedsFilter < Api::V3::BaseFilter

  def collection
    needs = self.resource

		unless params[:user_id].blank?
			needs = needs.where('needs.user_id = ?', params[:user_id])
		end

   return self.with_associations(needs)
  end

end
