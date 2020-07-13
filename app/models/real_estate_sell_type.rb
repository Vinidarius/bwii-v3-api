class RealEstateSellType < ApplicationRecord

	belongs_to :compagny
	has_many :sell_type_links

	before_destroy :destroy_associations

	def render_api
		{
			id: self.id,
			name: self.name,
			icon: self.icon
		}
	end

	def destroy_associations
		self.sell_type_links.destroy_all
	end

end
