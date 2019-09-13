class Note < ApplicationRecord

	belongs_to :agent
	belongs_to :real_estate
	belongs_to :user

	def render_api
		{
			id: self.id,
			date: self.date,
			title: self.title,
			body: self.body,
			agent_id: self.agent_id,
			real_estate_id: self.real_estate_id,
			user_id: self.user_id
		}
	end

end
