class ChangeNoteModel < ActiveRecord::Migration[5.1]
  def change
		add_reference :notes, :note_links, foreign_key: true

		remove_reference :notes, :user
		remove_reference :notes, :real_estate

  end
end
