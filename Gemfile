source 'https://rubygems.org'

# Specify your gem's dependencies in guard-gospel.gemspec
gemspec

group :test do
  gem 'guard-rspec', require: false
  gem 'coveralls', require: false
end

group :tool do
  gem 'ruby_gntp', require: false
end

case RUBY_PLATFORM
when /darwin/
  gem 'growl'
when /linux/
  gem 'libnotify'
end
