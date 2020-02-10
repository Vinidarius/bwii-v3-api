# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  include DeviseTokenAuth::Concerns::User

	belongs_to :compagny
	has_many :user_type_links

	has_many :needs
	has_many :favorites
	has_many :notes
	has_many :visits

	before_destroy :destroy_associations

	def render_api
		{
			id: self.id,
			created_at: self.created_at,
			firstname: self.firstname,
			lastname: self.lastname,
			email: self.email,
			phone_number: self.phone_number,
			company: self.company,
			job: self.job,
			comparution_text: self.comparution_text,
			cgus: self.cgus,
			ccs: self.ccs,
			archived: self.archived,
			compagny_id: self.compagny_id,
			needs: self.needs.map(&:render_api),
			favorites: self.favorites.map(&:render_user_api),
			notes: self.notes.map(&:render_api)
		}
	end

	def render_list_api
		{
			id: self.id,
			firstname: self.firstname,
			lastname: self.lastname,
			email: self.email,
			company: self.company,
			job: self.job,
			user_type_ids: UserTypeLink.all.where(user_id: self.id).pluck(:user_type_id)
		}
	end

	def render_connect_api
		{
			id: self.id,
			created_at: self.created_at,
			firstname: self.firstname,
			lastname: self.lastname,
			email: self.email,
			phone_number: self.phone_number,
			company: self.company,
			job: self.job,
			comparution_text: self.comparution_text,
			cgus: self.cgus,
			ccs: self.ccs,
			archived: self.archived,
			compagny_id: self.compagny_id,
			text_color: self.compagny.text_color,
			background_color: self.compagny.background_color
		}
	end

	def render_details_api
		{
			id: self.id,
			created_at: self.created_at,
			firstname: self.firstname,
			lastname: self.lastname,
			email: self.email,
			phone_number: self.phone_number,
			company: self.company,
			job: self.job,
			user_type_links: self.user_type_links.map(&:render_details_api),
			current_sign_in_at: self.current_sign_in_at,
			cgus: self.cgus,
			ccs: self.ccs,
			archived: self.archived
		}
	end

	def destroy_associations
		self.user_type_links.destroy_all
		self.favorites.destroy_all
		self.needs.destroy_all
		self.notes.destroy_all
		self.visits.destroy_all
	end

end
