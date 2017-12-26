class FriendshipSerializer < ActiveModel::Serializer
  attributes :id, :trip_id, :friend_id
end
