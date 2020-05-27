module BlogHelper
	def category_links(post)
		links = []
		post.blog_categories.each do |category|
			links << link_to(category.nice_name, blog_category_path(slug: category.slug))
		end
		links.join(" / ").html_safe
	end

	def popular_blog_posts(limit=3)
		BlogPost.where(is_popular: true).order("RANDOM()").limit(limit)
	end

	def category_count_list
		categories = BlogCategory.order(blog_post_count: :desc)
		content_tag :ul do
			categories.collect do |category|
				item = content_tag :li do
					count = content_tag(:span, category.blog_post_count, class: "cat-count")
					"#{category_link(category)} #{count}".html_safe
				end
				concat(item)
			end
		end
	end

	def category_link(category, icon='')
		link_to "#{icon} #{category.nice_name}".html_safe, blog_category_path(slug: category.slug)
	end

	def tag_links(post)
		links = []
		post.blog_tags.each do |tag|
			links << link_to(tag.nice_name, blog_tag_path(slug: tag.slug))
		end
		links.join(" / ").html_safe
	end

	def tag_cloud_list
		tags = BlogTag.order(blog_post_count: :desc)
		content_tag :div do
			tags.collect { |tag| concat(link_to("#{tag.nice_name}", blog_tag_path(slug: tag.slug))) }
		end
	end

	def recommended_posts(main_post, category=nil, tag=nil, limit=10)
		posts = []
		if main_post.blog_categories.any?
			category ||= main_post.blog_categories.first
		end
		category.blog_posts.where.not(id: main_post.id).each { |post| posts << post }

		if (posts.size < limit)
			if main_post.blog_tags.any?
				tag ||= main_post.blog_tags.first
			end
			excludes = posts.map(&:id)
			excludes << main_post.id
			tag.blog_posts.where.not(id: excludes).each { |post| posts << post }
		end

		posts.sample(limit)
	end
end
