class BlogExtraFields < ActiveRecord::Migration[6.0]
  def change
  	add_column	:blog_posts,	:is_popular, :boolean, default: false
  	add_column	:blog_posts,	:image, :string
  	add_column	:blog_posts,	:published_on, :date

  	add_column	:blog_categories,	:blog_post_count, :integer, default: 0
  	add_column	:blog_tags,	:blog_post_count, :integer, default: 0

  	add_column	:blog_authors,	:image, :string
  	add_column	:blog_authors,	:bio, :text

  	create_table	:blog_categories_posts, id: false do |t|
  		t.references :blog_category
			t.references :blog_post
  	end

  	create_table	:blog_posts_tags, id: false do |t|
			t.references :blog_post
  		t.references :blog_tag
  	end
  end
end
