require_relative '../../../helpers/GoogleAPI'
require 'pry'
class Api::V1::StopsController < ApplicationController
  extend GoogleAPI

  def index
    user = current_user
    trip = user.trips.find(id)
    stops = trip.stops.all.sort_by{|stop| stop.order}
    Sorter.recount(stops)
    render json: stops
  end


  def show
    stop = Stop.find(params[:id])
    activities = stop.activities
    render json: {stop: stop, activities: activities.map { |act| ActivitySerializer.new(act) } }
  end


  def create
    location = GoogleAPI.coordinates(params[:stop]) #Gets coordinates
    trip_id = params[:trip_id]
    user = current_user
    trip = user.trips.find(trip_id)
    # binding.pry
    order = trip.stops.count
    # binding.pry
    new_order = trip.stops.count + 1
    # binding.pry
    trip.stops.last.update(order: new_order)
    # binding.pry
    trip.stops.create(name: params[:stop], order: order, lat: location["lat"], lng: location["lng"])
    # binding.pry
    stops = trip.stops.all.sort_by{|stop| stop.order}
    Sorter.recount(stops) #Sorts the stops by order
    # binding.pry
    stops = GoogleAPI.getDurations(stops) #gets and updates duration attributes
    stop = trip.stops.last

    friends = []
    trip.friendships.count > 0 ? friends = trip.friendships.map{|f| f.friend} : friends =['there are no friends']
    # binding.pry
    render json: {stop:stop,  stops:stops, trip: user.trips, friends: friends}
  end

  def destroy
  stop = Stop.find(params[:id])
  user = User.find(current_user.id)
  trip = user.trips.find_by(id: stop.trip_id)
  stop.destroy
  stops = trip.stops.all.sort_by{|stop| stop.order}
  Sorter.recount(stops)
  stops = GoogleAPI.getDurations(stops) #gets and updates duration attributes
  friends = []
  trip.friendships.count > 0 ? friends = trip.friendships.map{|f| f.friend} : friends =['there are no friends']
  render json: {trip: trip, stops: stops, friends: friends}
  end


  def updateOrder
    trip = Trip.find(params['trip_id'])
    stops = trip.stops.all.sort_by{|stop| stop.order}
    stop = Stop.find(params['stop_id'])
    index = stops.index(stop)
    place = index + 1
      if params['move'] === 'UP'
        stops[index].update(order: place - 1)
        stops[index - 1].update(order: place)
      else
        stops[index].update(order: place + 1)
        stops[index + 1].update(order: place)
      end

    stops = trip.stops.all.sort_by{|stop| stop.order}

    stops = GoogleAPI.getDurations(stops) #gets and updates duration attributes

    render json: {trip: trip, stops: stops}

  end

end
