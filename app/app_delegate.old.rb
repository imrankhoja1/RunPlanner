class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    # This is our new line!
    @window.rootViewController = TapController.alloc.initWithNibName(nil, bundle: nil)

    Parse.setApplicationId("RunPlanner", clientKey: "Oko261xSzym0188Df7Ig9M380ElN7QMti8WzomFl")

    true
  end

  def viewDidAppear(animated)
    display_login unless PFUser.currentUser
  end
end
