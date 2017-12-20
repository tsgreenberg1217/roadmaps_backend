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
    res = trip.stops.all
    render json: res
  end

end
