class CreateUserTeamLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_team_links do |t|
			t.references :user_team, foreign_key: true
			t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
