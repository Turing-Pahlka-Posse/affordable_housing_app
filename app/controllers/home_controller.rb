class HomeController < ApplicationController
  def index
    analyst = NeighborhoodAnalyst.new
    @neighborhoods = analyst.top_three_neighborhoods
  end
end