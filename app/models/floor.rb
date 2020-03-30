class Floor < ApplicationRecord

	belongs_to :building

	has_many :rooms

	before_destroy :destroy_associations

	def render_api
		{
			id: self.id,
			name: self.name,
			area: self.area,
			divisible: self.divisible,
			fill: self.fill,
			terrace: self.terrace,
			rooms: self.rooms.map(&:render_api),
			building_id: self.building_id
		}
	end

	def destroy_associations
		self.rooms.destroy_all
	end

end
