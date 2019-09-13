class Api::V3::AgentsFilter < Api::V3::BaseFilter

  def collection
    agents = self.resource

		unless params[:compagny_id].blank?
			agents = agents.where('agents.compagny_id = ?', params[:compagny_id])
		end

   return self.with_associations(agents)
  end

end
