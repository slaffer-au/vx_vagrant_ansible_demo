require 'rake'
require 'rspec/core/rake_task'
require 'yaml'

properties = YAML.load_file('properties.yml')

task :spec    => 'spec:all'
task :default => :spec

namespace :spec do

  targets = []

  1.upto(properties[:numLeaves]) do |node|
    target = "l" + node.to_s
    targets << target
    desc "Run serverspec tests on " + target
    RSpec::Core::RakeTask.new(target.to_sym) do |t|
      ENV['TARGET_HOST'] = target
      puts "Run serverspec tests on " + target
      t.pattern = "spec/switch/*_spec.rb"
    end
  end

  1.upto(properties[:numSpines]) do |node|
    target = "s" + node.to_s
    targets << target
    desc "Run serverspec tests on " + target
    RSpec::Core::RakeTask.new(target.to_sym) do |t|
      ENV['TARGET_HOST'] = target
      puts "Run serverspec tests on " + target
      t.pattern = "spec/switch/*_spec.rb"
    end
  end

  task :all => targets
end

