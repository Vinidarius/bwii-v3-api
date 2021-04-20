class NoteLink < ApplicationRecord

	belongs_to :note
	belongs_to :real_estate
	belongs_to :user

	def render_api
		{
			id: self.id,
			note_id: Note.find_by(id: self.note_id).render_api,
			real_estate_id: self.real_estate_id,
			user_id: self.user_id,
		}
	end

	def render_details_api
		{
			id: self.id,
			note_id: self.note_id,
			real_estate_id: self.real_estate_id ? RealEstate.find_by(id: self.real_estate_id).render_list_api : nil,
			user_id: self.user_id ? User.find_by(id: self.user_id).render_list_api : nil
		}
	end

end
