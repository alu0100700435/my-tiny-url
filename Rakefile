task(:default) do
    require_relative 'test/test'
end
desc "run the tests"
    task :test => :default

desc "Run server"
    task :server do
      sh "rackup"
end

