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

ActiveRecord::Schema.define(version: 20150520132932) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "commits", force: :cascade do |t|
    t.string   "sha"
    t.string   "committer_name"
    t.string   "committer_email"
    t.datetime "commit_at"
    t.text     "message"
    t.string   "github_login"
    t.integer  "member_id"
    t.integer  "repository_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "commits", ["commit_at"], name: "index_commits_on_commit_at", using: :btree
  add_index "commits", ["member_id"], name: "index_commits_on_member_id", using: :btree
  add_index "commits", ["repository_id"], name: "index_commits_on_repository_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.string   "login"
    t.string   "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members_organizations", id: false, force: :cascade do |t|
    t.integer "organization_id"
    t.integer "member_id"
  end

  add_index "members_organizations", ["member_id"], name: "index_members_organizations_on_member_id", using: :btree
  add_index "members_organizations", ["organization_id"], name: "index_members_organizations_on_organization_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "login"
    t.string   "avatar_url"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "organizations_users", id: false, force: :cascade do |t|
    t.integer "organization_id"
    t.integer "user_id"
  end

  add_index "organizations_users", ["organization_id"], name: "index_organizations_users_on_organization_id", using: :btree
  add_index "organizations_users", ["user_id"], name: "index_organizations_users_on_user_id", using: :btree

  create_table "pull_requests", force: :cascade do |t|
    t.integer  "repository_id"
    t.integer  "member_id"
    t.integer  "number"
    t.string   "state"
    t.boolean  "locked"
    t.string   "title"
    t.text     "body"
    t.datetime "github_created_at"
    t.datetime "github_updated_at"
    t.datetime "github_closed_at"
    t.datetime "github_merged_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "pull_requests", ["member_id"], name: "index_pull_requests_on_member_id", using: :btree
  add_index "pull_requests", ["repository_id"], name: "index_pull_requests_on_repository_id", using: :btree

  create_table "repositories", force: :cascade do |t|
    t.integer  "organization_id"
    t.string   "name"
    t.text     "description"
    t.string   "homepage"
    t.boolean  "is_private"
    t.boolean  "is_fork"
    t.integer  "forks_count",     default: 0
    t.integer  "watchers_count",  default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "sign_in_count",      default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "github_uid"
    t.string   "github_token"
    t.string   "github_login"
    t.string   "github_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["github_uid"], name: "index_users_on_github_uid", unique: true, using: :btree

  add_foreign_key "commits", "members"
  add_foreign_key "commits", "repositories"
  add_foreign_key "pull_requests", "members"
  add_foreign_key "pull_requests", "repositories"
end
