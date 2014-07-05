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
  # Use `rake config' to see complete project settings.
  app.name = 'RunPlanner'
  app.frameworks += ["CoreLocation", "MapKit", "AddressBook"]
  app.provisioning_profile = config['provisioning_profile']

  app.info_plist['parse_app_id'] = 'w73zBja8m0FY17rUC1jtyxXEGSuvvu53NuAf14be'
  app.info_plist['parse_api_key'] = 'L2JjEVdH1hfTocoxSekJPuQa4kOJ4skPnIQ5zDMx'
end
