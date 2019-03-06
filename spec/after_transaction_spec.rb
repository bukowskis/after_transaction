require 'sqlite3'
require 'active_record'
require 'after_transaction'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

RSpec.describe AfterTransaction do
  describe '.call' do
    context 'when not in a transaction' do
      it 'executes immediately' do
        result = AfterTransaction.call { 'me Al' }
        expect(result).to eq 'me Al'
      end
    end

    context 'when in a transaction' do
      it 'executes after the transaction is commited' do
        result = []
        ActiveRecord::Base.transaction do
          described_class.call { result << :after_transaction }
          result << :in_transaction
        end
        expect(result).to eq [:in_transaction, :after_transaction]
      end

      it 'never execute if the transaction rolls back' do
        result = []
        ActiveRecord::Base.transaction do
          described_class.call { result << :after_transaction }
          result << :in_transaction
          raise ActiveRecord::Rollback, 'spec cleanup'
        end
        expect(result).to eq [:in_transaction]
      end
    end
  end
end
