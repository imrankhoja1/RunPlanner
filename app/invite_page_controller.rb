class InvitePageController < UIViewController

  def loadView
    @layout = SimpleLayout2.new
    self.view = @layout.view

    #@button = @layout.get(:button)  # This will be created in our layout (below)

    self.title = "We Run"
  end

end

class SimpleLayout2 < MK::Layout
  include MapKit
  # this is a special attr method that calls `layout` if the view hasn't been
  # created yet. So you can call `layout.button` before `layout.view` and you
  # won't get nil, and layout.view will be built.
  view :button

  def layout

    @label00 = add UILabel, :label00 do
      background_color UIColor.whiteColor
      text "Suzanne wants to go on a run with you!"
      sizeToFit
      frame [[0,64],['100%',45]]
    end

    @label01 = add UILabel, :label01 do
      background_color UIColor.blueColor
      # text ""
      sizeToFit
      text_alignment UITextAlignmentCenter
      frame [[0,109],['33%',130]]
    end

    @label02 = add UILabel, :label02 do
      background_color UIColor.redColor
      # text ""
      sizeToFit
      text_alignment UITextAlignmentCenter
      frame [['33%',109],['33%',130]]
    end

    @label03 = add UILabel, :label03 do
      background_color UIColor.greenColor
      # text ""
      sizeToFit
      text_alignment UITextAlignmentCenter
      frame [['66%',109],['34%',130]]
    end

    @label04 = add UILabel, :label04 do
      background_color UIColor.orangeColor
      color UIColor.whiteColor
      text "Hurry! This invite expires in:"
      sizeToFit
      text_alignment UITextAlignmentCenter
      frame [[0,239],['100%',45]]
    end

    @map = add MapView, :map do
      frame [[0,284],['100%',390]]
    end

  # @map.region = CoordinateRegion.new([56, 10.6], [3.1, 3.1])
  @map.shows_user_location = true
  @map.set_zoom_level(8)
  puts 'start'
  puts @map.user_coordinates
  puts @map.user_located?
  puts @map.region
  puts @map.region.center

  puts 'location'
  puts BW::Location.enabled?
  puts 'eoiw'
  # puts BW::Location.authorized?

puts 'start location'
  @my_location_manager = CLLocationManager.alloc.init
  puts 'end location'
  @my_location_manager.delegate = self
  @my_location_manager.startUpdatingLocation
  @my_location_manager.purpose = 'woieeowi'

  # BW::Location.get do |result|
  #   puts result[:from].latitude
  #   puts result[:from].longitude
  # end

    # @pin = MKPointAnnotation.alloc.init
    # @pin.setCoordinate(@map.region.center)

     #   shows_user_location = true
    # #   center =
    #   # center = CGPointMake(self.view.frame.size.width / 2, 100)
    #   zoomEnabled = true
    #   scrollEnabled = true
    #   mapType = MKMapTypeHybrid

    #   userLocationVisible = true

    #   centerCoordinate = MKCoordinateRegionMake(CLLocationCoordinate2DMake(50.848418, 4.353877), MKCoordinateSpanMake(0.001, 0.001))

    #   region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(50.848418, 4.353877), MKCoordinateSpanMake(0.001, 0.001))

    # # this will allow us to set gestures
    # UITapGestureRecognizer.alloc.initWithTarget(self, action: "map_tapped:")
    # addGestureRecognizer(@map_tap)
    # self.view.addSubview(@map)


    # @label02 = add UILabel, :label02 do
    #   background_color UIColor.whiteColor
    #   text "3:00 PM"
    #   text_alignment UITextAlignmentRight
    #   sizeToFit
    #   frame [['67%',64],['33%',30]]
    # end

    end

    def locationManager(manager, didUpdateToLocation:newLocation, fromLocation:oldLocation)
    # got a new location
      puts "Latitude = #{newLocation.coordinate.latitude} Longitude = #{newLocation.coordinate.longitude}"
    end


  #   @label10 = add UILabel, :label10 do
  #     background_color UIColor.whiteColor
  #     text "Distance"
  #     sizeToFit
  #     frame [[0,30 + 64 + 1],['50%',30]]
  #   end

  #   @label11 = add UILabel, :label11 do
  #     background_color UIColor.whiteColor
  #     text "5.5 mi"
  #     sizeToFit
  #     text_alignment UITextAlignmentRight
  #     frame [['50%',30 + 64 + 1],['50%',30]]
  #   end

  #   @label2 = add UILabel, :label2 do
  #     background_color UIColor.whiteColor
  #     text "Target Pace"
  #     sizeToFit
  #     frame [[0,30 + 30 + 64 + 1 + 1],['100%',30]]
  #   end

  #   @label3 = add UILabel, :label3 do
  #     background_color UIColor.whiteColor
  #     text "Runners"
  #     text_alignment UITextAlignmentCenter
  #     sizeToFit
  #     frame [[0,30 + 30 + 64 + 1 + 1 + 30 + 1],['50%',30]]
  #   end

  #   @label4 = add UILabel, :label4 do
  #     background_color UIColor.grayColor
  #     text "Meeting Point"
  #     text_alignment UITextAlignmentCenter
  #     sizeToFit
  #     frame [['50%',30 + 30 + 64 + 1 + 1 + 30 + 1],['50%',24]]
  #   end

  #   @label5 = add UILabel, :label5 do
  #     background_color UIColor.whiteColor
  #     text "Drop a Pin"
  #     text_alignment UITextAlignmentCenter
  #     sizeToFit
  #     frame [[0,30 + 30 + 64 + 1 + 1 + 30 + 1 + 24 + 1 + 1 + 1 + 1 + 1 + 1 + 1],['100%',50]]
  #   end

  #   @map = add UILabel, :map do
  #     background_color UIColor.blueColor
  #     text "Map!"
  #     sizeToFit
  #     frame [[0,30 + 30 + 64 + 1 + 1 + 30 + 1 + 24 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 50 + 1],['100%',258]]
  #   end

  #   @invite_cont = add UILabel, :invite_cont do
  #     background_color UIColor.whiteColor
  #     sizeToFit
  #     frame [[0,30 + 30 + 64 + 1 + 1 + 30 + 1 + 24 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 50 + 1 + 258 + 1],['100%',70]]
  #   end

  #   @invite = add UILabel, :invite do
  #     background_color UIColor.greenColor
  #     text "Send Run Invite"
  #     text_alignment UITextAlignmentCenter
  #     sizeToFit
  #     asdf = 30 + 30 + 64 + 1 + 1 + 30 + 1 + 24 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 50 + 1 + 258 + 1
  #     frame [['5%',asdf + 10],['90%',50]]
  #   end

  #   background_color UIColor.grayColor
  # end

  # def label_style
  #   text 'Hi there! Welcome to MotionKit'
  #   font UIFont.fontWithName('Comic Sans', size: 24)
  #   sizeToFit

  #   # note: there are better ways to set the center, see the frame helpers below
  #   center [CGRectGetMidX(superview.bounds), CGRectGetMidY(superview.bounds)]
  #   text_alignment UITextAlignmentCenter
  #   text_color UIColor.whiteColor

  #   # if you prefer to use shorthands from another gem, you certainly can!
  #   #background_color rmq.color.white  # from RMQ
  #   #background_color :white.uicolor   # from SugarCube
  #   background_color UIColor.greenColor
  # end

  # def button_style
  #   # this will call 'setTitle(forState:)' via a UIButton helper
  #   title 'Press it!'
  #   sizeToFit
  #   # this shorthand is much better!  More about frame helpers below.
  #   frame [[0,0],['50%',:scale]]
  #   center ['50%', '50% + 100']
  #   background_color UIColor.blueColor
  # end

end
