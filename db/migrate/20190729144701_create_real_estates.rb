class CreateRealEstates < ActiveRecord::Migration[5.1]
  def change
    create_table :real_estates do |t|
			t.string :title
			t.string :address
			t.string :city
			t.string :zipcode
			t.string :longitude
			t.string :latitude
			t.string :description
			t.string :years
			t.string :dispo
			t.integer :area
			t.integer :charges
			t.integer :foncier
			t.boolean :archived, default: false
			t.boolean :publy, default: false
			t.boolean :verified, default: false
			t.references :compagny, foreign_key: true

      t.timestamps
    end
  end
end
