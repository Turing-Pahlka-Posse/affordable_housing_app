class NeighborhoodCoordinate < ActiveRecord::Base
  require 'csv'
  require 'open-uri'

 #  def read(url)
 #   CSV.parse(open(url), :headers => :first_row, header_converters: :symbol).each do |line|
 #     p line[:date]
 #   end
 # end



 # http://files.zillowstatic.com/research/public/Neighborhood/Neighborhood_Zri_AllHomesPlusMultifamily_Summary.csv

 # def read(url)
 #  hash = Hash.new
 #  p CSV.parse(open(url), :headers => :first_row, header_converters: :symbol).each do |row|
 #    if row[:city] == "Denver"
 #      hash[row[:regionname]] = hash[row[:]]
 #
 #
 #  end

end
