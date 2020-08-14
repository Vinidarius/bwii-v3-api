class Api::V3::NeedLinksFilter < Api::V3::BaseFilter

  def collection
    @need_links = self.resource

		unless params[:need_id].blank?
			@need_links = @need_links.where('need_links.need_id = ?', params[:need_id])
		end

		unless params[:real_estate_id].blank?
			@need_links = @need_links.where('need_links.real_estate_id = ?', params[:real_estate_id])
		end

		unless params[:user_id].blank?
			@need_links = @need_links.includes(:need).where(need: {user_id: params[:user_id]})
		end

   return self.with_associations(@need_links)
  end

end
