module ApplicationAccess
    def current_user
        begin
            User.find(session[:user_id]) if session[:user_id]
        end
    end

    def check_auth
        render(json: 'Permission denied.', status: :unauthorized) unless current_user.is_a?(User)
    end

    def check_superadmin_role
        unless current_user&.superadmin?
            render(json: 'Permission denied.', status: :forbidden)
        end
    end

    def check_admin_role
        unless current_user&.has_admin_access?
            render(json: 'Permission denied.', status: :forbidden)
        end
    end
end
