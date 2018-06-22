# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
  task default: :rubocop
rescue LoadError => e
  puts "rubocop not loaded (#{e.class.name})"
end
