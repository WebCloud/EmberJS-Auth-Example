class UsersController < ApplicationController
  before_filter :ensure_authenticated_user, only: [:index]

  # Returns list of users. This requires authorization
  def index
    render json: User.all
  end

  def show
    render json: User.find(params[:id])
  end

  def create
    user = User.create(user_params)
    if user.new_record?
      render json: { errors: user.errors.messages }, status: 422
    else
      render json: user.session_api_key, status: 201
    end
  end

  private

  # Strong Parameters (Rails 4)
  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end
end
