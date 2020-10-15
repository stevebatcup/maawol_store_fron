require 'rails_helper'

RSpec.describe BlogPost, type: :model do
  before :all do
    @category = build_stubbed(:blog_category, name: 'test category')
    @genre = build_stubbed(:genre)
    @author = build_stubbed(:blog_author)
    @post = build_stubbed(:blog_post, title: 'Blog Post', genre: @genre, blog_author: @author)
  end

  it 'sets a model slug' do
    @post.set_slug

    expect(@post.slug).to eq 'blog-post'
  end
end
