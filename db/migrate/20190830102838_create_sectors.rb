class CreateSectors < ActiveRecord::Migration[5.1]
  def change
    create_table :sectors do |t|
			t.string :name
			t.string :text_color, default: "#000000"
			t.string :background_color, default: "#FFFFFF"
			t.references :compagny, foreign_key: true

      t.timestamps
    end
  end
end
