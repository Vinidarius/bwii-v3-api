class CreateUserTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :user_teams do |t|
			t.string :title
			t.string :icon

      t.timestamps
    end
  end
end
