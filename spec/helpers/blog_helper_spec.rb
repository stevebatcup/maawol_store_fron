require 'rails_helper'

RSpec.describe BlogHelper, type: :helper do
  include Capybara::RSpecMatchers

  helper do
    def genre_from_host; end
  end

  let(:categories) do
    %w[cats dogs elephants monkeys].map do |animal|
      build_stubbed(:blog_category, name: animal, slug: animal)
    end
  end
  let(:tags) do
    %w[walnut cheese bread potato].map do |food|
      build_stubbed(:blog_tag, name: food, slug: food)
    end
  end
  let(:post) { build_stubbed(:blog_post, title: 'Blog Post') }
  let(:genre) { build_stubbed(:genre, trade_name: 'Maawol', blog_categories: categories, blog_tags: tags) }

  it 'outputs all categories for a given posts genre as links joined in a sentence' do
    allow(post).to receive(:genre).and_return(genre)
    actual = helper.category_links(post)

    expect(actual.length).to be > 0
    expect(actual).to have_selector('a', text: 'Elephants')
    expect(actual).to have_content('Cats / Dogs / Elephants / Monkeys')
  end

  it 'outpus a category link prepended with provided icon' do
    icon = 'ICON'
    elephants_cat = categories.find { |cat| cat.slug == 'elephants' }

    actual = helper.category_link(elephants_cat, icon)

    expect(actual).to have_selector('a', text: 'ICON Elephants')
  end

  it 'outputs all tags for a given posts genre as links joined in a sentence' do
    allow(post).to receive(:genre).and_return(genre)
    actual = helper.tag_links(post)

    expect(actual.length).to be > 0
    expect(actual).to have_selector('a', text: 'Walnut')
    expect(actual).to have_content('Walnut / Cheese / Bread / Potato')
  end

  it 'outputs an HTML list of categories with their blog post count' do
    elephants_cat = categories.find { |cat| cat.slug == 'elephants' }
    allow(elephants_cat).to receive(:blog_post_count).and_return(5)
    monkeys_cat = categories.find { |cat| cat.slug == 'monkeys' }
    allow(monkeys_cat).to receive(:blog_post_count).and_return(6)

    actual = helper.category_count_list([elephants_cat, monkeys_cat])

    expect(actual).to have_content('Elephants 5')
    expect(actual).to have_selector('li', text: 'Monkeys 6')
  end

  it 'outputs a cloud list of tags' do
    actual = helper.tag_cloud_list(tags)

    expect(actual).to have_selector('div')
    expect(actual).to have_selector('a', text: 'Cheese')
    expect(actual).to have_link('Walnut', href: '/blog/tag/walnut')
  end
end
