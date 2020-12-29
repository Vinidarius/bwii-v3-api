class ChangeVisitAttributes < ActiveRecord::Migration[5.1]
  def change
		rename_column :visits, :valid, :verified
  end
end
