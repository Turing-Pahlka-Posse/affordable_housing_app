module Api
  module V1
    class NeighborhoodsController < ApiController
      respond_to :json

      def index
        # binding.pry
        @top_three = NeighborhoodAnalyst.top_three_neighborhoods(params)
        @top_three_rent = NeighborhoodAnalyst.top_three_rent_neighborhoods(params)

        render json: [@top_three, @top_three_rent]
      end
    end
  end
end
