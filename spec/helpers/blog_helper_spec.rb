require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the BlogHelperHelper. For example:
#
# describe BlogHelperHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe BlogHelper, type: :helper do
  include Capybara::RSpecMatchers

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

  it 'outputs all categories for a given posts genre as links joined in a sentence' do
    genre = build_stubbed(:genre, trade_name: 'Maawol', blog_categories: categories)
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
    puts actual
    expect(actual).to have_selector('a', text: 'ICON Elephants')
  end

  it 'outputs all tags for a given posts genre as links joined in a sentence' do
    genre = build_stubbed(:genre, trade_name: 'Maawol', blog_tags: tags)
    allow(post).to receive(:genre).and_return(genre)
    actual = helper.tag_links(post)

    expect(actual.length).to be > 0
    expect(actual).to have_selector('a', text: 'Walnut')
    expect(actual).to have_content('Walnut / Cheese / Bread / Potato')
  end
end
