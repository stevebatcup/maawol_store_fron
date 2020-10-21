class BlogPost < ApplicationRecord
  belongs_to	:blog_author
  belongs_to :genre
  has_and_belongs_to_many	:blog_tags
  has_and_belongs_to_many	:blog_categories

  mount_uploader	:image, BlogPostImageUploader

  after_save	:update_tag_and_category_counts
  before_save	:set_slug

  def set_slug
    self.slug = title.parameterize
  end

  def update_tag_and_category_counts
    BlogTag.update_counts(self)
    BlogCategory.update_counts(self)
  end

  def nice_date
    published_on.strftime('%B %d, %Y')
  end

  def self.previous_post(post)
    befores = where('published_on < ?', post.published_on).where(genre_id: post.genre_id).order(published_on: :desc)
    befores.any? ? befores.first : nil
  end

  def self.next_post(post)
    afters = where('published_on > ?', post.published_on).where(genre_id: post.genre_id).order(published_on: :asc)
    afters.any? ? afters.first : nil
  end

  def self.recommended_posts(main_post, category, tag, limit = 10)
    posts = recommended_posts_by_category(category, [main_post])

    if posts.nil? || (posts.size < limit)
      tag_posts = recommended_posts_by_tag(tag, [main_post] + posts)
      posts += tag_posts unless tag_posts.nil? || tag_posts.empty?
    end

    return unless posts.any?

    posts.sample(limit)
  end

  def self.recommended_posts_by_category(category, excludes = [])
    return if category.nil?

    category.blog_posts.where.not(id: excludes.map(&:id))
  end

  def self.recommended_posts_by_tag(tag, excludes = [])
    return if tag.nil?

    tag.blog_posts.where.not(id: excludes.map(&:id))
  end
end
