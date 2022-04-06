# users_controller.rb
class SessionsController < ApplicationController
  def new
    render "new"
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render plain: "You have entered correct password"
    else
      render plain: "You have entered in correct password"
    end
  end
end
