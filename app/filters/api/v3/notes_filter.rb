class Api::V3::NotesFilter < Api::V3::BaseFilter

  def collection
    notes = self.resource

		unless params[:agent_id].blank?
			notes = notes.where('notes.agent_id = ?', params[:agent_id])
		end

   return self.with_associations(notes.order(updated_at: :desc))
  end

end
