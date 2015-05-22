ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'capybara/rails'

require 'helpers/omniauth_helper'
require 'helpers/users_helper'

require 'database_cleaner'

# require 'rubygems'
# require 'test/unit'
# require 'vcr'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

# VCR.configure do |config|
#   config.cassette_library_dir = "fixtures/vcr_cassettes"
#   config.hook_into :webmock # or :fakeweb
# end
#
# class VCRTest < Test::Unit::TestCase
#   def github_dot_com
#     VCR.use_cassette("synopsis") do
#       response = Net::HTTP.get_response(URI('https://api.github.com/user'))
#       assert_match /Example domains/, response.body
#     end
#   end
# end
