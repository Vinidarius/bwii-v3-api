class Floor < ApplicationRecord

	belongs_to :real_estate

	has_many :rooms

	def render_api
		{
			id: self.id,
			name: self.name,
			area: self.area,
			divisible: self.divisible,
			terrace: self.terrace,
			rooms: self.rooms.map(&:render_api),
			real_estate_id: self.real_estate_id
		}
	end

end
