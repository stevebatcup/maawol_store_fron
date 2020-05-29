Rails.application.routes.draw do
  root	to: 'home#index'
  post 'enquire', to: 'enquiry#create'
  get 'sitemap.xml', to: 'sitemap#index'

  get 'blog/:slug', to: 'blog_posts#show', as: :blog_post
  get 'blog', to: 'blog_posts#index', mode: :all
  get 'blog/category/:slug', to: 'blog_posts#index', as: :blog_category, mode: :category
  get 'blog/tag/:slug', to: 'blog_posts#index', as: :blog_tag, mode: :tag
  get 'about-us', to: 'about_us#show'
  post 'subscription', to: 'subscriptions#create'
  delete 'subscription', to: 'subscriptions#destroy'
  post 'subscription_notifications/chargebee', to: 'subscription_notifications#create', platform: :chargebee
  post 'subscription_notifications/paypal', to: 'subscription_notifications#create', platform: :paypal

	namespace :admin do
    resources :genres
    resources :schools
    resources :subscriptions
		resources	:blog_posts
		resources	:blog_authors
		resources	:blog_tags
		resources	:blog_categories
	  root to: "schools#index"
	end
end
