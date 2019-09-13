class Api::V3::NotesFilter < Api::V3::BaseFilter

  def collection
    notes = self.resource

		unless params[:agent_id].blank?
			notes = notes.where('notes.agent_id = ?', params[:agent_id])
		end

		unless params[:real_estate_id].blank?
			notes = notes.where('notes.real_estate_id = ?', params[:real_estate_id])
		end

		unless params[:user_id].blank?
			notes = notes.where('notes.user_id = ?', params[:user_id])
		end

   return self.with_associations(notes)
  end

end
