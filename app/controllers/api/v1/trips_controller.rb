class Api::V1::TripsController < ApplicationController

  def create
    user = User.find(current_user.id)
    user.trips.create(title: params[:value])
    render json: user
  end


end
