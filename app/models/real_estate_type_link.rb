class RealEstateTypeLink < ApplicationRecord

	belongs_to :need
	belongs_to :parking
	belongs_to :room
	belongs_to :real_estate
	belongs_to :real_estate_type

	def render_api
		{
			id: self.id,
			need_id: self.need_id ? Need.find_by(id: self.need_id).render_api : nil,
			parking_id: self.parking_id ? Parking.find_by(id: self.parking_id).render_api : nil,
			room_id: self.room_id ? Room.find_by(id: self.room_id).render_api : nil,
			real_estate_id: self.real_estate_id ? RealEstate.find_by(id: self.real_estate_id).render_api : nil,
			real_estate_type_id: RealEstateType.find_by(id: self.real_estate_type_id).render_api
		}
	end

end
