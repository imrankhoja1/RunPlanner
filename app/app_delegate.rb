
class AppDelegate
  attr_reader :main_controller, :invite_controller, :invite_list_controller, :nav_controller, :fb_login_controller

  def application(application, didFinishLaunchingWithOptions: launch_options)
    NSLog("did finish launching")

    application.registerForRemoteNotificationTypes(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)
    Parse.setApplicationId("w73zBja8m0FY17rUC1jtyxXEGSuvvu53NuAf14be", clientKey: "Oko261xSzym0188Df7Ig9M380ElN7QMti8WzomFl")

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    @fb_login_controller = FBLoginController.alloc.initWithNibName(nil, bundle: nil)
    @main_controller = MainController.alloc.initWithNibName(nil, bundle: nil)
    @invite_controller = InviteController.alloc.initWithNibName(nil, bundle: nil)
    @invite_list_controller = InviteListController.alloc.initWithNibName(nil, bundle: nil)
    @nav_controller = UINavigationController.alloc.initWithRootViewController(@fb_login_controller)
    @nav_controller.setDelegate(self)
    @window.rootViewController = nav_controller

    if !launch_options.nil?
      notification = launch_options.objectForKey(UIApplicationLaunchOptionsRemoteNotificationKey)
      NSLog("notification on app launch: %@", notification)
      nav_to_invitation
    end

    NSLog("Facebook session active: %@", FBSession.activeSession.isOpen)
    if FBSession.activeSession.isOpen
      if @nav_controller.topViewController == @fb_login_controller
        @nav_controller.pushViewController(@main_controller, animated: false)
      end
    else
      FBSession.openActiveSessionWithAllowLoginUI(false)
    end

    true
  end

  def application(application, didRegisterForRemoteNotificationsWithDeviceToken: device_token)
    NSLog("token: %@", device_token)
=begin
    json = {
      "user" => "Imran"
    }
    client = AFMotion::Client.build("https://api.parse.com/") do
      request_serializer :json

      header "X-Parse-Application-Id", Config.parse_app_id
      header "X-Parse-REST-API-Key", Config.parse_api_key
    end
    client.post("1/functions/get_user_id", json) do |result|
      if result.object
        channel = "X" + result.object["result"]["user"]["objectId"]

        NSLog("parse api user id: %@", channel)

        installation = PFInstallation.currentInstallation
        installation.channels = [channel]
        installation.setDeviceTokenFromData(device_token)
        installation.saveInBackground
      end
    end
=end
  end

  def application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    NSLog("error: %@", error)
  end

  def application(application, didReceiveRemoteNotification: notification)
    NSLog("notification: %@", notification)
    nav_to_invitation
=begin
    NSLog("push notification: %@", notification["aps"]["alert"])
    for key in (notification["payload"]["request_params"].allKeys)
      NSLog("  key: %@, value: %@", key, notification["payload"]["request_params"][key])
    end
    @nav_controller.pushViewController(invite_controller, animated: true)
=end
  end

  def application(application, openURL: open_url, sourceApplication: source_application, annotation: annotation)
    was_handled = FBAppCall.handleOpenURL(open_url, sourceApplication: source_application)
    was_handled
  end

  def nav_to_invitation
    top_controller = @nav_controller.topViewController
    if top_controller != @invite_list_controller
      @nav_controller.pushViewController(@invite_list_controller, animated: false)
    end
    if top_controller != @invite_controller
      @nav_controller.pushViewController(@invite_controller, animated: true)
    end
    @invite_controller.set_invitation(Invitation.mock_list[0])
  end
end
