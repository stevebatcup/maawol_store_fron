require 'rails_helper'

RSpec.describe School, type: :model do
  let(:school) { build_stubbed(:school, name: 'School', protocol: 'https', domain: 'maawol.com', port: 5656) }

  it 'returns a base url for the school' do
    expect(school.base_url).to eq 'https://maawol.com:5656'
  end

  it 'returns a callback url for payment platform for the school' do
    expect(school.callback_url(:chargebee)).to eq 'https://maawol.com:5656/chargebee'
  end
end
