class Invitation
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
    if Config.production?
      client = AFMotion::Client.build("https://api.parse.com/") do
        request_serializer :json

        header "X-Parse-Application-Id", Config.parse_app_id
        header "X-Parse-REST-API-Key", Config.parse_api_key
      end

      client.post("1/functions/hello", invite_params(contacts)) do |result|
        ap result.object if result.object
      end
    else
      puts "in development mode, skipping sms"
    end

    if @sent
      invite_controller = self.controller.navigationController.delegate.invite_controller
      self.controller.navigationController.pushViewController(invite_controller, animated: true)
    else
    end

    @sent = !@sent
  end
end
