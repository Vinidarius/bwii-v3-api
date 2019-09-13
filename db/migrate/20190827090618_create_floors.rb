class CreateFloors < ActiveRecord::Migration[5.1]
  def change
    create_table :floors do |t|
			t.string :name
			t.decimal :area, precision: 10, scale: 2, default: 0.0
			t.decimal :divisible, precision: 10, scale: 2
			t.decimal :terrace, precision: 10, scale: 2
			t.integer :number
			t.integer :lot_number
			t.references :real_estate, foreign_key: true

      t.timestamps
    end
  end
end
