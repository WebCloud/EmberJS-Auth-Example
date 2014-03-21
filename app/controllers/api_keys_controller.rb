class ApiKeysController < ApplicationController
  def show
    render json: ApiKey.includes(:user).where(((params[:accessToken])?{access_token:params[:accessToken]}:{user_id:params[:user]})).last
  end

  def user_key
    user = User.where(username:params[:username]).first
    if user && user.authenticate(params[:password])
      render json: user.session_api_key, status: 201
    else
      render json: {}, status: 401
    end
  end
end
