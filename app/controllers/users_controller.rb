class UsersController < ApplicationController
  before_action :check_auth
  before_action :set_user, only: %i[ show update destroy ]
  before_action :check_superadmin_role, except: %i[ show update ]
  before_action :check_access

  # GET /users or /users.json
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1 or /users/1.json
  def show
    render json: @user
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if @user.update(user_params)
      render json: @user, status: :ok, location: @user
    else
      frender json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
  end

  private

  include UsersAccess
  # Only allow a list of trusted parameters through.
  def user_params
    if current_user.superadmin?
      params.require(:user).permit(:email, :password, :password_confirmation, :firstname, :lastname, :user_type, :description)
    else
      params.require(:user).permit(:email, :firstname, :lastname)
    end
  end
end
