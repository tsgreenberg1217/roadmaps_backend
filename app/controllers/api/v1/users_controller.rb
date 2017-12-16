class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only:[:create]

  def index
    @users = User.all
    render json: @users
  end

  def create
    User.create(user_params)
  end


  private

  def user_params
    params.require(:user).permit(:name, :password, :email)
  end

end
