class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_trips, :password, :on_trips
end
