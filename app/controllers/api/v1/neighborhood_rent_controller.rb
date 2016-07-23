class Api::V1::NeighborhoodRentController < Api::ApiController
  respond_to :json

  def index
    respond_with Neighborhood.find_by(name: params[:name])
  end
end
