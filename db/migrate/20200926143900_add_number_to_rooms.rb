class AddNumberToRooms < ActiveRecord::Migration[5.1]
  def change
		add_column :rooms, :number, :integer
  end
end
