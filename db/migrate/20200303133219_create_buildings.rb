class CreateBuildings < ActiveRecord::Migration[5.1]
  def change
    create_table :buildings do |t|
			t.string :name
			t.decimal :area, precision: 10, scale: 2, default: 0.0
			t.decimal :divisible, precision: 10, scale: 2
			t.decimal :terrace, precision: 10, scale: 2
			t.integer :number
			t.references :real_estate, foreign_key: true

      t.timestamps
    end
  end
end
