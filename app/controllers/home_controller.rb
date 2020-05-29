class HomeController < ApplicationController
	layout	:set_layout_for_genre
	def index
		render "home/#{genre_slug}/index"
	end
end