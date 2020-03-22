class AddFillToRooms < ActiveRecord::Migration[5.1]
  def change
		add_column :rooms, :fill, :boolean, default: false
  end
end
