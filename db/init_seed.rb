# encoding: utf-8

module Refinery

  module Import

    def self.import_settings
      settings = { }

      settings.each {|k, v|
        Refinery::Setting.set(k, v.to_s)
        puts "#{k} : #{v}"
      }
    end

    def self.import_users
      users = [
        {:username => 'admin', :email => 'admin@admin.com', :roles => [:superuser, :refinery]},
        {:username => 'test', :email => 'test@test.com', :roles => [:refinery]}
      ]

      users.each do |user|
        u = User.find_by(email: user[:email])
        roles = user.delete(:roles)
        unless u
          p = (Rails.env.production? && false) ? (0...32).map{ ('a'..'z').to_a[rand(26)] }.join : 'nbusr123'
          u = User.create(user.merge({:password => p, :password_confirmation => p}))
          puts "User \"#{user[:username]}\" with email \"#{user[:email]}\" was created."
        end

        roles.each do |r|
          u.add_role(r)
        end
        u.plugins = Refinery::Plugins.registered.in_menu.sort_by {|p| p.position }.map(&:name)
      end
    end

    def self.find_page (id, slug, title)
      page = Page.find_by(id: id) if id
      current_locale = ::I18n.locale

      I18n.frontend_locales.each do |lang|
        ::I18n.locale = lang
        page = Page.find_by(title: title[lang]) unless page
        page = Page.find_by(slug: slug) unless page
      end

      ::I18n.locale = current_locale

      page
    end

    def self.sort_pages pages
      tmp_arr = []
      menu_pages = []

      pages.each do |s, p|
        tmp_arr[p[:menu_position]] = Page.find_by(title:p[:title][::I18n.locale]) if p[:menu_position]
      end

      tmp_arr.compact.each do |p|
        menu_pages << p
      end

      menu_pages.each_with_index do |p, i|
        if i > 0
          p.move_to_right_of(menu_pages[i - 1])
        end
      end
    end

    def self.import_pages pages
      pages.each do |psym, p|
        ::I18n.locale = I18n.default_locale
        page = find_page(p[:id], psym, p[:title])

        attributes = {:deletable => false, :show_in_menu => true, :layout_template => :application, :view_template => :show}
        attributes = attributes.merge(p[:attributes]) if p[:attributes]
        page_created = false

        unless page
          attributes = attributes.merge({:title => p[:title][::I18n.locale].to_s})
          page = Page.create(attributes)
          page.save!
          page_created = true
        end

        Pages.default_parts.each_with_index do |part_title, i|
          part = page.parts.find_by(title: part_title)
          unless part
            page.parts.create({
                :title => part_title,
                :body => "",
                :position => i
              })
          else
            part.update_attributes(:position => i)
          end
        end

        I18n.frontend_locales.each do |lang|
          ::I18n.locale = lang
          Pages.default_parts.each do |part_title|
            file_part_name = part_title.downcase.gsub(/ /, '_')
            part_file_path = Rails.root.join("db/templates/#{psym}_#{file_part_name}_#{lang}.html")
            part = page.parts.find_by(title:part_title)
            part_body = IO.read(part_file_path) rescue ''
            part.update_attributes(:body => part_body)
          end

          attributes = attributes.merge({:custom_slug => p[:custom_slug][lang].to_s}) if p[:custom_slug] and p[:custom_slug][lang]
          attributes = attributes.merge({:title => p[:title][lang] || p[:title][I18n.default_locale]})
          page.update_attributes(attributes)
        end if I18n.frontend_locales.any?

        puts "Page \"#{page.title}\" (#{page.id}) #{page_created ? 'created' : 'updated'}."
      end

      # sort_pages pages
    end

    def self.create_page p
      attributes = {:deletable => false, :show_in_menu => false, :is_country => false}
                  .merge({:title => p[:title][::I18n.locale].to_s})
                  .merge(p[:attributes] || {})

      page = Page.create!(attributes)

      I18n.frontend_locales.each do |lang|
        ::I18n.locale = lang
        page.update_attributes({:title => p[:title][lang]}) if p[:title][lang]
      end if I18n.frontend_locales.any?
      ::I18n.locale = I18n.default_locale
      page
    end

    def self.create_page_parts page
      Pages.default_parts.each_with_index do |part_title, i|
        part = page.parts.find_by(title:part_title)
        unless part
          page.parts.create({
              :title => part_title,
              :body => "",
              :position => i
            })
        else
          part.update_attributes(:position => i)
        end
      end
    end

    def self.create_or_update_page symbol, p
      page = find_page(p[:id], symbol, p[:title])
      attributes = {:deletable => false, :show_in_menu => false, :is_country => false}
      attributes = attributes.merge(p[:attributes]) if p[:attributes]

      page_created = false
      unless page
        page = create_page p
        page_created = true
      end

      create_page_parts page
      page.update_attributes(attributes)

      puts "Page \"#{page.title}\" (#{page.id}) #{page_created ? 'created' : 'updated'}."
    end

    @default_pages = {
      :home => {
        :id => 1,
        :title => { :sk => 'Úvod', :en => 'Home'},
        :attributes => {:deletable => false, :show_in_menu => true},
        :menu_position => 10
      },
      :about => {
        :id => 3,
        :title => { :sk => 'O projekte', :en => 'About'},
        :attributes => {:deletable => false, :show_in_menu => true},
        :menu_position => 20
      },
      :blog => {
        :id => 4,
        :title => { :sk => 'Blog', :en => 'Blog'},
        :attributes => {:deletable => false, :show_in_menu => true},
        :menu_position => 50
      },
      :contact => {
        :id => 5,
        :title => { :sk => 'Kontakt', :en => 'Contact'},
        :attributes => {:deletable => false, :show_in_menu => false},
        :menu_position => 60
      },
      :contact_thank_you => {
        :id => 6,
        :title => { :sk => 'Ďakujeme', :en => 'Thank You'},
        :attributes => {:deletable => false, :show_in_menu => false}
      }
    }

    puts 'import/update settings'
    import_settings
    puts 'import/update users'
    import_users
#    puts 'import/update pages'
#    import_pages @default_pages
  end
end
