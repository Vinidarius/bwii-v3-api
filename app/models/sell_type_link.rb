class SellTypeLink < ApplicationRecord

	belongs_to :real_estate
	belongs_to :sell_type

	def render_api
		{
			id: self.id,
			real_estate_id: RealEstate.find_by(id: self.real_estate_id).render_api,
			sell_type_id: SellType.find_by(id: self.sell_type_id).render_api
		}
	end

	def render_details_api
		{
			id: self.id,
			sell_type_id: SellType.find_by(id: self.sell_type_id).render_api
		}
	end

end
