# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  include DeviseTokenAuth::Concerns::User

	belongs_to :compagny
	has_many :user_type_links

	# has_many :favorites
	has_many :visits
	has_many :real_estate_actor_links
	has_many :note_links
	has_many :need_links
	has_many :real_estate_type_links, through: :needs
	has_many :sector_links, through: :needs

	before_destroy :destroy_associations

	def render_api
		{
			id: self.id,
			old_id: self.old_id,
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
			need_links: self.need_links.map(&:render_user_api),
			# favorites: self.favorites.map(&:render_user_api),
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
			connectStatus: self.connectStatus
		}
	end

	def render_info_api
		{
			id: self.id,
			firstname: self.firstname,
			lastname: self.lastname,
			email: self.email,
			phone_number: self.phone_number
		}
	end

	def connectStatus
		if self.current_sign_in_at == nil || self.current_sign_in_at < DateTime.now.beginning_of_day - 15.days
			return "red"
		elsif self.current_sign_in_at < DateTime.now.beginning_of_day - 8.days && self.current_sign_in_at > DateTime.now.beginning_of_day - 14.days
			return "orange"
		elsif self.current_sign_in_at > DateTime.now.beginning_of_day - 7.days
			return "green"
		end
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
			old_id: self.old_id,
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
		# self.favorites.destroy_all
		self.need_links.destroy_all
		self.note_links.destroy_all
		self.visits.destroy_all
		self.real_estate_actor_links.destroy_all
	end

end
