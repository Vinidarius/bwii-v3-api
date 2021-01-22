class Visit < ApplicationRecord

	belongs_to :agent
	belongs_to :real_estate
	belongs_to :user

	def render_api
		{
			id: self.id,
			updated_at: self.updated_at,
			date: self.date,
			body: self.body,
			kind: self.kind,
			verified: self.verified,
			agent_id: self.agent_id,
			real_estate_id: self.real_estate_id,
			user_id: self.user_id,
		}
	end

end
