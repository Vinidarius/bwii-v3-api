class CreateNeeds < ActiveRecord::Migration[5.1]
  def change
    create_table :needs do |t|
			t.string :name
			t.float :area_min, precision: 10, scale: 2, default: 0.0
			t.float :area_max, precision: 10, scale: 2, default: 0.0
			t.string :city
			t.string :zipcode
			t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
