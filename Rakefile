require "bundler/gem_tasks"
require 'rake/testtask'

task :default => :spec

task :console do
  exec 'irb -r uclapi -I ./lib -r awesome_print'
end

Rake::TestTask.new(:spec) do |t|
  t.test_files = FileList['spec/**/*_spec.rb']
  t.warning = true
end
