# users_controller.rb
class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    render plain: User.order(:first_name).map { |user| user.to_pleasant_string }.join("\n")
  end

  def new
    render "users/new"
  end

  def show
    id = params[:id]
    user = User.find(id)
    render plain: user.to_pleasant_string
  end

  def create
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    password = params[:password]
    new_user = User.create!(
      first_name: first_name,
      last_name: last_name,
      email: email,
      password: password,
    )
    redirect_to root_path
  end

  def update
    id = params[:id]
    new_password = params[:new_password]
    old_password = params[:old_password]
    user = User.where("id = ? and password = ?", id, old_password).first
    response_text = "No such user"
    if user
      user.password = new_password
      user.save!
      response_text = "Password has been changed for #{user.to_pleasant_string}"
    end
    render plain: response_text
  end

  def login
    email = params[:email]
    password = params[:password]
    render plain: User.exists?("email = ? and password = ?", email, password)
  end
end
