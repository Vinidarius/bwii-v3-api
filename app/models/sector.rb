class Sector < ApplicationRecord

	belongs_to :compagny
	belongs_to :region

	has_many :sector_links

	before_destroy :destroy_associations

	def render_api
		{
			id: self.id,
			name: self.name,
			text_color: self.text_color,
			background_color: self.background_color,
			region_id: self.region_id,
			compagny_id: self.compagny_id
		}
	end

	def destroy_associations
		self.sector_links.destroy_all
	end

end
