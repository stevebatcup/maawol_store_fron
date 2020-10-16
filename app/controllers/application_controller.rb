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
      Genre.find_by slug: Rails.env.development? ? detect_development_slug : detect_production_slug
    end
  end

  def detect_development_slug
    case request.host
    when 'www.faawol.test'
      'faawol'
    when 'www.maawol.test'
      'maawol'
    else
      'maawol'
    end
  end

  def detect_production_slug
    case request.host
    when 'www.faawol.com'
      'faawol'
    when 'www.maawol.com'
      'maawol'
    end
  end

  helper_method :popular_blog_posts
  def popular_blog_posts(genre, limit = 3)
    genre.blog_posts.where(is_popular: true).order('RANDOM()').limit(limit)
  end
end
