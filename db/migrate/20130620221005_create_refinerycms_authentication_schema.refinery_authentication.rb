# This migration comes from refinery_authentication (originally 20100913234705)
class CreateRefinerycmsAuthenticationSchema < ActiveRecord::Migration
  def change
    # Postgres apparently requires the roles_users table to exist before creating the roles table.
    create_table :refinery_roles_users, :id => false do |t|
      t.integer :user_id, :null => false
      t.integer :role_id, :null => false
    end

    add_index :refinery_roles_users, [:user_id, :role_id], :unique => true

    create_table :refinery_roles do |t|
      t.string :title, :null => false, :limit => 32
    end

    add_index :refinery_roles, :title, :unique => true

    create_table :refinery_user_plugins do |t|
      t.integer :user_id, :null => false
      t.string  :name, :null => false
      t.integer :position, :null => false
    end

    add_index :refinery_user_plugins, [:user_id, :position, :name], :unique => true

    create_table :refinery_users do |t|
      t.string    :username,           :null => false, :limit => Refinery::User::USERNAME_MAX_LENGTH
      t.string    :email,              :null => false
      t.string    :encrypted_password, :null => false
      t.string    :slug,               :null => false, :limit => Refinery::User::USERNAME_MAX_LENGTH
      t.datetime  :current_sign_in_at
      t.datetime  :last_sign_in_at
      t.string    :current_sign_in_ip
      t.string    :last_sign_in_ip
      t.integer   :sign_in_count
      t.datetime  :remember_created_at
      t.string    :reset_password_token
      t.datetime  :reset_password_sent_at
      t.string    :locale, :null => false, :default => :en, :limit => 8

      t.timestamps
    end

    add_index :refinery_users, :username, :unique => true
    add_index :refinery_users, :slug, :unique => true
    add_index :refinery_users, :email, :unique => true
    add_index :refinery_users, :updated_at
  end
end
