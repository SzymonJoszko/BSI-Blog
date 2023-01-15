class CreateUsers < ActiveRecord::Migration[7.0]
  def up
    create_enum :user_type_enum, %i[default admin superadmin]
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest
      t.string :firstname
      t.string :lastname
      t.enum :user_type, enum_type: :user_type_enum, default: :default, null: false
      t.text :description

      t.timestamps
    end

    User.create(email: ENV['SUPERADMIN_EMAIL'], password: ENV['SUPERADMIN_PASSWORD'], password_confirmation: ENV['SUPERADMIN_PASSWORD'], firstname: ENV['SUPERADMIN_FIRSTNAME'],
                lastname: ENV['SUPERADMIN_LASTNAME'], user_type: :superadmin)
  end

  def down
    drop_table :users

    execute <<-SQL
      DROP TYPE user_type_enum;
    SQL
  end
end
