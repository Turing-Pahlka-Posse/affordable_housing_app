class HomeController < ApplicationController
  def index
    analyst = NeighborhoodAnalyst.new
    @neighborhoods = analyst.top_three_neighborhoods(addresses, trans_type)
  end
end