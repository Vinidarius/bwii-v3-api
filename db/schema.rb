# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20201013070949) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agents", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "email"
    t.string "firstname"
    t.string "lastname"
    t.string "phone_number"
    t.boolean "archived", default: false
    t.bigint "compagny_id"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["compagny_id"], name: "index_agents_on_compagny_id"
    t.index ["confirmation_token"], name: "index_agents_on_confirmation_token", unique: true
    t.index ["email"], name: "index_agents_on_email", unique: true
    t.index ["reset_password_token"], name: "index_agents_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_agents_on_uid_and_provider", unique: true
  end

  create_table "buildings", force: :cascade do |t|
    t.string "name"
    t.decimal "area", precision: 10, scale: 2, default: "0.0"
    t.decimal "divisible", precision: 10, scale: 2
    t.decimal "terrace", precision: 10, scale: 2
    t.integer "number"
    t.bigint "real_estate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "fill"
    t.index ["real_estate_id"], name: "index_buildings_on_real_estate_id"
  end

  create_table "compagnies", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "email"
    t.string "background_color", default: "#000000"
    t.string "text_color", default: "#FFFFFF"
    t.string "comparution_text"
    t.boolean "archived", default: false
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_compagnies_on_confirmation_token", unique: true
    t.index ["email"], name: "index_compagnies_on_email", unique: true
    t.index ["reset_password_token"], name: "index_compagnies_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_compagnies_on_uid_and_provider", unique: true
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "real_estate_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["real_estate_id"], name: "index_favorites_on_real_estate_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "floors", force: :cascade do |t|
    t.string "name"
    t.decimal "area", precision: 10, scale: 2, default: "0.0"
    t.decimal "divisible", precision: 10, scale: 2
    t.decimal "terrace", precision: 10, scale: 2
    t.integer "number"
    t.integer "lot_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "building_id"
    t.integer "fill"
    t.index ["building_id"], name: "index_floors_on_building_id"
  end

  create_table "need_links", force: :cascade do |t|
    t.bigint "need_id"
    t.bigint "real_estate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.boolean "agent_choice", default: false
    t.index ["need_id"], name: "index_need_links_on_need_id"
    t.index ["real_estate_id"], name: "index_need_links_on_real_estate_id"
    t.index ["user_id"], name: "index_need_links_on_user_id"
  end

  create_table "needs", force: :cascade do |t|
    t.string "name"
    t.float "area_min", default: 0.0
    t.float "area_max", default: 0.0
    t.string "city"
    t.string "zipcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "note_links", force: :cascade do |t|
    t.bigint "note_id"
    t.bigint "user_id"
    t.bigint "real_estate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["note_id"], name: "index_note_links_on_note_id"
    t.index ["real_estate_id"], name: "index_note_links_on_real_estate_id"
    t.index ["user_id"], name: "index_note_links_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.string "title"
    t.string "date"
    t.string "body"
    t.bigint "agent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "note_links_id"
    t.index ["agent_id"], name: "index_notes_on_agent_id"
    t.index ["note_links_id"], name: "index_notes_on_note_links_id"
  end

  create_table "parkings", force: :cascade do |t|
    t.integer "places_number"
    t.bigint "real_estate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "nature", default: false
    t.integer "price"
    t.integer "sell_method"
    t.index ["real_estate_id"], name: "index_parkings_on_real_estate_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "public_id"
    t.string "url"
    t.integer "position"
    t.string "title"
    t.integer "angle", default: 0
    t.bigint "real_estate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["real_estate_id"], name: "index_plans_on_real_estate_id"
  end

  create_table "real_estate_actor_links", force: :cascade do |t|
    t.bigint "real_estate_actor_id"
    t.bigint "real_estate_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["real_estate_actor_id"], name: "index_real_estate_actor_links_on_real_estate_actor_id"
    t.index ["real_estate_id"], name: "index_real_estate_actor_links_on_real_estate_id"
    t.index ["user_id"], name: "index_real_estate_actor_links_on_user_id"
  end

  create_table "real_estate_actors", force: :cascade do |t|
    t.string "title"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.boolean "multiple", default: false
  end

  create_table "real_estate_pictures", force: :cascade do |t|
    t.string "public_id"
    t.string "url"
    t.integer "position"
    t.bigint "real_estate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "angle", default: 0
    t.index ["real_estate_id"], name: "index_real_estate_pictures_on_real_estate_id"
  end

  create_table "real_estate_sell_type_links", force: :cascade do |t|
    t.bigint "real_estate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "real_estate_sell_type_id"
    t.bigint "need_id"
    t.integer "price"
    t.integer "honoraire"
    t.integer "global_price"
    t.index ["need_id"], name: "index_real_estate_sell_type_links_on_need_id"
    t.index ["real_estate_id"], name: "index_real_estate_sell_type_links_on_real_estate_id"
    t.index ["real_estate_sell_type_id"], name: "index_real_estate_sell_type_links_on_real_estate_sell_type_id"
  end

  create_table "real_estate_sell_types", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.bigint "compagny_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["compagny_id"], name: "index_real_estate_sell_types_on_compagny_id"
  end

  create_table "real_estate_type_links", force: :cascade do |t|
    t.bigint "need_id"
    t.bigint "parking_id"
    t.bigint "real_estate_id"
    t.bigint "real_estate_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "room_id"
    t.index ["need_id"], name: "index_real_estate_type_links_on_need_id"
    t.index ["parking_id"], name: "index_real_estate_type_links_on_parking_id"
    t.index ["real_estate_id"], name: "index_real_estate_type_links_on_real_estate_id"
    t.index ["real_estate_type_id"], name: "index_real_estate_type_links_on_real_estate_type_id"
    t.index ["room_id"], name: "index_real_estate_type_links_on_room_id"
  end

  create_table "real_estate_types", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.bigint "compagny_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["compagny_id"], name: "index_real_estate_types_on_compagny_id"
  end

  create_table "real_estates", force: :cascade do |t|
    t.string "title"
    t.string "address"
    t.string "city"
    t.string "zipcode"
    t.string "longitude"
    t.string "latitude"
    t.string "description"
    t.string "years"
    t.string "dispo"
    t.integer "area"
    t.integer "charges"
    t.integer "foncier"
    t.boolean "archived", default: false
    t.boolean "publy", default: false
    t.boolean "verified", default: false
    t.bigint "compagny_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["compagny_id"], name: "index_real_estates_on_compagny_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.decimal "area", precision: 10, scale: 2, default: "0.0"
    t.decimal "divisible", precision: 10, scale: 2
    t.decimal "terrace", precision: 10, scale: 2
    t.bigint "floor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "fill", default: false
    t.integer "number"
    t.index ["floor_id"], name: "index_rooms_on_floor_id"
  end

  create_table "sector_links", force: :cascade do |t|
    t.bigint "need_id"
    t.bigint "real_estate_id"
    t.bigint "sector_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["need_id"], name: "index_sector_links_on_need_id"
    t.index ["real_estate_id"], name: "index_sector_links_on_real_estate_id"
    t.index ["sector_id"], name: "index_sector_links_on_sector_id"
  end

  create_table "sectors", force: :cascade do |t|
    t.string "name"
    t.string "text_color", default: "#000000"
    t.string "background_color", default: "#FFFFFF"
    t.bigint "compagny_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["compagny_id"], name: "index_sectors_on_compagny_id"
  end

  create_table "user_type_links", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "user_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_type_links_on_user_id"
    t.index ["user_type_id"], name: "index_user_type_links_on_user_type_id"
  end

  create_table "user_types", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.bigint "compagny_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["compagny_id"], name: "index_user_types_on_compagny_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.string "phone_number"
    t.string "company"
    t.string "job"
    t.string "comparution_text"
    t.boolean "cgus", default: false
    t.boolean "ccs", default: false
    t.boolean "archived", default: false
    t.bigint "compagny_id"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["compagny_id"], name: "index_users_on_compagny_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "visits", force: :cascade do |t|
    t.string "date"
    t.string "body"
    t.boolean "kind"
    t.boolean "valid"
    t.bigint "agent_id"
    t.bigint "real_estate_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_visits_on_agent_id"
    t.index ["real_estate_id"], name: "index_visits_on_real_estate_id"
    t.index ["user_id"], name: "index_visits_on_user_id"
  end

  add_foreign_key "agents", "compagnies"
  add_foreign_key "buildings", "real_estates"
  add_foreign_key "favorites", "real_estates"
  add_foreign_key "favorites", "users"
  add_foreign_key "floors", "buildings"
  add_foreign_key "need_links", "needs"
  add_foreign_key "need_links", "real_estates"
  add_foreign_key "need_links", "users"
  add_foreign_key "note_links", "notes"
  add_foreign_key "note_links", "real_estates"
  add_foreign_key "note_links", "users"
  add_foreign_key "notes", "agents"
  add_foreign_key "notes", "note_links", column: "note_links_id"
  add_foreign_key "parkings", "real_estates"
  add_foreign_key "plans", "real_estates"
  add_foreign_key "real_estate_actor_links", "real_estate_actors"
  add_foreign_key "real_estate_actor_links", "real_estates"
  add_foreign_key "real_estate_actor_links", "users"
  add_foreign_key "real_estate_pictures", "real_estates"
  add_foreign_key "real_estate_sell_type_links", "needs"
  add_foreign_key "real_estate_sell_type_links", "real_estate_sell_types"
  add_foreign_key "real_estate_sell_type_links", "real_estates"
  add_foreign_key "real_estate_sell_types", "compagnies"
  add_foreign_key "real_estate_type_links", "needs"
  add_foreign_key "real_estate_type_links", "parkings"
  add_foreign_key "real_estate_type_links", "real_estate_types"
  add_foreign_key "real_estate_type_links", "real_estates"
  add_foreign_key "real_estate_type_links", "rooms"
  add_foreign_key "real_estate_types", "compagnies"
  add_foreign_key "real_estates", "compagnies"
  add_foreign_key "rooms", "floors"
  add_foreign_key "sector_links", "needs"
  add_foreign_key "sector_links", "real_estates"
  add_foreign_key "sector_links", "sectors"
  add_foreign_key "sectors", "compagnies"
  add_foreign_key "user_type_links", "user_types"
  add_foreign_key "user_type_links", "users"
  add_foreign_key "user_types", "compagnies"
  add_foreign_key "users", "compagnies"
  add_foreign_key "visits", "agents"
  add_foreign_key "visits", "real_estates"
  add_foreign_key "visits", "users"
end
