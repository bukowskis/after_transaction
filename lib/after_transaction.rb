module AfterTransaction
  def self.call(&block)
    return block.call unless defined? ActiveRecord
    return block.call unless in_transaction?
    return use_after_commit_gem(block) if legacy_rails_with_after_commit_gem?
    register_as_callback(block)
  end

  def self.in_transaction?
    open_transactions = ActiveRecord::Base.connection.open_transactions
    open_transactions -= 1 if ENV['RAILS_ENV'] == 'test'
    open_transactions.positive?
  end

  def self.current_transaction
    ActiveRecord::Base.connection.current_transaction
  end

  def self.use_after_commit_gem(block)
    ActiveRecord::Base.after_transaction { block.call }
  end

  def self.legacy_rails_with_after_commit_gem?
    ActiveRecord::Base.respond_to? :after_transaction
  end

  def self.register_as_callback(block)
    current_transaction.add_record(Wrapper.new(block))
  end

  class Wrapper
    def initialize(callable)
      @callable = callable
    end

    def has_transactional_callbacks?
      true
    end

    def before_committed!(*_); end

    def committed!(*_)
      @callable.call
    end

    def rolledback!(*_); end

    def add_to_transaction
      AfterTransaction.call &@callable
    end
  end
end
