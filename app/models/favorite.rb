class Favorite < ApplicationRecord

	belongs_to :real_estate
	belongs_to :user

	def render_api
		{
			id: self.id,
			user_id: self.User.find_by(id: self.user_id).render_list_api,
			real_estate_id: RealEstate.find_by(id: self.real_estate_id).render_list_api
		}
	end

	def render_user_api
		{
			id: self.id,
			real_estate_id: RealEstate.find_by(id: self.real_estate_id).render_list_api
		}
	end

	def render_real_estate_api
		{
			id: self.id,
			user_id: self.User.find_by(id: self.user_id).render_list_api
		}
	end

end
