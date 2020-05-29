class AddGenreIdToBlogTables < ActiveRecord::Migration[6.0]
  def change
  	add_column	:blog_posts, :genre_id, :integer
  	add_column	:blog_categories, :genre_id, :integer
  	add_column	:blog_tags, :genre_id, :integer
  end
end
