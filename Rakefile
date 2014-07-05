# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bubble-wrap'
require 'bubble-wrap/location'
require 'map-kit-wrapper'
require 'psych'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

config = Psych.load(File.open('./config/settings.yml'))

Motion::Project::App.setup do |app|
  app.name = 'RunPlanner'
  app.frameworks += ["CoreLocation", "MapKit", "AddressBook"]
  app.provisioning_profile = config['provisioning_profile']

  app.info_plist['parse_app_id'] = config['parse_app_id']
  app.info_plist['parse_api_key'] = config['parse_api_key']
end
