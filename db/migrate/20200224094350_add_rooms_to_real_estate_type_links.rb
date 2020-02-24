class AddRoomsToRealEstateTypeLinks < ActiveRecord::Migration[5.1]
  def change
		add_reference :real_estate_type_links, :room, foreign_key: true

  end
end
