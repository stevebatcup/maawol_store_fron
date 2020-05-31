class ApplicationController < ActionController::Base


	def set_layout_for_genre
		genre_slug
	end

	def genre_slug
		genre_from_host.slug
	end

	helper_method	:genre_from_host
	def genre_from_host
		@genre_from_host ||= begin
			if Rails.env.development?
				case request.host
				when 'www.faawol.test'
					slug = 'faawol'
				when 'www.maawol.test'
					slug = 'maawol'
				else
					slug = 'maawol'
				end
			else
				case request.host
				when 'www.maawol.com'
					slug = 'maawol'
				when 'faawol.maawol.com'
					slug = 'faawol'
				end
			end

			Genre.find_by(slug: slug)
		end
	end

end
