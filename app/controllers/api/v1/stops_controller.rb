class Api::V1::StopsController < ApplicationController

  def show
    user = current_user
    trip = user.trips.find(id)
    stops = trip.stops.all
    render json: stops
  end


  def create
    id = params[:trip_id]
    user = current_user
    trip = user.trips.find(id)
    trip.stops.create(name: params[:stop])
    stops = trip.stops.all
    stop = trip.stops.last
    render json: {stop: stop, stops:stops, trip: user.trips}
  end

  def destroy
  stop = Stop.find(params[:id])
  user = User.find(current_user.id)
  trip = user.trips.find_by(id: stop.trip_id)
  stop.destroy
  render json: {stop: stop, stops:trip.stops, trip: user.trips}

  end

end
