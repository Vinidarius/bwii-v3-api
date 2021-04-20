class NoteLink < ApplicationRecord

	belongs_to :note
	belongs_to :real_estate
	belongs_to :user

	def render_api
		{
			id: self.id,
			note_id: Note.find_by(id: self.note_id).render_api,
			real_estate_id: self.real_estate_id.map(&:render_list_api),
			user_id: self.user_id.map(&:render_list_api)
		}
	end

	def render_details_api
		{
			id: self.id,
			note_id: Note.find_by(id: self.note_id).render_api,
			real_estate_id: self.real_estate_id,
			user_id: self.user_id
		}
	end

end
