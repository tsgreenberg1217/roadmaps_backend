class User < ApplicationRecord
  validates :name, uniqueness: true

  has_secure_password

  has_many :trips

  has_many :stops, through: :trips
  has_many :activities, through: :stops

  has_many :friendships, through: :trips
  has_many :friends, through: :friendships

  def on_trip_friendships
    Friendship.all.select{|f| f.friend_id == self.id}
  end

  def on_trips
    self.on_trip_friendships.map{|f| Trip.find(f.trip_id)} #.where
  end

  def user_trips
    self.trips.all
  end

end
