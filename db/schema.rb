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

ActiveRecord::Schema.define(version: 20170915102724) do

  create_table "activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.date "begin_time"
    t.date "end_time"
    t.string "desc"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "award_count"
    t.string "status", default: "00X"
  end

  create_table "activity_award_cfgs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "level_I"
    t.integer "score"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "00A"
  end

  create_table "activity_awards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "catalog"
    t.integer "rate"
    t.integer "activity_award_cfg_id"
    t.integer "activity_base_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "activity_id"
    t.integer "index_of"
    t.string "status", default: "00A"
    t.string "activity_award_cfg_name"
  end

  create_table "activity_bases", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title"
    t.date "begin_time"
    t.date "end_time"
    t.string "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bonus_changes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "score"
    t.integer "red_packet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckeditor_assets", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "config_table_infos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "cf_id"
    t.string "cf_desc"
    t.string "cf_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ad_photo"
  end

  create_table "good_instances", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code"
    t.integer "good_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goods", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code"
    t.string "name"
    t.string "spec"
    t.string "status"
    t.integer "score"
    t.boolean "ispromotion"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "price"
    t.string "info"
    t.integer "goods_catalog_id"
  end

  create_table "goods_catalogs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lotteries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "activity_id"
    t.string "activity_name"
    t.string "winning", default: "true"
    t.integer "activity_award_id"
    t.integer "activity_award_cfg_id"
    t.string "activity_award_cfg_name"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "managestores_admins", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "managestore_id"
    t.integer "admin_id"
    t.index ["admin_id"], name: "index_managestores_admins_on_admin_id"
    t.index ["managestore_id"], name: "index_managestores_admins_on_managestore_id"
  end

  create_table "mem_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "city"
    t.string "province"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mem_levels", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code"
    t.string "name"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "level"
  end

  create_table "qr_code_scan_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "good_id"
    t.integer "good_instance_id"
    t.integer "score"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "province"
    t.string "city"
  end

  create_table "red_packet_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "money"
    t.string "catalog"
    t.string "phone_number"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "return_msg"
  end

  create_table "score_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "point"
    t.string "object_type"
    t.string "object_id"
    t.string "oper"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bonus_change_id"
    t.string "red_packet"
    t.string "city"
    t.string "province"
  end

  create_table "short_urls", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sms_sends", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "recv_num"
    t.string "send_content"
    t.string "state", default: "00A"
    t.string "sms_type"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "code"
    t.string "catalog"
    t.string "name"
    t.string "district"
    t.string "city"
    t.string "province"
    t.string "country"
    t.float "latitude", limit: 24
    t.float "longitude", limit: 24
    t.string "addr"
    t.string "linkman"
    t.string "contact_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "qrcode"
  end

  create_table "stores_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "store_id"
    t.integer "user_id"
    t.index ["store_id"], name: "index_stores_users_on_store_id"
    t.index ["user_id"], name: "index_stores_users_on_user_id"
  end

  create_table "tech_servs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.string "title"
    t.string "status", default: "00A"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "level"
    t.integer "admin", default: 0
    t.integer "score", default: 0
    t.string "name"
    t.string "code"
    t.string "sex"
    t.date "birthday"
    t.string "phone_num"
    t.integer "score_total", default: 0
    t.integer "mem_group_id"
    t.string "district"
    t.string "city"
    t.string "province"
    t.string "country"
    t.string "latitude"
    t.string "longitude"
    t.integer "referee_id"
    t.string "status", default: "00A"
    t.string "mem_email", default: ""
    t.string "openid"
    t.string "nickname"
    t.string "language"
    t.string "headimgurl"
    t.string "qrcode"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
