module Api
  module V1
    class AddressesController < ApiController
      respond_to :json

      def index
        @addresses = NeighborhoodAnalyst.addresses(params)

        @geojson = @addresses.map do |address|
          address.build_geojson
        end

        render json: @geojson
      end
    end
  end
end
