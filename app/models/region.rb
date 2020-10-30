class Region < ApplicationRecord

	has_many :sectors

	before_destroy :destroy_associations

	def render_api
		{
			id: self.id,
			name: self.name,
			number: self.number,
			sectors: self.sectors
		}
	end

	def destroy_associations
		self.sectors.destroy_all
	end

end
