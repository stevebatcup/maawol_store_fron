class PrivacyPolicyController < ApplicationController
	layout	:set_layout_for_genre

	def show
		render "privacy_policy/#{genre_slug}/show"
	end
end
