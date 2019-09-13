class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
			t.string :title
			t.string :date
			t.string :body
			t.references :agent, foreign_key: true
			t.references :real_estate, foreign_key: true
			t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
