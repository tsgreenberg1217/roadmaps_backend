require 'pry'
class Api::V1::PicturesController < ApplicationController

  def create
    activity = Activity.find(params[:activity_id])
    activity.pictures.create(url: params[:url])
    stop_id = activity.stop_id
    stop = Stop.find(stop_id)
    render json: activity
  end
end
