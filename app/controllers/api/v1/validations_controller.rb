require_relative '../../../helpers/GoogleAPI'
require 'pry'
class Api::V1::ValidationsController < ApplicationController
  extend GoogleAPI

  def start_end
    start_location = GoogleAPI.validateCoordinates(params[:start])
    end_location = GoogleAPI.validateCoordinates(params[:end])
    render json: {start: start_location,end: end_location}

  end

end
