class RealEstateSellTypeLink < ApplicationRecord

	belongs_to :need
	belongs_to :real_estate
	belongs_to :real_estate_sell_type

	def render_api
		{
			id: self.id,
			need_id: self.need_id ? Need.find_by(id: self.need_id).render_api : nil,
			real_estate_id: self.real_estate_id ? RealEstate.find_by(id: self.real_estate_id).render_api : nil,
			real_estate_sell_type_id: RealEstateSellType.find_by(id: self.real_estate_sell_type_id).render_api
		}
	end

	def render_details_api
		{
			id: self.id,
			price: self.price,
			honoraire: self.honoraire,
			global_price: self.global_price,
			real_estate_sell_type_id: RealEstateSellType.find_by(id: self.real_estate_sell_type_id).render_api
		}
	end

	def render_id_api
		{
			id: self.id,
			price: self.price,
			honoraire: self.honoraire,
			global_price: self.global_price,
			real_estate_id: self.real_estate_id,
			real_estate_sell_type_id: self.real_estate_sell_type_id,
			need_id: self.need_id
		}
	end

end
