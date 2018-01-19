class TripSerializer < ActiveModel::Serializer
  attributes :id, :title, :stops, :photo, :trip_stops
end
