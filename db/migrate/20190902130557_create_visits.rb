class CreateVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
			t.string :date
			t.string :body
			t.boolean :kind
			t.boolean :valid
			t.references :agent, foreign_key: true
			t.references :real_estate, foreign_key: true
			t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
