class HomesController < ApplicationController

  def index
    @neighborhoods = Neighborhood.all
  end

  def create
    @top_three = NeighborhoodAnalyst.top_three_neighborhoods(params)
    @top_three_rent = NeighborhoodAnalyst.top_three_rent_neighborhoods(params)
    render :index
  end

end
