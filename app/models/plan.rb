class Plan < ApplicationRecord

	belongs_to :real_estate

	def render_api
		{
			id: self.id,
			title: self.title,
			position: self.position,
			angle: self.angle,
			public_id: self.public_id,
			url: self.url,
			real_estate_id: self.real_estate_id
		}
	end

end
