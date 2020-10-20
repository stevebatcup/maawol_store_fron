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
    befores = where('published_on < ?', post.published_on).order(published_on: :desc)
    befores.any? ? befores.first : nil
  end

  def self.next_post(post)
    afters = where('published_on > ?', post.published_on).order(published_on: :asc)
    afters.any? ? afters.first : nil
  end

  def self.recommended_posts(main_post, category, tag, limit = 10)
    posts = []
    posts << recommended_posts_by_category(category, main_post)
    posts << recommended_posts_by_tag(tag) if posts.size < limit
    posts.sample(limit)
  end

  def self.recommended_posts_by_category(category, main_post)
    category ||= main_post.genre.blog_categories.first if main_post.genre.blog_categories.any?
    category.blog_posts.where.not(id: main_post.id).each { |post| posts << post } unless category.nil?
  end

  def self.recommended_posts_by_tag(main_post)
    tag ||= main_post.genre.blog_tags.first if main_post.genre.blog_tags.any?
    excludes = posts.map(&:id)
    excludes << main_post.id
    tag.genre.blog_posts.where.not(id: excludes).each { |post| posts << post } unless tag.nil?
  end
end
