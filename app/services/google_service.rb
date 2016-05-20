require 'pry'
class GoogleService
  attr_reader :connection, :loc_1, :loc_2, :trans_type

  def initialize
    @connection = Faraday.new("https://maps.googleapis.com/maps/api/distancematrix/json")
  end

  def distance(loc_1, loc_2, trans_type)
    binding.pry
    time = Time.now.utc.next_week(:tuesday).to_i + (((60*14)+30)*60)
    response = parse(connection.get("?origins=#{loc_1}&destinations=#{loc_2}&mode=#{trans_type}&departure_time=#{time}&language=en&key=#{ENV['GOOGLE_API_KEY']}"))
    response[:rows][0][:elements][0][:distance][:value]
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
