require_relative '../../../helpers/GoogleAPI'
require 'pry'

class Api::V1::TripsController < ApplicationController
  extend GoogleAPI

  def everytrip
    render json: Trip.all
  end

  def index
    user = User.find(current_user.id)
    render json: user
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
    binding.pry
    user = User.find(current_user.id)
    user.trips.create(title: params[:trip], photo: params[:fileURL])
    trip = user.trips.last
    start_location = GoogleAPI.coordinates(params[:start])
    end_location = GoogleAPI.coordinates(params[:end])

    trip.stops.create(name: params[:start], order:1, lat: start_location["lat"], lng: start_location["lng"])
    trip.stops.create(name: params[:end], order:1, lat: end_location["lat"], lng: end_location["lng"])

    stops = trip.stops.all.sort_by{|stop| stop.order}
    Sorter.recount(stops) #Sorts the stops by order
    stops = GoogleAPI.getDurations(stops) #gets and updates duration attributes
    user_trips = user.trips
    binding.pry
    render json: {trips: user_trips.map {|trip| TripSerializer.new(trip)}, stops: stops.map{|stop| StopSerializer.new(stop)}}
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
