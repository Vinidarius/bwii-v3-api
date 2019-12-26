class UserTypeLink < ApplicationRecord

	belongs_to :user
	belongs_to :user_type

	def render_api
		{
			id: self.id,
			user_id: User.find_by(id: self.user_id).render_list_api,
			user_type_id: UserType.find_by(id: self.user_type_id).render_api
		}
	end

	def render_details_api
		{
			id: self.id,
			user_type_id: UserType.find_by(id: self.user_type_id).render_api
		}
	end

end
