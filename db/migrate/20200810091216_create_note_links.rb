class CreateNoteLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :note_links do |t|
			t.references :note, foreign_key: true
			t.references :user, foreign_key: true
			t.references :real_estate, foreign_key: true

      t.timestamps
    end
  end
end
