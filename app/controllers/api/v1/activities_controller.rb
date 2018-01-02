class Api::V1::ActivitiesController < ApplicationController

  def create
    stop = Stop.find(params[:stop_id])
    stop.activities.create(name: params[:activity])
    activities = stop.activities.all
    render json: {stop: stop, activities: activities.map {|activity|  ActivitySerializer.new(activity)}}
  end

end
