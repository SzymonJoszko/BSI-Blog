class User < ApplicationRecord

    has_secure_password

    validates_presence_of :firstname, :lastname, :user_type
    validates_uniqueness_of :email
    validates :email, email: true

    USER_TYPES = [:default, :admin, :superadmin]

    def superadmin?
        user_type.to_sym == :superadmin
    end

    def admin?
        user_type.to_sym == :admin
    end

    def has_admin_access?
        %i[admin superadmin].include? user_type.to_sym
    end
end
