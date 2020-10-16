require 'rails_helper'

RSpec.describe BlogTag, type: :model do
  before :all do
    @tag = build_stubbed(:blog_tag, name: 'test tag')
    @genre = create(:genre)
    @author = create(:blog_author)
  end

  it 'capitalises the name ' do
    nice_name = @tag.nice_name

    expect(nice_name).to eq 'Test tag'
  end

  it 'sets a slug' do
    @tag.set_slug

    expect(@tag.slug).to eq 'test-tag'
  end

  it 'updates the post count for a tag' do
    tag = create(:blog_tag, name: 'tag', genre: @genre)
    3.times do |i|
      create(:blog_post, title: "Blog post #{i}", blog_tags: [tag], genre: @genre, blog_author: @author)
    end

    tag.update_posts_count

    expect(tag.blog_post_count).to eq 3
  end

  it 'updates all post counts using an attached blog post' do
    dog_tag = create(:blog_tag, name: 'Dogs', genre: @genre)
    cat_tag = create(:blog_tag, name: 'Cats', genre: @genre)
    post1 = create(:blog_post, title: 'Blog post 1', blog_tags: [dog_tag], genre: @genre, blog_author: @author)
    create(:blog_post, title: 'Blog post 2', blog_tags: [cat_tag], genre: @genre, blog_author: @author)
    create(:blog_post, title: 'Blog post 3', blog_tags: [cat_tag], genre: @genre, blog_author: @author)
    create(:blog_post, title: 'Blog post 4', blog_tags: [dog_tag, cat_tag], genre: @genre, blog_author: @author)

    BlogTag.update_counts(post1)
    dog_tag.reload
    expect(dog_tag.blog_post_count).to eq 2
    cat_tag.reload
    expect(cat_tag.blog_post_count).to eq 3
  end
end
