class AddressSerializer < ActiveModel::Serializer
  attributes :address, :latitude, :longitude
end
