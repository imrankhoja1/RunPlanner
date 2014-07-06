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

  # prepend config.rb to loaded ruby files
  app.files.unshift(File.join(app.project_dir, 'config/config.rb'))

  # pass config object into run-time accessible plist object
  app.info_plist['config'] = config
end
