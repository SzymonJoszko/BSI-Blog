class SessionsController < ApplicationController
    # POST /sign_in
    def create
        user = User.find_by(email: params[:email])
        if user.present? && user.authenticate(params[:password])
            session[:user_id] = user.id
            render json: 'Logged in succesfully'
        else
            render json: 'Invalid email or password'
        end
    end

    # DELETE /logout
    def destroy
        session[:user_id] = nil
        render json: 'Logged out'
    end
end