class Note < ApplicationRecord

	belongs_to :agent
	has_many :note_links

	def render_api
		{
			id: self.id,
			created_at: self.created_at.strftime("%d-%m-%Y"),
			updated_at: self.updated_at.strftime("%d-%m-%Y"),
			date: self.date,
			title: self.title,
			body: self.body,
			note_links: self.note_links.map(&:render_api),
			agent_id: self.agent_id
		}
	end

end
