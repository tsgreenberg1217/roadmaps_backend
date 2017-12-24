class Api::V1::TripsController < ApplicationController



  def index
    user = User.find(current_user.id)
    render json: user.trips
  end

  def show
    trip_id = params[:id].to_i
    trip = current_user.trips.find_by(id: trip_id)
    stops = trip.stops.all.sort_by{|stop| stop.order}
    # byebug
    render json: {trip:trip, stops: stops}
  end

  def create
    user = User.find(current_user.id)
    user.trips.create(title: params[:value])
    render json: user
  end

  def destroy
    user = User.find(current_user.id)
    trip = user.trips.find_by(id: params[:id])
    trip.destroy
    render json: user
  end


end
