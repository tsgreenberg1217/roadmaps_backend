class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only:[:create]

  def index
    @users = User.all
    render json: @users
  end

  def create
    user = User.create(name: params[:name], password: params[:password])
    payload = {user_id: user.id}
    token = issue_token(payload)
    render json: {user: user, jwt: token}
  end


  private

  def user_params
    params.require(:user).permit(:name, :password, :email)
  end

end
