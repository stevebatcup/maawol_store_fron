class AboutUsController < ApplicationController
	layout	:set_layout_for_genre
	def show
		render "about_us/#{genre_slug}/show"
	end
end