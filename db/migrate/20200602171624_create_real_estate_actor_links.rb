class CreateRealEstateActorLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :real_estate_actor_links do |t|
			t.references :real_estate_actor, foreign_key: true
			t.references :real_estate, foreign_key: true
			t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
