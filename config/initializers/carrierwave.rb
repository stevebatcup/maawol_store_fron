fog_credentials = {
  provider:              'AWS',
  aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
  aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  region:                'us-east-1',
}

CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = fog_credentials
  config.fog_directory  = 'maawol'
end

Fog::Storage.new(fog_credentials).sync_clock