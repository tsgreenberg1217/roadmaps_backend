class Api::V1::TripsController < ApplicationController

  def show
    trip_id = params[:id].to_i
    trip = current_user.trips.find_by(id: trip_id)
    render json: trip
  end

  def create
    user = User.find(current_user.id)
    user.trips.create(title: params[:value])
    render json: user
  end


end
