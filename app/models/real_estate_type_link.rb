class RealEstateTypeLink < ApplicationRecord

	belongs_to :need
	belongs_to :parking
	belongs_to :real_estate
	belongs_to :real_estate_type

	def render_api
		{
			id: self.id,
			need_id: Need.find_by(id: self.need_id).render_api,
			parking_id: Parking.find_by(id: self.parking_id).render_api,
			real_estate_id: RealEstate.find_by(id: self.real_estate_id).render_api,
			real_estate_type_id: RealEstateType.find_by(id: self.real_estate_type_id).render_api
		}
	end

end
