class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
			t.decimal :area, precision: 10, scale: 2, default: 0.0
			t.decimal :divisible, precision: 10, scale: 2
			t.decimal :terrace, precision: 10, scale: 2
			t.references :floor, foreign_key: true

      t.timestamps
    end
  end
end
