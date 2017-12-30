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
    render json: {stop: stop, activities: stop.activities}
  end


  def create
    location = GoogleAPI.coordinates(params[:state][:stop]) #Gets coordinates
    trip_id = params[:stop][:trip_id]
    user = current_user
    trip = user.trips.find(trip_id)
    trip.stops.create(name: params[:state][:stop], order: params[:state][:order].to_i, lat: location["lat"], lng: location["lng"])
    stops = trip.stops.all.sort_by{|stop| stop.order}
    Sorter.recount(stops) #Sorts the stops by order
    stops = GoogleAPI.getDurations(stops) #gets and updates duration attributes
    stop = trip.stops.last
    render json: {stop:stop,  stops:stops, trip: user.trips}
  end

  def destroy
  stop = Stop.find(params[:id])
  user = User.find(current_user.id)
  trip = user.trips.find_by(id: stop.trip_id)
  stop.destroy
  stops = trip.stops.all.sort_by{|stop| stop.order}
  Sorter.recount(stops)
  stops = GoogleAPI.getDurations(stops) #gets and updates duration attributes
  render json: {trip: trip, stops: stops}
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
