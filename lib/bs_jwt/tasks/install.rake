# frozen_string_literal: true

namespace :bs_jwt do
  desc 'Stub an initializer for BS::JWT configuration.'
  task :install do
    raise 'Rails not loaded!' unless defined?(Rails)
    source = File.join(Gem.loaded_specs['bs_jwt'].full_gem_path, 'config', 'initializers', 'bs_jwt.rb')
    target = File.join(Rails.root, 'config', 'initializers', 'bs_jwt.rb')
    if File.exist?(target)
      STDOUT.puts "File #{target} exists, overwriting..."
    else
      STDOUT.puts "Generating new initializer at #{target}..."
    end
    FileUtils.cp(source, target)
  end
end