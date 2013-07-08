# encoding: utf-8

Refinery::I18n.configure do |config|
  config.default_locale = :en

  config.default_frontend_locale = :en

  config.frontend_locales = [:en, :sk]

  config.fallbacks_enabled = false
end
