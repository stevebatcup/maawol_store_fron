class TermsAndConditionsController < ApplicationController
	layout	:set_layout_for_genre

	def show
		render "terms_and_conditions/#{genre_slug}/show"
	end
end
