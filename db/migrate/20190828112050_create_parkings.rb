class CreateParkings < ActiveRecord::Migration[5.1]
  def change
    create_table :parkings do |t|
			t.integer :places_number
			t.references :real_estate, foreign_key: true

      t.timestamps
    end
  end
end
