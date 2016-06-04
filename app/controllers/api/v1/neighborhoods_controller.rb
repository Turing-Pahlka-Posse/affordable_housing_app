module Api
  module V1
    class NeighborhoodsController < ApiController
      respond_to :json

      def index
        params = {
          "Address 1"=>"1510 Blake st. Denver CO",
          "Address 2"=>"Elkhart Elementary Aurora CO",
          "Address 3"=>"Denver Art Museum"
        }
        @top_three = NeighborhoodAnalyst.top_three_neighborhoods(params)
          results = @top_three.map do |neighborhood|
            Hash[["Distance", "Neighborhood"].zip(neighborhood)]
          end
        render json: results
      end
    end
  end
end
