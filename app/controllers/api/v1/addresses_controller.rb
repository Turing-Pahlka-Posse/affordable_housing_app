module Api
  module V1
    class AddressesController < ApiController
      respond_to :json

      def index
        @addresses = NeighborhoodAnalyst.addresses(params)
        
        render json: @addresses
      end
    end
  end
end
