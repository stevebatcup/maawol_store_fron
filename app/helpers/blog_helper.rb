module BlogHelper
  def category_links(post)
    links = []
    post.genre.blog_categories.each do |category|
      links << link_to(category.nice_name, blog_category_path(slug: category.slug))
    end
    content_tag(:span, links.join(' / ').html_safe)
  end

  def category_link(category, icon = '')
    link_to "#{icon} #{category.nice_name}".html_safe, blog_category_path(slug: category.slug)
  end

  def tag_links(post)
    links = []
    post.genre.blog_tags.each do |tag|
      links << link_to(tag.nice_name, blog_tag_path(slug: tag.slug))
    end
    content_tag(:span, links.join(' / ').html_safe)
  end

  def category_count_list
    categories = genre_from_host.blog_categories.order(blog_post_count: :desc)
    content_tag :ul do
      categories.collect do |category|
        item = content_tag :li do
          count = content_tag(:span, category.blog_post_count, class: 'cat-count')
          "#{category_link(category)} #{count}".html_safe
        end
        concat(item)
      end
    end
  end

  def tag_cloud_list
    tags = genre_from_host.blog_tags.order(blog_post_count: :desc)
    content_tag :div do
      tags.collect { |tag| concat(link_to(tag.nice_name, blog_tag_path(slug: tag.slug))) }
    end
  end

  def recommended_posts(main_post, category=nil, tag=nil, limit=10)
    posts = []
    category ||= main_post.genre.blog_categories.first if main_post.genre.blog_categories.any?
    category.blog_posts.where.not(id: main_post.id).each { |post| posts << post } unless category.nil?

    if posts.size < limit
      tag ||= main_post.genre.blog_tags.first if main_post.genre.blog_tags.any?
      excludes = posts.map(&:id)
      excludes << main_post.id
      tag.genre.blog_posts.where.not(id: excludes).each { |post| posts << post } unless tag.nil?
    end

    posts.sample(limit)
  end
end
