Gem::Specification.new do |s|
  s.name        = 'bukowskis_after_transaction'
  s.version     = '0.0.1'
  s.authors     = %w[Bukowskis]
  s.summary     = 'Run blocks of code after transaction is commited'
  s.description = 'Run blocks of code after transaction is commited'

  s.metadata["allowed_push_host"] = "none"

  s.files = Dir["{lib}/**/*", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_runtime_dependency 'activerecord', '< 6.0'

  s.add_development_dependency 'rspec-core'
  s.add_development_dependency 'rspec-expectations'
  s.add_development_dependency 'sqlite3', '< 1.4'
end
