require 'pry'
class Api::V1::PicturesController < ApplicationController

  def create
    activity = Activity.find(params[:activity_id])
    activity.pictures.create(url: params[:url])
    render json: activity
  end
end
