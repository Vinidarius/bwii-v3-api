class Parking < ApplicationRecord

	belongs_to :real_estate

	def render_api
		{
			id: self.id,
			places_number: self.places_number,
			real_estate_id: self.real_estate_id
		}
	end

end
