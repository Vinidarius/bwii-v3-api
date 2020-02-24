class Room < ApplicationRecord

	belongs_to :floor

	def render_api
		{
			id: self.id,
			area: self.area,
			divisible: self.divisible,
			terrace: self.terrace,
			floor_id: self.floor_id
		}
	end

end
