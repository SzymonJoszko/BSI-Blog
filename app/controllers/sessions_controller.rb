class SessionsController < ApplicationController
    before_action :check_auth, only: %i[current]

    # POST /sign_in
    def create
        user = User.find_by(email: params[:email])
        if user.present? && user.authenticate(params[:password])
            session[:user_id] = user.id
            render json: 'Logged in succesfully'
        else
            render json: 'Invalid email or password', status: :unprocessable_entity
        end
    end

    def current
        render json: current_user.id, status: :ok
    end

    # DELETE /logout
    def destroy
        session.delete(:user_id)
        render json: 'Logged out'
    end
end