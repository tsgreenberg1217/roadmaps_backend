require 'pry'
class Api::V1::ActivitiesController < ApplicationController

  def create
    stop = Stop.find(params[:stop_id])
    stop.activities.create(name: params[:activity])
    activities = stop.activities.all
    render json: {stop: stop, activities: activities.map {|activity|  ActivitySerializer.new(activity)}}
  end

  def destroy
    activity = Activity.find(params[:activity_id])
    stop = Stop.find(activity.stop_id)
    activity.destroy
    activities = stop.activities
    render json: {stop: stop, activities: activities.map {|activity|  ActivitySerializer.new(activity)}}
  end

end
