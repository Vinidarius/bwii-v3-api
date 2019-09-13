class Floor < ApplicationRecord

	belongs_to :real_estate

	def render_api
		{
			id: self.id,
			name: self.name,
			area: self.area,
			divisible: self.divisible,
			terrace: self.terrace,
			number: self.number,
			lot_number: self.lot_number,
			real_estate_id: self.real_estate_id
		}
	end

end
