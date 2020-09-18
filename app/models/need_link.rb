class NeedLink < ApplicationRecord

	belongs_to :need
	belongs_to :real_estate
	belongs_to :user

	def render_api
		{
			id: self.id,
			created_at: self.created_at,
			need_id: self.need_id ? Need.find_by(id: self.need_id).render_api : nil,
			real_estate_id: self.real_estate_id ? RealEstate.find_by(id: self.real_estate_id).render_list_api : nil,
			user_id: self.user_id
		}
	end

	def render_id_api
		{
			id: self.id,
			created_at: self.created_at,
			real_estate_id: self.real_estate_id ? RealEstate.find_by(id: self.real_estate_id).render_list_api : nil,
		}
	end

	def render_id_list_api
		{
			id: self.id,
			real_estate_id: self.real_estate_id,
			need_id: self.need_id,
			user_id: self.user_id
		}
	end

	def render_user_api
		{
			id: self.id,
			created_at: self.created_at,
			need_id: self.need_id ? Need.find_by(id: self.need_id).render_api : nil,
			real_estate_id: self.real_estate_id ? RealEstate.find_by(id: self.real_estate_id).render_list_api : nil
		}
	end

end
