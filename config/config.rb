module Config
  def self.production?
    RUBYMOTION_ENV == "production"
  end

  def self.development?
    RUBYMOTION_ENV == "development"
  end

  def self.parse_app_id
    plist_item('parse_app_id')
  end

  def self.parse_api_key
    plist_item('parse_api_key')
  end

  def self.plist_item(key)
    NSBundle.mainBundle.objectForInfoDictionaryKey(key)
  end
end
