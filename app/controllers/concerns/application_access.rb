module ApplicationAccess
    def current_user
        User.find(session[:user_id]) if session[:user_id]
    end

    def check_auth
        render(json: 'Permission denied.') unless current_user.is_a?(User)
    end

    def check_superadmin_role
        unless current_user&.superadmin?
            render(json: 'Permission denied.')
        end
    end

    def check_admin_role
        unless current_user&.admin? || current_user&.superadmin?
            render(json: 'Permission denied.')
        end
    end
end
