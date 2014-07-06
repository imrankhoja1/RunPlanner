module Config
  def self.production?
    RUBYMOTION_ENV == "production"
  end

  def self.development?
    RUBYMOTION_ENV == "development"
  end

  def self.app_title
    config['app_title']
  end

  def self.parse_app_id
    config['parse_app_id']
  end

  def self.parse_api_key
    config['parse_api_key']
  end

  def self.config
    @@config ||= NSBundle.mainBundle.objectForInfoDictionaryKey("config")
  end
end
