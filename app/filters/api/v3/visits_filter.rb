class Api::V3::VisitsFilter < Api::V3::BaseFilter

  def collection
    visits = self.resource

		unless params[:agent_id].blank?
			visits = visits.where('visits.agent_id = ?', params[:agent_id])
		end

		unless params[:real_estate_id].blank?
			visits = visits.where('visits.real_estate_id = ?', params[:real_estate_id])
		end

		unless params[:user_id].blank?
			visits = visits.where('visits.user_id = ?', params[:user_id])
		end

   return self.with_associations(visits.order(date: :desc))
  end

end
