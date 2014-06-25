class AppDelegate
  attr_reader :mk_controller, :invite_page_controller, :nav_controller

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    # This is our new line!
    @mk_controller = MkController.alloc.initWithNibName(nil, bundle: nil)
    @invite_page_controller = InvitePageController.alloc.initWithNibName(nil, bundle: nil)
    @nav_controller = UINavigationController.alloc.initWithRootViewController(@mk_controller)
    @nav_controller.setDelegate(self)
    @window.rootViewController = nav_controller

    true
  end
end
