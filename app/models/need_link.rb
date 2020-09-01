class NeedLink < ApplicationRecord

	belongs_to :need
	belongs_to :real_estate
	belongs_to :user

	def render_api
		{
			id: self.id,
			created_at: self.created_at,
			need_id: Need.find_by(id: self.need_id).render_api,
			real_estate_id: RealEstate.find_by(id: self.real_estate_id).render_list_api,
			user_id: self.user_id
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
