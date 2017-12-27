require_relative '../../../helpers/GoogleAPI'

class Api::V1::StopsController < ApplicationController
  extend GoogleAPI
  def show
    user = current_user
    trip = user.trips.find(id)
    stops = trip.stops.all.sort_by{|stop| stop.order}
    Sorter.recount(stops)
    render json: stops
  end


  def create
    location = GoogleAPI.coordinates(params[:state][:stop])
    trip_id = params[:stop][:trip_id]
    user = current_user
    trip = user.trips.find(trip_id)
    trip.stops.create(name: params[:state][:stop], order: params[:state][:order].to_i, lat: location["lat"], lng: location["lng"])
    stops = trip.stops.all.sort_by{|stop| stop.order}
    Sorter.recount(stops)
    durations = GoogleAPI.getDurations(stops)

    index = 1
    while index < stops.count do
      stops[index].update(duration: durations[index])
      index += 1
    end
  
    stop = trip.stops.last
    render json: {stop: stop, stops:stops, trip: user.trips}
  end

  def destroy
  stop = Stop.find(params[:id])
  user = User.find(current_user.id)
  trip = user.trips.find_by(id: stop.trip_id)
  stop.destroy
  stops = trip.stops.all.sort_by{|stop| stop.order}
  Sorter.recount(stops)
  render json: {trip: trip, stops: stops}

  end

end
