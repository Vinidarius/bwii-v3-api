class Room < ApplicationRecord

	belongs_to :floor

	has_many :real_estate_type_links

	def render_api
		{
			id: self.id,
			name: self.name,
			area: self.area,
			divisible: self.divisible,
			terrace: self.terrace,
			floor_id: self.floor_id,
			room_type_links: self.real_estate_type_links.map(&:render_details_api),
		}
	end

end
