if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end
if Rails.env.development?
  CarrierWave.configure do |config|
    config.storage :file
  end
end

require 'carrierwave'
require 'a9s_swift'

BUCKET_NAME = "videos"

if Rails.env.production?
  Anynines::Swift::Utility.configure_carrierwave(BUCKET_NAME,{fog_public: false}, "openstack")
end