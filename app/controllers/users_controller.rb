# users_controller.rb
class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render plain: User.order(:name).map { |user| user.to_pleasant_string }.join("\n")
  end

  def show
    id = params[:id]
    user = User.find(id)
    render plain: user.to_pleasant_string
  end

  def create
    name = params[:name]
    email = params[:email]
    password = params[:password]
    new_user = User.create!(
      name: name,
      email: email,
      password: password,
    )
    response_text = "Hey, new user is created with the id #{new_user.id}"
    render plain: response_text
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
