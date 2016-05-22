class HomesController < ApplicationController
  def index
    @neighborhoods = NeighborhoodCoordinate.all
  end

  def create
    @top_three = NeighborhoodAnalyst.top_three_neighborhoods(params)
    render :index
  end
end
