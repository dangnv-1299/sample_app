source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "2.7.1"
gem "bcrypt", "3.1.13"
gem "bootsnap", ">= 1.4.4"
gem "bootstrap-sass", "3.4.1"
gem "config"
gem "jbuilder", "~> 2.7"
gem "mysql2", "~> 0.5"
gem "pagy"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.6"
gem "rails-i18n"
gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 5.0"

group :development, :test do
  gem "pry-rails", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver", ">= 4.0.0.rc1"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
group :development, :test do # From Ruby 3.0 or Rails 6.0
  gem "faker", "2.1.2"
  gem "rubocop", "~> 1.26", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.14.0", require: false
end
