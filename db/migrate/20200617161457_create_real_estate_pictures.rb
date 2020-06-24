class CreateRealEstatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :real_estate_pictures do |t|
			t.string :public_id
			t.string :url
			t.integer :position
			t.references :real_estate, foreign_key: true

      t.timestamps
    end
  end
end
