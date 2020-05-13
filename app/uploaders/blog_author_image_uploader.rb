class BlogAuthorImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  storage :fog

  def extension_whitelist
    %w{ jpg jpeg png }
  end

  version :large do
    process resize_to_fill: [200, 200]

    def store_dir
      "#{Rails.env}/blog/authors/#{model.id}"
    end
  end

  version :small do
    process resize_to_fill: [100, 100]

    def store_dir
      "#{Rails.env}/blog/authors/#{model.id}"
    end
  end
end
