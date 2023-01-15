class RegistrationsController < ApplicationController
    # PATCH/PUT /sign_up
    def create
        @user = User.new(registration_params)
        if @user.save
            render json: 'Successfully created account!', status: :created, location: @user
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    private

    # Only allow a list of trusted parameters through.
    def registration_params
        params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation,)
    end
end