class RealEstateActorLink < ApplicationRecord

	belongs_to :real_estate_actor
	belongs_to :real_estate
	belongs_to :user

	def render_api
		{
			id: self.id,
			real_estate_actor_id: self.real_estate_actor_id,
			real_estate_id: self.real_estate_id,
			user_id: self.user_id,
		}
	end

end
