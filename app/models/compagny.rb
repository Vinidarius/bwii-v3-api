# frozen_string_literal: true

class Compagny < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

	has_many :agents
	has_many :users
	has_many :real_estates
	has_many :sectors

	has_many :user_types
	has_many :real_estates_types
	has_many :sell_types

	before_destroy :destroy_associations

	def render_api
		{
			id: self.id,
			created_at: self.created_at,
			updated_at: self.updated_at,
			name: self.name,
			email: self.email,
			background_color: self.background_color,
			text_color: self.text_color,
			comparution_text: self.comparution_text,
			archived: self.archived
		}
	end

	def render_list_api
		{
			id: self.id,
			name: self.name
		}
	end

	def destroy_associations
		self.agents.destroy_all
		self.users.destroy_all
		self.real_estates.destroy_all
		self.sectors.destroy_all

		self.user_types.destroy_all
		self.real_estates_types.destroy_all
		self.sell_types.destroy_all
	end

end
