require 'rails_helper'

RSpec.describe BlogPost, type: :model do
  before :all do
    @category = build_stubbed(:blog_category, name: 'test category')
    @genre = create(:genre)
    @author = create(:blog_author)
    @post = build_stubbed(:blog_post, title: 'Blog Post', genre: @genre, blog_author: @author, published_on: Date.parse('10th April 2010'))
  end

  it 'sets a model slug' do
    @post.set_slug

    expect(@post.slug).to eq 'blog-post'
  end

  it 'updates the counts on tag and category models' do
    create_posts

    @posts.first.update_tag_and_category_counts
    [@dog_tag, @cat_tag, @swan_cat, @duck_cat].each(&:reload)

    expect(@dog_tag.blog_post_count).to eq 2
    expect(@cat_tag.blog_post_count).to eq 3
    expect(@swan_cat.blog_post_count).to eq 2
    expect(@duck_cat.blog_post_count).to eq 3
  end

  it 'formats the date nicely!' do
    expect(@post.nice_date).to eq 'April 10, 2010'
  end

  context 'with  published posts' do
    before :all do
      create_posts
      @posts[0].published_on = Date.parse('10th April 2018')
      @posts[1].published_on = Date.parse('9th March 2018')
      [@posts[0], @posts[1]].each(&:save)
    end

    it 'finds the previous post' do
      expect(BlogPost.previous_post(@posts[0]).title).to eq @posts[1].title
    end

    it 'finds no previous posts if there are none' do
      expect(BlogPost.previous_post(@posts[1])).to be_nil
    end

    it 'finds the next post' do
      expect(BlogPost.next_post(@posts[1]).title).to eq @posts[0].title
    end

    it 'finds no next posts if there are none' do
      expect(BlogPost.next_post(@posts[0])).to be_nil
    end
  end

  def create_tags
    @dog_tag = create(:blog_tag, name: 'Dog', genre: @genre)
    @cat_tag = create(:blog_tag, name: 'Cat', genre: @genre)
  end

  def create_categories
    @swan_cat = create(:blog_category, name: 'Swan', genre: @genre)
    @duck_cat = create(:blog_category, name: 'Ducks', genre: @genre)
  end

  def create_posts
    create_tags
    create_categories
    @posts = [create(:blog_post, title: 'Blog post 1', blog_categories: [@swan_cat], blog_tags: [@dog_tag], genre: @genre, blog_author: @author)]
    @posts << create(:blog_post, title: 'Blog post 2', blog_categories: [@duck_cat], blog_tags: [@cat_tag], genre: @genre, blog_author: @author)
    @posts << create(:blog_post, title: 'Blog post 3', blog_categories: [@duck_cat], blog_tags: [@cat_tag], genre: @genre, blog_author: @author)
    @posts << create(:blog_post, title: 'Blog post 4', blog_categories: [@swan_cat, @duck_cat], blog_tags: [@dog_tag, @cat_tag], genre: @genre, blog_author: @author)
  end
end
