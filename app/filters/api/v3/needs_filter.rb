class Api::V3::NeedsFilter < Api::V3::BaseFilter

  def collection
    @needs = self.resource

		unless params[:user_id].blank?
			@needs = @needs.joins(:need_links).where(need_links: {user_id: params[:user_id]})
		end

		if params[:page] && params[:nbr]
			return self.with_associations(@needs.page(params[:page]).per(params[:nbr]))
		end

   return self.with_associations(@needs)
  end

end
