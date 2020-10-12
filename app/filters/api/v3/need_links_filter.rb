class Api::V3::NeedLinksFilter < Api::V3::BaseFilter

  def collection
    @need_links = self.resource

		unless params[:user_id].blank?
			@need_links = @need_links.where(need_id: nil)
			@need_links = @need_links.where('need_links.user_id = ?', params[:user_id])
		end

   return self.with_associations(@need_links.uniq)
  end

end
