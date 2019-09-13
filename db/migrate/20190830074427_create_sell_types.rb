class CreateSellTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :sell_types do |t|
			t.string :name
			t.string :icon
			t.references :compagny, foreign_key: true

      t.timestamps
    end
  end
end
