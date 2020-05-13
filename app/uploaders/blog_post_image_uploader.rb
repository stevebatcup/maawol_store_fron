class BlogPostImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  storage :fog

  def extension_whitelist
    %w{ jpg jpeg png }
  end

  version :large do
    process resize_to_fill: [750, 300]

    def store_dir
      "#{Rails.env}/blog/posts/#{model.id}"
    end
  end

  version :small do
    process resize_to_fill: [345, 230]

    def store_dir
      "#{Rails.env}/blog/posts/#{model.id}"
    end
  end

  version :thumbnail do
    process resize_to_fill: [86, 86]

    def store_dir
      "#{Rails.env}/blog/posts/#{model.id}"
    end
  end
end
