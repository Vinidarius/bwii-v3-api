class Parking < ApplicationRecord

	belongs_to :real_estate

	def render_api
		{
			id: self.id,
			real_estate_id: self.real_estate_id,
			places_number: self.places_number,
			price: self.price,
			nature: self.nature,
			sell_method: self.sell_method,
		}
	end

end
