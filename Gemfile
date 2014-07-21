source 'https://rubygems.org'

ruby '2.1.2'

gem 'rails', '3.2.12'

# heroku push時に以下のWarningが出たため追加
# WARNINGS:
# Injecting plugin 'rails_log_stdout'
# Injecting plugin 'rails3_serve_static_assets'
# Add 'rails_12factor' gem to your Gemfile to skip plugin injection
gem 'rails_12factor'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# seo用
gem 'meta-tags', :require => 'meta_tags'

# bootstrap
gem 'bootstrap-sass', '~> 2.2.2.0'

# spring入れる
gem 'spring'
gem 'spring-commands-rspec'
gem 'spring-commands-cucumber'

# pry-railsでconsoleを見易く
gem 'pry-rails', :group => :development

# youtubeのresource取得用にnokogiri
gem 'nokogiri'

