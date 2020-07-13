class RealEstateSellTypeLink < ApplicationRecord

	belongs_to :real_estate
	belongs_to :real_estate_sell_type

	def render_api
		{
			id: self.id,
			real_estate_id: RealEstate.find_by(id: self.real_estate_id).render_api,
			real_estate_sell_type_id: RealEstateSellType.find_by(id: self.real_estate_sell_type_id).render_api
		}
	end

	def render_details_api
		{
			id: self.id,
			real_estate_sell_type_id: RealEstateSellType.find_by(id: self.real_estate_sell_type_id).render_api
		}
	end

	def render_id_api
		{
			id: self.id,
			real_estate_id: self.real_estate_id
		}
	end

end
