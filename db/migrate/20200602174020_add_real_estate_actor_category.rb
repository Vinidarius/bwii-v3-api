class AddRealEstateActorCategory < ActiveRecord::Migration[5.1]
  def change
		add_column :real_estate_actors, :category, :string
  end
end
