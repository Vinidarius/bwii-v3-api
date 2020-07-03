class RealEstate < ApplicationRecord

	belongs_to :compagny
	has_many :buildings
	has_many :parkings
	has_many :real_estate_pictures

	has_many :favorites
	has_many :notes
	has_many :visits

	has_many :real_estate_type_links
	has_many :real_estate_actor_links
	has_many :sell_type_links
	has_many :sector_links

	before_destroy :destroy_associations

	def render_api
		{
			id: self.id,
			created_at: self.created_at,
			title: self.title,
			real_estate_pictures: self.real_estate_pictures.order(position: :asc).map(&:render_api),
			address: self.address,
			zipcode: self.zipcode,
			city: self.city,
			longitude: self.longitude,
			latitude: self.latitude,
			description: self.description,
			years: self.years,
			dispo: self.dispo,
			area: self.area,
			charges: self.charges,
			foncier: self.foncier,
			buildings: self.buildings.map(&:render_api),
			parkings: self.parkings.map(&:render_api),
			archived: self.archived,
			publy: self.publy,
			verified: self.verified,
			compagny_id: self.compagny_id,
			real_estate_type_links: self.real_estate_type_links.map(&:render_id_api),
			real_estate_actor_links: self.real_estate_actor_links.map(&:render_id_api),
			favorites: self.favorites.map(&:render_real_estate_api),
			notes: self.notes.map(&:render_api)
		}
	end

	def render_list_api
		{
			id: self.id,
			title: self.title,
			real_estate_pictures: self.real_estate_pictures.order(position: :asc).map(&:render_api).first,
			address: self.address,
			zipcode: self.zipcode,
			city: self.city,
			longitude: self.longitude,
			latitude: self.latitude,
			area: self.area
		}
	end

	def destroy_associations
		self.destroy_pictures()

		self.buildings.destroy_all
		self.parkings.destroy_all

		self.favorites.destroy_all
		self.notes.destroy_all
		self.visits.destroy_all

		self.real_estate_type_links.destroy_all
		self.real_estate_actor_links.destroy_all
		self.sell_type_links.destroy_all
		self.sector_links.destroy_all
	end

	def destroy_pictures
		self.real_estate_pictures.each do |real_estate_picture|
			Cloudinary::Uploader.destroy(real_estate_picture.public_id)
		end
	end

end
