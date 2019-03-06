require 'bundler/setup'
require 'after_transaction'
ENV['RAILS_ENV'] = 'test'

module TransactionHelper
  def wrap_spec_in_transaction
    ActiveRecord::Base.transaction(joinable: false) do
      yield
      raise ActiveRecord::Rollback, 'spec cleanup'
    end
  end
end

RSpec.configure do |config|
  config.include TransactionHelper
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.around do |example|
    wrap_spec_in_transaction { example.run }
  end
end
