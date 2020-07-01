class RealEstatePicture < ApplicationRecord

	belongs_to :real_estate

	def render_api
		{
			id: self.id,
			public_id: self.public_id,
			url: self.url,
			position: self.position,
			angle: self.angle,
			real_estate_id: self.real_estate_id,
		}
	end

end
