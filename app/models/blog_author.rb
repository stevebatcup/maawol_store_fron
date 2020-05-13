class BlogAuthor < ApplicationRecord
	has_many	:blog_posts
	mount_uploader	:image, BlogAuthorImageUploader
end
