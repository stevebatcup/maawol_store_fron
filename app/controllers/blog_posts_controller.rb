class BlogPostsController < ApplicationController
	def index
		case params[:mode].to_sym
		when :category
			@category = BlogCategory.find_by(slug: params[:slug])
			@posts = BlogPost.includes(:blog_categories).where(blog_categories: { id: @category.id })
			@title = @category.name
		when :tag
			@tag = BlogTag.find_by(slug: params[:slug])
			@posts = BlogPost.includes(:blog_tags).where(blog_tags: { id: @tag.id })
			@title = @tag.name
		when :all
			@posts = BlogPost.all
			@title = "Maawol blog"
		end
		@page = params[:page] || 1
		@posts = @posts.order(published_on: :desc).page(@page).per(8)
	end

	def show
		@post = BlogPost.find_by(slug: params[:slug])
		@main_category = @post.blog_categories.order(blog_post_count: :desc).first
		@main_tag = @post.blog_tags.order(blog_post_count: :desc).first
	end
end