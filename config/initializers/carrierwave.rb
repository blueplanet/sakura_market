CarrierWave.configure do |config|
  if Rails.env.test? || Rails.env.development?
    config.storage :file
  else
    config.storage = :fog

    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['S3_KEY_ID'],
      aws_secret_access_key: ENV['S3_ACCESS_KEY'],
      region: ENV['S3_REGION']
    }

    config.fog_directory = ENV['S3_BUCKET_NAME']
    config.fog_public = false
  end
end
