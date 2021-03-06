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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110426232436) do

  create_table "email_lists", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "recipients_text"
  end

  create_table "email_lists_streams", :id => false, :force => true do |t|
    t.integer "email_list_id"
    t.integer "stream_id"
  end

  create_table "facebook_accounts", :force => true do |t|
    t.string   "access_token"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "facebook_id"
    t.string   "link"
    t.string   "name"
  end

  add_index "facebook_accounts", ["facebook_id"], :name => "index_facebook_accounts_on_facebook_id", :unique => true

  create_table "facebook_accounts_streams", :id => false, :force => true do |t|
    t.integer "facebook_account_id"
    t.integer "stream_id"
  end

  create_table "feeds", :force => true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.datetime "last_build_date"
    t.integer  "user_id"
    t.string   "title"
  end

  create_table "feeds_streams", :id => false, :force => true do |t|
    t.integer "feed_id"
    t.integer "stream_id"
  end

  create_table "items", :force => true do |t|
    t.integer  "feed_id"
    t.string   "title"
    t.text     "body"
    t.boolean  "shared",         :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_date"
    t.string   "link"
    t.string   "status_id"
    t.string   "bitly_url"
    t.text     "categories"
  end

  create_table "recipients", :force => true do |t|
    t.string  "email_address"
    t.integer "email_list_id"
    t.string  "hash_value"
  end

  create_table "streams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "active",              :default => true
    t.string   "included_categories"
  end

  create_table "streams_twitter_accounts", :id => false, :force => true do |t|
    t.integer "stream_id"
    t.integer "twitter_account_id"
  end

  create_table "twitter_accounts", :force => true do |t|
    t.string   "handle"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_token"
    t.string   "access_token_secret"
    t.integer  "user_id"
    t.boolean  "active",              :default => true
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
