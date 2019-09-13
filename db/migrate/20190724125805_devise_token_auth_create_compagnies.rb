class DeviseTokenAuthCreateCompagnies < ActiveRecord::Migration[5.1]
  def change

    create_table(:compagnies) do |t|
      ## Required
      t.string :provider, :null => false, :default => "email"
      t.string :uid, :null => false, :default => ""

      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.boolean  :allow_password_change, :default => false

      ## Rememberable
      t.datetime :remember_created_at

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## User Info
			t.string :name
			t.string :email
			t.string :background_color, default: "#000000"
			t.string :text_color, default: "#FFFFFF"
			t.string :comparution_text
			t.boolean :archived, default: false

      ## Tokens
      t.json :tokens

      t.timestamps
    end

    add_index :compagnies, :email,                unique: true
    add_index :compagnies, [:uid, :provider],     unique: true
    add_index :compagnies, :reset_password_token, unique: true
    add_index :compagnies, :confirmation_token,   unique: true
    # add_index :compagnies, :unlock_token,       unique: true
  end
end
