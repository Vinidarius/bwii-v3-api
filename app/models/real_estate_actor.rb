class RealEstateActor < ApplicationRecord

	has_many :real_estate_type_links

	before_destroy :destroy_associations

	def render_api
		{
			id: self.id,
			title: self.title,
			icon: self.icon,
		}
	end

	def destroy_associations
		self.real_estate_actor_links.destroy_all
	end

end
