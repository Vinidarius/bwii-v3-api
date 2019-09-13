class CreateSectorLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :sector_links do |t|
			t.references :need, foreign_key: true
			t.references :real_estate, foreign_key: true
			t.references :sector, foreign_key: true

      t.timestamps
    end
  end
end
