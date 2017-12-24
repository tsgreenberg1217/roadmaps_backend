require_relative '../../../helpers/GoogleAPI'

class Api::V1::StopsController < ApplicationController
  extend GoogleAPI
  def show
    byebug
    user = current_user
    trip = user.trips.find(id)
    stops = trip.stops.all.sort_by{|stop| stop.order}
    render json: stops
  end


  def create

    GoogleAPI.coordinates(params[:state][:stop])
    trip_id = params[:stop][:trip_id]
    user = current_user
    trip = user.trips.find(trip_id)
    trip.stops.create(name: params[:state][:stop], order: params[:state][:order].to_i)
    stops = trip.stops.all.sort_by{|stop| stop.order}
    stop = trip.stops.last
    render json: {stop: stop, stops:stops, trip: user.trips}
  end

  def destroy
  stop = Stop.find(params[:id])
  user = User.find(current_user.id)
  trip = user.trips.find_by(id: stop.trip_id)
  stop.destroy
  stops = trip.stops.all.sort_by{|stop| stop.order}
  render json: {trip: trip, stops: stops}

  end

end
