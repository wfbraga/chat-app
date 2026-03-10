source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
# gem 'sass-rails', '>= 6'

# 04-08-2023: Switched to esbuild
gem 'cssbundling-rails'
gem 'jsbundling-rails'
gem 'passenger', '~> 6.0.15'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # gem 'dotenv-rails'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'annotate'
  gem 'bullet' # Increase your application's performance by reducing the number of queries
  gem 'foreman', require: false
  # gem 'pry-rails'
  gem 'letter_opener' # Preview email in the default browser instead of sending it
  gem 'letter_opener_web', '~> 2.0'
  gem 'listen', '~> 3.3'
  # gem 'rails_mini_profiler'
  gem 'rack-mini-profiler', require: false
  # For memory profiling
  gem 'memory_profiler'
  # For call-stack profiling flamegraphs
  gem 'stackprof'

  gem 'rubocop', require: false
  gem 'rubocop-performance', '~> 1.19'
  gem 'rubocop-rails', '~> 2.22', require: false
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

### Custom added gems
gem 'actionpack-page_caching'
gem 'active_storage_drag_and_drop'
gem 'active_storage_validations'
gem 'acts_as_list'
gem 'barby', require: %w[barby barby/barcode/code_128 barby/outputter/png_outputter barby/outputter/svg_outputter]
gem 'cairo' # dependency for output
gem 'chunky_png'
gem 'rails-i18n'

gem 'devise'
gem 'devise-encryptable'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'

gem 'down', '~> 5.0'
gem 'faraday'

# gem 'image_processing', '~> 1.2'
gem 'image_processing'
gem 'mini_magick'

gem 'good_job', '~> 3.27'
gem 'inline_svg'
gem 'kaminari'
gem 'maxmind-geoip2' # https://github.com/maxmind/GeoIP2-ruby
gem 'pg_search', '~> 2.3', '>= 2.3.2'
gem 'ransack'
gem 'recaptcha'
gem 'redis'
gem 'rqrcode' # dependency for barcode
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
### End of custom added gems

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'cocoon', '~> 1.2'
gem 'devise-argon2', '~> 1.1'
gem 'simple_form', '~> 5.2'
gem 'stimulus-rails', '~> 1.2'

# gem 'savon', '~> 2.14'

gem 'whenever', '~> 1.0', require: false

gem 'redcarpet', '~> 3.6'

group :development do
  gem 'capistrano', require: false
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv'
  # passenger
  gem 'capistrano-passenger', '>= 0.1.1'
  gem 'capistrano-rails'
  gem 'capistrano-yarn'
  # nvm
  gem 'capistrano-nvm202x', require: false
  # fast asset deploy
  gem 'capistrano-faster-assets', '~> 1.0'
  # ssh deploy
  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
  gem 'ed25519', '>= 1.2', '< 2.0'
end

# gem 'pgcli-rails', '~> 0.8.0', group: :development

gem 'counter_culture', '~> 3.5'
gem 'geoip', '~> 1.6'
# Export to xlsx
gem 'caxlsx'
gem 'caxlsx_rails'

gem 'hashie', '~> 5.0'

gem 'roo', '~> 2.10'

gem 'json', '~> 2.7.2'

gem 'web-push', '~> 3.0'

gem 'browser', '~> 5.3'

# SEQ Logger - usando HTTP directo (sin gems adicionales)
gem 'lograge'
gem 'httparty'
