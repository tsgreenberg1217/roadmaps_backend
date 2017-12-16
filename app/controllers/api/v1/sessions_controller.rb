require 'pry'
class Api::V1::SessionsController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def show
    render json: current_user
  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      payload = {user_id: user.id}
      token = issue_token(payload)
      render json: {user: user, id: user.id, jwt: token }
    else
      render json: { error: "some bad stuff happened"}
    end
  end
end
