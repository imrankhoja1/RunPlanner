# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bubble-wrap'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'RunPlanner'
  app.weak_frameworks += %W(Accounts Social AdSupport)
  app.frameworks += %w(Accounts Social AdSupport AudioToolbox CFNetwork SystemConfiguration MobileCoreServices Security QuartzCore StoreKit)
  app.frameworks += ["CoreLocation", "MapKit", "AddressBook"]

  app.libs += ['/usr/lib/libz.dylib', '/usr/lib/libsqlite3.dylib']

  app.pods do
    pod 'Facebook-iOS-SDK'
  end

  app.vendor_project('vendor/Parse.framework', :static, :products => ['Parse'], :headers_dir => 'Headers')
end
