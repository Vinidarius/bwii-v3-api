class CreateRealEstateTypeLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :real_estate_type_links do |t|
			t.references :need, foreign_key: true
			t.references :parking, foreign_key: true
			t.references :real_estate, foreign_key: true
			t.references :real_estate_type, foreign_key: true

      t.timestamps
    end
  end
end
