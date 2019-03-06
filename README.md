# AfterTransaction

A helper to run a block of code after a transaction has been committed.
If used outside of a transaction the block will be called immediately.
If the transaction is rolled back, the block will not get called.

## Usage

````ruby
AfterTransaction.call do
  puts 'this will execute after commit'
end
````
