class InviteController < UIViewController

  def loadView
    @layout = InviteLayout.new
    self.view = @layout.view
    self.title = Constants::AppTitle

    init_map
  end

  def init_map
    @location_manager = CLLocationManager.alloc.init
    @location_manager.delegate = self
    @location_manager.startUpdatingLocation
    @location_manager.purpose = 'woieeowi'

    @layout.get(:map).region = MapKit::CoordinateRegion.new(@location_manager.location.coordinate, [3.5, 3.5])
    @layout.get(:map).shows_user_location = true
    @layout.get(:map).set_zoom_level(15)

    #@pin = MKPointAnnotation.alloc.init
    #@pin.coordinate = CLLocationCoordinate2DMake(42.360788, -71.062669)
    #@pin.title = 'Here I am'

    #@point = MyAnnotation.alloc.initWithCoordinates(@pin.coordinate, title:"My Title", subTitle:"My Subtitle")
    #@layout.get(:map).addAnnotation(@point)
  end

  def mapView(map, viewForAnnotation: annotation)
    MKPinAnnotationView.alloc.initWithAnnotation(annotation, reuseIdentifier: 'pin')
  end

  def locationManager(manager, didUpdateToLocation: newLocation, fromLocation: oldLocation)
    puts "Latitude = #{newLocation.coordinate.latitude} Longitude = #{newLocation.coordinate.longitude}"
    #@layout.get(:map).region.center = newLocation.coordinate
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
