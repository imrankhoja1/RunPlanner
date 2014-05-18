class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    Parse.setApplicationId("w73zBja8m0FY17rUC1jtyxXEGSuvvu53NuAf14be", clientKey: "Oko261xSzym0188Df7Ig9M380ElN7QMti8WzomFl")
    application.registerForRemoteNotificationTypes(UIRemoteNotificationTypeBadge)
    setup_initial_view
    true
  end

  def application(application, didRegisterForRemoteNotificationsWithDeviceToken:deviceToken)
    PFPush.storeDeviceToken(deviceToken)
    PFPush.subscribeToChannelInBackground("chat")
  end

  def appication(application, didReceiveRemoteNotification:userInfo)
    @chat_window.display_message(userInfo)
  end

  def setup_initial_view
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @chat_window = ChatViewController.alloc.init
    @window.rootViewController = @chat_window
    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible
  end
end
