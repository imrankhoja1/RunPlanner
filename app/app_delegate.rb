class AppDelegate
  attr_reader :main_controller, :invite_controller, :nav_controller

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    @main_controller = MainController.alloc.initWithNibName(nil, bundle: nil)
    @invite_controller = InviteController.alloc.initWithNibName(nil, bundle: nil)
    #@nav_controller = UINavigationController.alloc.initWithRootViewController(@main_controller)
    @nav_controller = UINavigationController.alloc.initWithRootViewController(@invite_controller)
    @nav_controller.setDelegate(self)
    @window.rootViewController = nav_controller

    true
  end
end
