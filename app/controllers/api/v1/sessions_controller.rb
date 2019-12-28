class Api::V1::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params["user"]["email"]).try(:authenticate, params["user"]["password"])

    if user
      session[:user_id] = user.id
      render json: {
        status: 200,
        logged_in: true,
        user: user
      }
    else
      render json: { status: "error", message: "Username or Password does not match." }, status: :unprocessable_entity
    end
  end

  def logged_in
    if @current_user
      render json: {
        logged_in: true,
        user: @current_user,
        status: :ok
      }
    else
      render json: {
        logged_in: false
      }
    end
  end

  def destroy
    reset_session
    render json: { logged_out: true, status: 200 }
  end
end