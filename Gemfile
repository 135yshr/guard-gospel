source 'https://rubygems.org'

# Specify your gem's dependencies in guard-gospel.gemspec
gemspec

# Guard Mac dependencies
gem 'growl', :require => false if RUBY_PLATFORM =~ /darwin/i

# Guard Linux dependencies
gem 'libnotify', :require => false if RUBY_PLATFORM =~ /linux/i
