class School < ApplicationRecord
  has_many	:subscriptions

  def callback_url(platform)
    case platform
    when :chargebee
      "#{base_url}/chargebee"
    when :paypal
      "#{base_url}/paypal/webhook"
    end
  end

  def base_url
    "#{protocol}://#{domain}:#{port}"
  end
end
