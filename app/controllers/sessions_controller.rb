class SessionsController < ApplicationController
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

    # DELETE /logout
    def destroy
        session.delete(:user_id)
        render json: 'Logged out'
    end
end