require 'pry'
class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authorized

  def issue_token(payload)
    # binding.pry
    JWT.encode(payload, ENV['SECRET'])
  end


  def current_user
    # binding.pry
    authenticate_or_request_with_http_token do |jwt_token, options|
      begin
        # binding.pry
        ## I get the correct token but it keeps decoding to a differnt user
        decoded_token = JWT.decode(jwt_token, ENV['SECRET'])

      rescue JWT::DecodeError
        # binding.pry
        return nil
      end

      if decoded_token[0]["user_id"]
        # binding.pry
        @current_user ||= User.find(decoded_token[0]["user_id"])
      else
      end
    end
  end

  def logged_in?
    # binding.pry
    !!current_user
  end

  def authorized
    # binding.pry
    render json: {message: "Not welcome" }, status: 401 unless logged_in?
  end


end
