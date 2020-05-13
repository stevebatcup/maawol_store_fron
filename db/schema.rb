# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_13_072021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blog_authors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.text "bio"
  end

  create_table "blog_categories", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "blog_post_count", default: 0
  end

  create_table "blog_categories_posts", id: false, force: :cascade do |t|
    t.bigint "blog_category_id"
    t.bigint "blog_post_id"
    t.index ["blog_category_id"], name: "index_blog_categories_posts_on_blog_category_id"
    t.index ["blog_post_id"], name: "index_blog_categories_posts_on_blog_post_id"
  end

  create_table "blog_posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "blog_author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.boolean "is_popular", default: false
    t.string "image"
    t.date "published_on"
  end

  create_table "blog_posts_tags", id: false, force: :cascade do |t|
    t.bigint "blog_post_id"
    t.bigint "blog_tag_id"
    t.index ["blog_post_id"], name: "index_blog_posts_tags_on_blog_post_id"
    t.index ["blog_tag_id"], name: "index_blog_posts_tags_on_blog_tag_id"
  end

  create_table "blog_tags", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "blog_post_count", default: 0
  end

end
