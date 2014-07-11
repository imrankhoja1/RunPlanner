class AppDelegate
  attr_reader :main_controller, :invite_controller, :nav_controller

  def application(application, didFinishLaunchingWithOptions: launchOptions)
    application.registerForRemoteNotificationTypes(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)
    Parse.setApplicationId("w73zBja8m0FY17rUC1jtyxXEGSuvvu53NuAf14be", clientKey: "Oko261xSzym0188Df7Ig9M380ElN7QMti8WzomFl")

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    @main_controller = MainController.alloc.initWithNibName(nil, bundle: nil)
    @invite_controller = InviteController.alloc.initWithNibName(nil, bundle: nil)
    @nav_controller = UINavigationController.alloc.initWithRootViewController(@main_controller)
    @nav_controller.setDelegate(self)
    @window.rootViewController = nav_controller

    NSLog("hello world")

    true
  end

  def application(application, didRegisterForRemoteNotificationsWithDeviceToken: device_token)
    NSLog("token: %@", device_token)

    json = {
      "user" => "Ben"
    }
    client = AFMotion::Client.build("https://api.parse.com/") do
      request_serializer :json

      header "X-Parse-Application-Id", Config.parse_app_id
      header "X-Parse-REST-API-Key", Config.parse_api_key
    end
    client.post("1/functions/get_user_id", json) do |result|
      if result.object
        NSLog("parse api user id: %@", result.object["result"]["user"]["objectId"])

        installation = PFInstallation.currentInstallation
        installation.channels = [result.object["result"]["user"]["objectId"]]
        installation.setDeviceTokenFromData(device_token)
        installation.saveInBackground
      end
    end

  end

  def application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    NSLog("error: %@", error)
  end

  def application(application, didReceiveRemoteNotification: notification)
    NSLog("push notification: %@", notification)
  end
end
