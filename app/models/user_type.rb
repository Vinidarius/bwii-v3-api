class UserType < ApplicationRecord

	has_many :user_type_links
	belongs_to :compagny

	before_destroy :destroy_associations

	def render_api
		{
			id: self.id,
			name: self.name,
			icon: self.icon
		}
	end

	def destroy_associations
		self.user_type_links.destroy_all
	end

end
