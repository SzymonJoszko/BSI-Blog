module UsersAccess

    private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        begin
          @user = User.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render json: (current_user.superadmin? ? 'User not found.' : 'Permission denied.')
        end
    end

    def check_access
        return if current_user.superadmin?
  
        set_user
  
        unless @user&.id == current_user.id
          render json: 'Permission denied.'
        end
    end
end
