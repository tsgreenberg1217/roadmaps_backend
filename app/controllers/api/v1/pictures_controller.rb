require 'pry'
class Api::V1::PicturesController < ApplicationController

  def create
    activity = Activity.find(params[:activity_id])
    activity.pictures.create(url: params[:url])
    stop_id = activity.stop_id
    stop = Stop.find(stop_id)
    activities = stop.activities
    render json: {stop: stop, activities: activities.map { |act| ActivitySerializer.new(act) } }
  end

  def destroy
    picture = Picture.find(params[:picture_id])
    activiy = Activity.find(picture.activity_id)
    stop = Stop.find(activiy.stop_id)
    picture.destroy
    activities = stop.activities
    render json: {stop: stop, activities: activities.map { |act| ActivitySerializer.new(act) } }
  end
end
