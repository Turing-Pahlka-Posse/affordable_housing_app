class HomesController < ApplicationController

  def index
    @neighborhoods = Neighborhood.all
  end

end
