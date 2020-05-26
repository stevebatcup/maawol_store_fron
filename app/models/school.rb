class School < ApplicationRecord
	has_many	:subscriptions

	def callback_url(platform)
		if platform == :chargebee
			"#{base_url}/chargebee"
		elsif platform == :paypal
			"#{base_url}/paypal/webhook"
		end
	end

	def base_url
		"#{protocol}://#{domain}:#{port}"
	end
end
