class InviteController < UIViewController

  def loadView
    @layout = InviteLayout.new
    self.view = @layout.view
    self.title = Constants::AppTitle

    init_map
  end

  def init_map
    @layout.get(:map).region = MapKit::CoordinateRegion.new([42.360788, -71.062669], [3.5, 3.5])
    @layout.get(:map).shows_user_location = true
    @layout.get(:map).set_zoom_level(15)

    @my_location_manager = CLLocationManager.alloc.init
    @my_location_manager.delegate = self
    @my_location_manager.startUpdatingLocation
    @my_location_manager.purpose = 'woieeowi'

    @pin = MKPointAnnotation.alloc.init
    @pin.coordinate =  CLLocationCoordinate2DMake(42.360788, -71.062669)
    @pin.title = 'Here I am'


    @point = MyAnnotation.alloc.initWithCoordinates(@pin.coordinate, title:"My Title", subTitle:"My Subtitle")
    @layout.get(:map).addAnnotation(@point)
  end

end

class MyAnnotation
  def coordinate; @coordinate; end
  def title; @title; end
  def subtitle; @subtitle; end

  def initWithCoordinates(paramCoordinates, title:paramTitle, subTitle:paramSubTitle)
    @coordinate = paramCoordinates
    @title = paramTitle
    @subtitle = paramSubTitle

    self
  end
end

=begin


class SimpleLayout2 < MK::Layout
  include MapKit

  # this is a special attr method that calls `layout` if the view hasn't been
  # created yet. So you can call `layout.button` before `layout.view` and you
  # won't get nil, and layout.view will be built.
  view :button

  def layout

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

    @button_accept = add UIButton, :button_accept do
      background_color UIColor.colorWithRed(0.118, green:0.541, blue:0.545, alpha:1.0)
      title "Swipe to accept >"
      sizeToFit
      frame [[0,523],['100%',45]]
    end

    @label_time = add UILabel, :label_time do
      background_color UIColor.whiteColor
      text "10:54"
      frame [[0,245],['100%',40]]
    end
    @label_time.tap do |l|
      l.textAlignment = UIControlContentHorizontalAlignmentLeft
      l.font = UIFont.fontWithName("Helvetica-Bold", size: 16)
    end

    @image_calendar = UIImageView.alloc.initWithImage(UIImage.imageNamed("calendar4.png"))
    addSubview(@image_calendar)
    @image_calendar.center = CGPointMake(80, 130)

    @label_calendar = add UILabel, :label_calendar do
      frame [[80, -100],['100%','100%']]
      text "5:00 PM"
      text_color UIColor.blackColor
      text_alignment UITextAlignmentCenter
    end
    @label_calendar.center = CGPointMake(80, 160)

    @image_runner = UIImageView.alloc.initWithImage(UIImage.imageNamed("running30.png"))
    addSubview(@image_runner)
    @image_runner.center = CGPointMake(160, 130)

    @label_runner = add UILabel, :label_runner do
      frame [[160, -100],['100%','100%']]
      text "5.5 mi"
      text_color UIColor.blackColor
      text_alignment UITextAlignmentCenter
    end
    @label_runner.center = CGPointMake(160, 160)

    @image_timer = UIImageView.alloc.initWithImage(UIImage.imageNamed("chronograph1.png"))
    addSubview(@image_timer)
    @image_timer.center = CGPointMake(240, 130)

    @label_timer = add UILabel, :label_timer do
      frame [[240, -100],['100%','100%']]
      text "9:00 min/mi"
      text_alignment UITextAlignmentCenter
    end
    @label_timer.center = CGPointMake(240, 160)

    background_color UIColor.grayColor
  end

  def mapView(map, viewForAnnotation: annotation)
    MKPinAnnotationView.alloc.initWithAnnotation(annotation, reuseIdentifier: 'pin')
  end

  def locationManager(manager, didUpdateToLocation:newLocation, fromLocation:oldLocation)
    puts "Latitude = #{newLocation.coordinate.latitude} Longitude = #{newLocation.coordinate.longitude}"
  end
end
=end
