class Note < ApplicationRecord

	belongs_to :agent
	has_many :note_link

	def render_api
		{
			id: self.id,
			created_at: self.created_at,
			updated_at: self.updated_at,
			date: self.date,
			title: self.title,
			body: self.body,
			agent_id: self.agent_id
		}
	end

end
