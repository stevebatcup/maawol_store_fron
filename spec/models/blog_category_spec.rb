require 'rails_helper'

RSpec.describe BlogCategory, type: :model do
  before :all do
    @category = build_stubbed(:blog_category, name: 'test category')
    @genre = create(:genre)
    @author = create(:blog_author)
  end

  it 'capitalises the name ' do
    nice_name = @category.nice_name

    expect(nice_name).to eq 'Test category'
  end

  it 'sets a slug' do
    @category.set_slug

    expect(@category.slug).to eq 'test-category'
  end

  it 'updates the post count for a category' do
    cat = create(:blog_category, name: 'Category', genre: @genre)
    3.times do |i|
      create(:blog_post, title: "Blog post #{i}", blog_categories: [cat], genre: @genre, blog_author: @author)
    end

    cat.update_posts_count

    expect(cat.blog_post_count).to eq 3
  end

  it 'updates all post counts using an attached blog post' do
    dog_cat = create(:blog_category, name: 'Dogs', genre: @genre)
    cat_cat = create(:blog_category, name: 'Cats', genre: @genre)
    post1 = create(:blog_post, title: 'Blog post 1', blog_categories: [dog_cat], genre: @genre, blog_author: @author)
    create(:blog_post, title: 'Blog post 2', blog_categories: [cat_cat], genre: @genre, blog_author: @author)
    create(:blog_post, title: 'Blog post 3', blog_categories: [cat_cat], genre: @genre, blog_author: @author)
    create(:blog_post, title: 'Blog post 4', blog_categories: [dog_cat, cat_cat], genre: @genre, blog_author: @author)

    BlogCategory.update_counts(post1)
    dog_cat.reload
    expect(dog_cat.blog_post_count).to eq 2
    cat_cat.reload
    expect(cat_cat.blog_post_count).to eq 3
  end
end
