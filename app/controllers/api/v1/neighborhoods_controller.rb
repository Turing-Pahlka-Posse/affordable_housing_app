module Api
  module V1
    class NeighborhoodsController < ApiController
      respond_to :json

      def index
        binding.pry
        @top_three = NeighborhoodAnalyst.top_three_neighborhoods(params)
        render json: @top_three
      end
    end
  end
end
