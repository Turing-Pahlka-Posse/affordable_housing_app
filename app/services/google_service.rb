class GoogleService
  attr_reader :connection

  def initialize
    @connection = Faraday.new("https://maps.googleapis.com/maps/api/distancematrix/json")
  end

  def addresses
    response = parse(connection.get("?origins=Vancouver+BC%7CSeattle&destinations=San+Francisco%7CVictoria+BC&mode=bicycling&language=fr-FR&key=#{ENV['GOOGLE_API_KEY']}"))
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end