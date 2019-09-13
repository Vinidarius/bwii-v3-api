class CreateUserTypeLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_type_links do |t|
			t.references :user, foreign_key: true
			t.references :user_type, foreign_key: true

      t.timestamps
    end
  end
end
