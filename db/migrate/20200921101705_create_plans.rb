class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
			t.string :public_id
			t.string :url
			t.integer :position
			t.string :title
			t.integer :angle, default: 0
			t.references :real_estate, foreign_key: true

      t.timestamps
    end
  end
end
