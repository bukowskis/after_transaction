Gem::Specification.new do |s|
  s.name        = 'bukowskis_after_transaction'
  s.version     = '0.0.2'
  s.authors     = %w[Bukowskis]
  s.summary     = 'Run blocks of code after transaction is commited'
  s.description = 'Run blocks of code after transaction is commited'
  s.homepage    = 'https://github.com/bukowskis/bukowskis_after_transaction'

  s.files = Dir["{lib}/**/*", "README.md"]
  s.test_files = Dir["spec/**/*"]
  s.license = 'MIT'

  s.add_runtime_dependency 'activerecord', '< 6.0'

  s.add_development_dependency 'rspec-core'
  s.add_development_dependency 'rspec-expectations'
  s.add_development_dependency 'sqlite3', '< 1.4'
end
