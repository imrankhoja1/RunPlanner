module Config
  def self.production?
    RUBYMOTION_ENV == "production"
  end

  def self.development?
    RUBYMOTION_ENV == "development"
  end
end
