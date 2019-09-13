class CreateSellTypeLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :sell_type_links do |t|
			t.references :real_estate, foreign_key: true
			t.references :sell_type, foreign_key: true

      t.timestamps
    end
  end
end
