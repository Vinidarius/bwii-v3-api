class Need < ApplicationRecord

	belongs_to :user

	has_many :sector_links

	before_destroy :destroy_associations

	def render_api
		{
			id: self.id,
			name: self.name,
			area_min: self.area_min,
			area_max: self.area_max,
			city: self.city,
			zipcode: self.zipcode,
			user_id: self.user_id
		}
	end

	def destroy_associations
		self.sector_links.destroy_all
	end

end
