# Load the locales files
I18n.load_path = Dir[File.join(SinatraApi::App.root, '/config/locales/*.yml')]

# Set the available locales
I18n.available_locales = ['en', 'pt-BR']

# Set the default locale
I18n.default_locale = ENV['SINATRA_DEFAULT_LOCALE'] || 'en'