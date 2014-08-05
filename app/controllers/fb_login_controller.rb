class FBLoginController < UIViewController
  def loadView
    self.view = make_view

    self.title = "Options"

    self.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithTitle("Back", style: UIBarButtonItemStylePlain, target: self, action: "nav_to_main_page")
  end

  def nav_to_main_page
    main_controller = navigationController.delegate.main_controller
    navigationController.pushViewController(main_controller, animated: true)
  end

  def loginViewFetchedUserInfo(login_view, user: user)
    NSLog("fetched! %@", user)
  end

  def loginViewShowingLoggedInUser(login_view)
    navigationController.pushViewController(navigationController.delegate.main_controller, animated: false)
  end

  def loginViewShowingLoggedOutUser(login_view)
    NSLog("showing logged out user")
  end

  def loginView(login_view, handleError: error)
    NSLog("login view error: %@", error)
  end

  def make_view
    puts UIScreen.mainScreen.bounds
    view = UIView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    view.backgroundColor = UIColor.whiteColor

    @login_view = FBLoginView.alloc.init
    @login_view.delegate = self
    @login_view.center = CGPointMake(320 / 2, 200)
    view.addSubview(@login_view)

    view
  end
end
