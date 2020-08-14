class NeedLink < ApplicationRecord

	belongs_to :need
	belongs_to :real_estate

	def render_api
		{
			id: self.id,
			created_at: self.created_at,
			need_id: Need.find_by(id: self.need_id).render_api,
			real_estate_id: RealEstate.find_by(id: self.real_estate_id).render_list_api
		}
	end

	def render_id_api
		{
			id: self.id,
			created_at: self.created_at,
			real_estate_id: RealEstate.find_by(id: self.real_estate_id).render_list_api
		}
	end

end
