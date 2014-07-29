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
  app.identifier = 'com.werunplanner'
  app.frameworks += ["CoreLocation", "MapKit", "AddressBook", "StoreKit"]

  app.pods do
    pod 'Parse-iOS-SDK'
  end

  app.provisioning_profile = config['provisioning_profile']

  # prepend config.rb to loaded ruby files
  app.files.unshift(File.join(app.project_dir, 'config/config.rb'))

  # pass config object into run-time accessible plist object
  app.info_plist['config'] = config

  app.info_plist['UISupportedInterfaceOrientations'] = ['UIInterfaceOrientationPortrait']

  app.entitlements['keychain-access-groups'] = [
    app.seed_id + '.' + app.identifier
  ]
  app.entitlements['aps-environment'] = 'development'
  app.entitlements['get-task-allow'] = true

  app.info_plist['Bundle identifier'] = 'com.werunplanner.RunPlanner'

  app.info_plist['UIBackgroundModes'] = ['location']
end
