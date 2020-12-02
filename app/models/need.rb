class Need < ApplicationRecord

	has_many :sector_links
	has_many :real_estate_sell_type_links
	has_many :real_estate_type_links
	has_many :need_links

	before_destroy :destroy_associations

	def render_api
		{
			id: self.id,
			old_id: self.old_id,
			name: self.name,
			area_min: self.area_min,
			area_max: self.area_max,
			city: self.city,
			zipcode: self.zipcode,
			real_estate_type_links: self.real_estate_type_links.map(&:render_details_api),
			sector_links: self.sector_links.map(&:render_id_api),
			# real_estate_sell_type_links: self.real_estate_sell_type_links.map(&:render_id_api)
		}
	end

	def render_list_api
		{
			id: self.id,
			old_id: self.old_id,
			name: self.name,
			area_min: self.area_min,
			area_max: self.area_max,
			city: self.city,
			zipcode: self.zipcode,
			real_estate_type_links: self.real_estate_type_links.map(&:render_details_api),
			sector_links: self.sector_links.map(&:render_id_api),
			# real_estate_sell_type_links: self.real_estate_sell_type_links.map(&:render_id_api),
			real_estates: self.need_links.where.not(real_estate_id: nil).map(&:render_id_api),
			ids: self.need_links.map(&:render_id_list_api)
		}
	end

	def destroy_associations
		self.sector_links.destroy_all
		self.real_estate_sell_type_links.destroy_all
		self.real_estate_type_links.destroy_all
		self.need_links.destroy_all
	end

end
