class HomeController < ApplicationController

  def index
    @neighborhoods = NeighborhoodAnalyst.top_three
  end

end
