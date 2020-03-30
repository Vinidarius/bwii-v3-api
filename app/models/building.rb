class Building < ApplicationRecord

	belongs_to :real_estate

	has_many :floors

	before_destroy :destroy_associations

	def render_api
		{
			id: self.id,
			name: self.name,
			area: self.area,
			divisible: self.divisible,
			fill: self.fill,
			terrace: self.terrace,
			floors: self.floors.map(&:render_api),
			real_estate_id: self.real_estate_id
		}
	end

	def destroy_associations
		self.floors.destroy_all
	end

end
