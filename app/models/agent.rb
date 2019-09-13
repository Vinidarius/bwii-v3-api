# frozen_string_literal: true

class Agent < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

	belongs_to :compagny
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
			archived: self.archived,
			compagny_id: self.compagny_id
		}
	end

	def render_list_api
		{
			id: self.id,
			firstname: self.firstname,
			lastname: self.lastname
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
			archived: self.archived,
			compagny_id: self.compagny_id,
			text_color: self.compagny.text_color,
			background_color: self.compagny.background_color
		}
	end

	def destroy_associations
		self.notes.destroy_all
		self.visits.destroy_all
	end


end
