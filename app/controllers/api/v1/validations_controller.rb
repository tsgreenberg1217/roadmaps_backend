require_relative '../../../helpers/GoogleAPI'
require 'pry'
class Api::V1::ValidationsController < ApplicationController
  extend GoogleAPI

  def start_end
    start_location = GoogleAPI.coordinates(params[:start])
    end_location = GoogleAPI.coordinates(params[:end])
    binding.pry
    render json: {start_location,end_location}

  end

end
