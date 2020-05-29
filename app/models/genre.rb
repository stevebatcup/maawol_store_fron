class Genre < ApplicationRecord
	has_many	:blog_posts
	has_many	:blog_categories
	has_many	:blog_tags
end
