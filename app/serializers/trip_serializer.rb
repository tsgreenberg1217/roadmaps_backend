class TripSerializer < ActiveModel::Serializer
  attributes :id, :title, :stops, :photo
end
