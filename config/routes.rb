Rails.application.routes.draw do
  root	to: 'home#index'
  post 'enquire', to: 'enquiry#create'
  get 'sitemap.xml', to: 'sitemap#index'

  get 'blog/:slug', to: 'blog_posts#show', as: :blog_post
  get 'blog', to: 'blog_posts#index', mode: :all
  get 'blog/category/:slug', to: 'blog_posts#index', as: :blog_category, mode: :category
  get 'blog/tag/:slug', to: 'blog_posts#index', as: :blog_tag, mode: :tag
  get 'about-us', to: 'about_us#show'

	namespace :admin do
		resources	:blog_posts
		resources	:blog_authors
		resources	:blog_tags
		resources	:blog_categories
	  root to: "blog_posts#index"
	end
end
