class Api::V3::NoteLinksFilter < Api::V3::BaseFilter

  def collection
    note_links = self.resource

		unless params[:agent_id].blank?
			note_links = note_links.where('note_links.agent_id = ?', params[:agent_id])
		end

		unless params[:real_estate_id].blank?
			note_links = note_links.where('note_links.real_estate_id = ?', params[:real_estate_id])
		end

		unless params[:user_id].blank?
			note_links = note_links.where('note_links.user_id = ?', params[:user_id])
		end

		unless params[:note_id].blank?
			note_links = note_links.where('note_links.note_id = ?', params[:note_id])
		end

   return self.with_associations(note_links)
  end

end
