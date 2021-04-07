class CreateUserPictures < ActiveRecord::Migration[5.1]
  def change
    create_table :user_pictures do |t|
			t.string :public_id
			t.string :url
			t.integer :position
			t.integer :angle, default: 0
			t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
