class Api::V1::FriendshipsController < ApplicationController

  def create
    user = current_user
    trip = user.trips.find_by(id: params[:trip_id])
    friend = User.find_by(name: params[:friend])
    # binding.pry
    trip.friendships.create(friend_id: friend.id)
    friendships = trip.friendships
    friends = trip.friendships.map{|f| f.friend}
    render json: {trip: trip, friends:friends, stops: trip.stops}
  end

  def destroy
    user = current_user
    trip = user.trips.find_by(id: params[:trip_id])
  end

  def friendSearch
    string = params[:name]
    length = params[:name].length
    results = User.where('substr(name, 1, ?) = ?', length, string)
  end

end
