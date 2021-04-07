class UserPicture < ApplicationRecord

	belongs_to :user

	def render_api
		{
			id: self.id,
			public_id: self.public_id,
			url: self.url,
			position: self.position,
			angle: self.angle,
			user_id: self.user_id,
		}
	end

end
