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

ActiveRecord::Schema.define(:version => 20101231231441) do

  create_table "destinations", :force => true do |t|
    t.string   "name"
    t.integer  "source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", :force => true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.datetime "last_build_date"
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
  end

  create_table "sources", :force => true do |t|
    t.string   "name"
    t.string   "feed_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stream_id"
  end

  create_table "streams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
