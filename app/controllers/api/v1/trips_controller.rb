require 'pry'

class Api::V1::TripsController < ApplicationController

  def everytrip
    render json: Trip.all
  end

  def index
    user = User.find(current_user.id)
    render json: user.trips
  end

  def show
    trip_id = params[:id].to_i
    trip = Trip.find(trip_id)
    stops = trip.stops.all.sort_by{|stop| stop.order}
    Sorter.recount(stops)
    friends = []
    trip.friendships.count > 0 ? friends = trip.friendships.map{|f| f.friend} : friends =['there are no friends']
    render json: {trip:trip, stops: stops, friends: friends}
  end

  def create
    user = User.find(current_user.id)
    user.trips.create(title: params[:value][:trip], photo: params[:value][:fileURL])
    render json: user.trips
  end

  def destroy
    user = User.find(current_user.id)
    trip = user.trips.find_by(id: params[:id])
    trip.destroy
    render json: user
  end


  def ontrips
    user = current_user
    on_trips = user.on_trips
    render json: on_trips
  end

end
