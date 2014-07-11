class RunSession

  def self.invite_params(contacts)
    first_names = []
    last_names = []
    phones = []
    contacts.each_with_index do |x,i|
      first_names << x[:first_name]
      last_names << x[:last_name]
      phones << x[:phones][0][:value]
    end
    {
      "from" => {
        "first_name" => "Ben",
        "last_name" => "Miller",
        "phone" => "+16178602901"
      },
      "info" => {
        "miles" => "5.5",
        "time" => "5:45 PM",
        "pace" => "9:00"
      },
      "first_names" => first_names,
      "last_names" => last_names,
      "phones" => phones
    }
  end

  def self.send(contacts)
    ap invite_params(contacts)
    client = AFMotion::Client.build("https://api.parse.com/") do
      request_serializer :json

      header "X-Parse-Application-Id", Config.parse_app_id
      header "X-Parse-REST-API-Key", Config.parse_api_key
    end

    json = {
      "user" => "Imran",
      "lat" => 37.7858276367188,
      "lon" => -122.406417,
      "runners" => invite_params(contacts)["first_names"]
    }
    ap json

    client.post("1/functions/invite_runners", json) do |result|
      if result.object
        ap result.object
      end
    end
  end
end
