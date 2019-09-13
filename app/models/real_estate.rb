class RealEstate < ApplicationRecord

	belongs_to :compagny
	has_many :floors
	has_many :parkings

	has_many :favorites
	has_many :notes
	has_many :visits

	has_many :real_estate_type_links
	has_many :sell_type_links
	has_many :sector_links

	before_destroy :destroy_associations

	def render_api
		{
			id: self.id,
			created_at: self.created_at,
			title: self.title,
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
			floors: self.floors.map(&:render_api),
			parkings: self.parkings.map(&:render_api),
			archived: self.archived,
			publy: self.publy,
			verified: self.verified,
			compagny_id: self.compagny_id,
			favorites: self.favorites.map(&:render_real_estate_api),
			notes: self.notes.map(&:render_api)
		}
	end

	def render_list_api
		{
			id: self.id,
			title: self.title,
			address: self.address,
			zipcode: self.zipcode,
			city: self.city,
			longitude: self.longitude,
			latitude: self.latitude,
			area: self.area
		}
	end

	def destroy_associations
		self.floors.destroy_all
		self.parkings.destroy_all

		self.favorites.destroy_all
		self.notes.destroy_all
		self.visits.destroy_all

		self.real_estate_type_links.destroy_all
		self.sell_type_links.destroy_all
		self.sector_links.destroy_all
	end

end
