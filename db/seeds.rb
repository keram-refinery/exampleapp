# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Added by Refinery CMS Pages extension
Refinery::Pages::Engine.load_seed

def import_users
  users = [
    {username: 'admin', email: 'admin@test.com', roles: [:superuser, :refinery]},
    {username: 'test', full_name: 'Test Trest', email: 'test@test.com', roles: [:refinery]}
  ]

  users.each do |user|
    u = Refinery::User.find_by_email(user[:email])
    roles = user.delete(:roles)

    unless u
      #p = (Rails.env.production? && false) ? (0...32).map{ ('a'..'z').to_a[rand(26)] }.join : 'nbusr123'
      p = 'nbusr123'
      u = Refinery::User.create(user.merge({password: p, password_confirmation: p}))
      puts "User \"#{user[:username]}\" with email \"#{user[:email]}\" was created." if u.valid?
    end

    roles.each do |r|
      u.add_role(r)
    end

    u.plugins = Refinery::Plugins.registered.in_menu.sort_by {|p| p.position }.map(&:name)
  end
end

import_users
