class SectorLink < ApplicationRecord

	belongs_to :real_estate
	belongs_to :need
	belongs_to :sector

	def render_api
		{
			id: self.id,
			real_estate_id: RealEstate.find_by(id: self.real_estate_id).render_api,
			need_id: Need.find_by(id: self.need_id).render_api,
			sector_id: Sector.find_by(id: self.sector_id).render_api
		}
	end

end
