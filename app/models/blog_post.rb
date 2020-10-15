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
end
