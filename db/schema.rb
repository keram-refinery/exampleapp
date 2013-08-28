# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20130828144858) do

  create_table "refinery_images", force: true do |t|
    t.string   "image_mime_type", limit: 64, null: false
    t.string   "image_name",                 null: false
    t.integer  "image_size",                 null: false
    t.integer  "image_width",                null: false
    t.integer  "image_height",               null: false
    t.string   "image_uid",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "refinery_images", ["image_name"], name: "index_refinery_images_on_image_name", unique: true, using: :btree
  add_index "refinery_images", ["updated_at"], name: "index_refinery_images_on_updated_at", using: :btree

  create_table "refinery_page_part_translations", force: true do |t|
    t.integer  "refinery_page_part_id", null: false
    t.string   "locale",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body"
  end

  add_index "refinery_page_part_translations", ["locale"], name: "index_refinery_page_part_translations_on_locale", using: :btree
  add_index "refinery_page_part_translations", ["refinery_page_part_id"], name: "index_refinery_page_part_translations_on_refinery_page_part_id", using: :btree

  create_table "refinery_page_parts", force: true do |t|
    t.integer  "page_id",                   null: false
    t.string   "title",                     null: false
    t.integer  "position",   default: 0,    null: false
    t.boolean  "active",     default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "refinery_page_parts", ["page_id", "title"], name: "index_refinery_page_parts_on_page_id_and_title", unique: true, using: :btree

  create_table "refinery_page_translations", force: true do |t|
    t.integer  "refinery_page_id", null: false
    t.string   "locale",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "custom_slug"
    t.string   "menu_title"
    t.string   "slug"
  end

  add_index "refinery_page_translations", ["locale"], name: "index_refinery_page_translations_on_locale", using: :btree
  add_index "refinery_page_translations", ["refinery_page_id"], name: "index_refinery_page_translations_on_refinery_page_id", using: :btree
  add_index "refinery_page_translations", ["slug"], name: "index_refinery_page_translations_on_slug", using: :btree

  create_table "refinery_pages", force: true do |t|
    t.integer  "parent_id"
    t.string   "slug"
    t.boolean  "show_in_menu",        default: true
    t.string   "link_url"
    t.boolean  "deletable",           default: true,          null: false
    t.boolean  "draft",               default: false,         null: false
    t.boolean  "skip_to_first_child", default: false,         null: false
    t.integer  "lft",                                         null: false
    t.integer  "rgt",                                         null: false
    t.integer  "depth",               default: 0,             null: false
    t.string   "view_template",       default: "show",        null: false
    t.string   "layout_template",     default: "application", null: false
    t.string   "plugin_page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "refinery_pages", ["draft", "show_in_menu", "lft", "rgt"], name: "index_refinery_pages_on_draft_and_show_in_menu_and_lft_and_rgt", using: :btree
  add_index "refinery_pages", ["lft", "rgt"], name: "index_refinery_pages_on_lft_and_rgt", using: :btree
  add_index "refinery_pages", ["parent_id"], name: "index_refinery_pages_on_parent_id", using: :btree
  add_index "refinery_pages", ["rgt"], name: "index_refinery_pages_on_rgt", using: :btree
  add_index "refinery_pages", ["updated_at"], name: "index_refinery_pages_on_updated_at", using: :btree

  create_table "refinery_resources", force: true do |t|
    t.string   "file_mime_type", limit: 128, null: false
    t.string   "file_name",                  null: false
    t.integer  "file_size",                  null: false
    t.string   "file_uid",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "refinery_resources", ["file_name"], name: "index_refinery_resources_on_file_name", unique: true, using: :btree
  add_index "refinery_resources", ["updated_at"], name: "index_refinery_resources_on_updated_at", using: :btree

  create_table "refinery_roles", force: true do |t|
    t.string "title", limit: 32, null: false
  end

  add_index "refinery_roles", ["title"], name: "index_refinery_roles_on_title", unique: true, using: :btree

  create_table "refinery_roles_users", id: false, force: true do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
  end

  add_index "refinery_roles_users", ["role_id", "user_id"], name: "index_refinery_roles_users_on_role_id_and_user_id", unique: true, using: :btree
  add_index "refinery_roles_users", ["user_id", "role_id"], name: "index_refinery_roles_users_on_user_id_and_role_id", unique: true, using: :btree

  create_table "refinery_user_plugins", force: true do |t|
    t.integer "user_id",  null: false
    t.string  "name",     null: false
    t.integer "position", null: false
  end

  add_index "refinery_user_plugins", ["name"], name: "index_refinery_user_plugins_on_name", using: :btree
  add_index "refinery_user_plugins", ["user_id", "name"], name: "index_refinery_user_plugins_on_user_id_and_name", unique: true, using: :btree
  add_index "refinery_user_plugins", ["user_id", "position", "name"], name: "index_refinery_user_plugins_on_user_id_and_position_and_name", unique: true, using: :btree

  create_table "refinery_users", force: true do |t|
    t.string   "username",               limit: 64,                null: false
    t.string   "full_name"
    t.string   "email",                                            null: false
    t.string   "encrypted_password",                               null: false
    t.string   "slug",                   limit: 64,                null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "sign_in_count"
    t.datetime "remember_created_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "locale",                 limit: 8,  default: "en", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "refinery_users", ["email"], name: "index_refinery_users_on_email", unique: true, using: :btree
  add_index "refinery_users", ["slug"], name: "index_refinery_users_on_slug", unique: true, using: :btree
  add_index "refinery_users", ["updated_at"], name: "index_refinery_users_on_updated_at", using: :btree
  add_index "refinery_users", ["username"], name: "index_refinery_users_on_username", unique: true, using: :btree

  create_table "seo_meta", force: true do |t|
    t.integer  "seo_meta_id"
    t.string   "seo_meta_type"
    t.string   "browser_title"
    t.text     "meta_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seo_meta", ["id"], name: "index_seo_meta_on_id", using: :btree
  add_index "seo_meta", ["seo_meta_id", "seo_meta_type"], name: "id_type_index_on_seo_meta", using: :btree

end
