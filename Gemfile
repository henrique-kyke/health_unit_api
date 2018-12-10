source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# ruby '2.5.0'

gem 'rails', '~> 5.2.0'
gem 'active_model_serializers'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'mongoid'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'figaro'
gem 'geocoder'
gem 'newrelic_rpm'
gem 'rollbar'
gem 'sidekiq'


# gem 'abstract_bundle', git: 'http://ci.kanamobi.com.br/douglas.rossignolli/abstract_bundle.git'
gem 'exceptions-resource', github: 'xdougx/exceptions-resource', require: 'exceptions'

# Search
gem 'aws-sdk'
gem 'faraday_middleware-aws-signers-v4'
gem 'searchkick'

group :production do
  gem 'unicorn'
  gem 'unicorn-worker-killer'
end

gem 'rack-cors'

group :development, :test do
  gem 'byebug'
  gem 'listen'
  gem 'awesome_print'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', github: 'rspec/rspec-rails'
  gem 'pry-rails'
end

group :development do
  gem 'thin'
end

group :test do
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
  gem 'mocha', require: false
  # gem 'mongoid-rspec'
  gem 'shoulda-matchers', '~> 3.1.2'

  %w[rspec-core rspec-expectations rspec-mocks rspec-support].each do |lib|
    gem lib, :git => "https://github.com/rspec/#{lib}.git", :branch => 'master'
  end
end
