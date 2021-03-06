class SectorLink < ApplicationRecord

	belongs_to :real_estate
	belongs_to :need
	belongs_to :sector

	def render_api
		{
			id: self.id,
			real_estate_id: self.real_estate_id ? RealEstate.find_by(id: self.real_estate_id).render_api : nil,
			need_id: self.need_id ? Need.find_by(id: self.need_id).render_api : nil,
			sector_id: Sector.find_by(id: self.sector_id).render_api
		}
	end

	def render_id_api
		{
			id: self.id,
			real_estate_id: self.real_estate_id,
			need_id: self.need_id,
			sector_id: self.sector_id
		}
	end

	def render_details_api
		{
			id: self.id,
			sector_id: Sector.find_by(id: self.sector_id).render_api
		}
	end

end
