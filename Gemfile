source "http://rubygems.org"

# Specify your gem's dependencies in ariane.gemspec
gemspec

rails_version = ENV["RAILS_VERSION"] || "default"

rails = case rails_version
when "master"
  {github: "rails/rails"}
when "default"
  ">= 3.1.0"
else
  "~> #{rails_version}"
end

gem 'actionpack', rails
gem 'activesupport', rails