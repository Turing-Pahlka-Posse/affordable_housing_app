class HomeController < ApplicationController

  def index
    @neighborhoods = NeighborhoodAnalyst.top_three_neighborhoods
  end


end
