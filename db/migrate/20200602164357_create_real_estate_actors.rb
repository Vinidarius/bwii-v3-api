class CreateRealEstateActors < ActiveRecord::Migration[5.1]
  def change
    create_table :real_estate_actors do |t|
			t.string :title
			t.string :icon

      t.timestamps
    end
  end
end
