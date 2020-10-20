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

  def category_count_list(categories)
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

  def tag_cloud_list(tags)
    content_tag :div do
      tags.collect { |tag| concat(link_to(tag.nice_name, blog_tag_path(slug: tag.slug))) }
    end
  end
end
